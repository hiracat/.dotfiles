require("image").setup({
	backend = "kitty",
	-- IMPORTANT: no flat max_width/max_height here — that's a hard cap in
	-- terminal cells that overrides everything else, which is why sizing
	-- wasn't working. Leave these nil and control size per-instance instead.
	max_width = nil,
	max_height = nil,
	max_width_window_percentage = nil,
	max_height_window_percentage = nil,
	window_overlap_clear_enabled = true,
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
})

local image_api = require("image")

-- one preview slot per telescope preview buffer, so repeated previews
-- against the same scratch buffer reuse/clear the same registry id
local PREVIEW_ID_PREFIX = "telescope_preview_"
local watched_bufs = {}

local function clear_preview(bufnr)
	if bufnr then
		image_api.clear(PREVIEW_ID_PREFIX .. bufnr)
	end
end

local function is_image(path)
	local image_extensions = { "png", "jpg", "jpeg", "gif", "webp", "avif", "bmp" }
	local split_path = vim.split(path:lower(), ".", { plain = true })
	local extension = split_path[#split_path]
	return vim.tbl_contains(image_extensions, extension)
end

require("telescope").setup({
	defaults = {
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				-- fully clear whatever was in this preview slot (registry clear,
				-- not just a shallow/visual clear) before drawing the next one
				clear_preview(bufnr)

				if not is_image(filepath) then
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"Binary cannot be previewed"
					)
					return
				end

				-- clean up automatically when telescope closes and wipes this
				-- scratch buffer, instead of a blanket WinClosed autocmd
				if not watched_bufs[bufnr] then
					watched_bufs[bufnr] = true
					vim.api.nvim_create_autocmd("BufWipeout", {
						buffer = bufnr,
						once = true,
						callback = function()
							clear_preview(bufnr)
							watched_bufs[bufnr] = nil
						end,
					})
				end

				local win_width = vim.api.nvim_win_get_width(opts.winid)
				local win_height = vim.api.nvim_win_get_height(opts.winid)

				-- small defer to dodge a known upstream race where the very
				-- first render of an image can beat the async transform/dimension
				-- pipeline (see 3rd/image.nvim#183) — not a guaranteed fix, but helps
				vim.defer_fn(function()
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end

					local image = image_api.from_file(filepath, {
						id = PREVIEW_ID_PREFIX .. bufnr,
						window = opts.winid,
						buffer = bufnr,
						width = win_width,
						height = win_height,
						x = 0,
						y = 0,
						-- bypass the (now-removed) global cap for this instance too,
						-- in case setup() options get changed later
						ignore_global_max_size = true,
					})

					if not image then
						return
					end

					image:render()

					-- best-effort centering: image.nvim preserves aspect ratio and
					-- may draw smaller than the requested box, so nudge using the
					-- box we asked for vs the image's own reported dimensions once
					-- it's available. rendered_geometry may not be populated
					-- synchronously — this is why "centering" is best-effort here.
					vim.defer_fn(function()
						if not image.rendered_geometry then
							return
						end
						local rw = image.rendered_geometry.width or win_width
						local rh = image.rendered_geometry.height or win_height
						local x = math.max(math.floor((win_width - rw) / 2), 0)
						local y = math.max(math.floor((win_height - rh) / 2), 0)
						image:move(x, y)
					end, 50)
				end, 10)
			end,
		},
	},
})
