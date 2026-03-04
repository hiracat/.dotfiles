require("catppuccin").setup({
	custom_highlights = function(colors)
		return {
			LineNr = { fg = colors.subtext1 },
		}
	end,
	color_overrides = {
		mocha = {
			-- Surfaces - use the full container ladder for proper depth
			base = "{{colors.background.default.hex}}",
			mantle = "{{colors.surface_container_lowest.default.hex}}",
			crust = "{{colors.surface_container_low.default.hex}}",
			surface0 = "{{colors.surface_container.default.hex}}",
			surface1 = "{{colors.surface_container_high.default.hex}}",
			surface2 = "{{colors.surface_container_highest.default.hex}}",

			-- Text
			text = "{{colors.on_surface.default.hex}}",
			subtext1 = "{{colors.on_surface_variant.default.hex}}",
			subtext0 = "{{colors.on_surface_variant.default.hex | to_color | set_lightness: 55}}",

			-- Overlays/comments - dim and desaturated
			overlay2 = "{{colors.outline.default.hex}}",
			overlay1 = "{{colors.outline_variant.default.hex}}",
			overlay0 = "{{colors.outline_variant.default.hex | to_color | set_lightness: 38}}",

			-- Blues/purples - keep close to primary hue but push toward correct hues
			lavender = "{{colors.primary.default.hex | to_color | set_lightness: 80}}",
			blue = '{{colors.primary.default.hex | to_color | harmonize: {{ "#89b4fa" | to_color }} | set_lightness: 75}}',
			sapphire = '{{colors.secondary.default.hex | to_color | harmonize: {{ "#74c7ec" | to_color }} | set_lightness: 75}}',
			sky = '{{colors.tertiary.default.hex | to_color | harmonize: {{ "#89dceb" | to_color }} | set_lightness: 78}}',

			-- Teal - types, harmonize toward cyan
			teal = '{{colors.tertiary.default.hex | to_color | harmonize: {{ "#94e2d5" | to_color }} | set_lightness: 75}}',

			-- Green - strings, harmonize source color toward catppuccin green
			green = '{{colors.source_color.default.hex | to_color | harmonize: {{ "#a6e3a1" | to_color }} | set_hue: 120 | set_lightness: 72 | saturate: 35.0, "hsl"}}',

			-- Yellow - functions/classes
			yellow = '{{colors.source_color.default.hex | to_color | harmonize: {{ "#f9e2af" | to_color }} | set_hue: 52 | set_lightness: 78 | saturate: 55.0, "hsl"}}',

			-- Peach - numbers/constants, harmonize toward orange
			peach = '{{colors.source_color.default.hex | to_color | harmonize: {{ "#fab387" | to_color }} | set_hue: 28 | set_lightness: 75 | saturate: 60.0, "hsl"}}',

			-- Red - errors
			red = "{{colors.error.default.hex | to_color | set_lightness: 72}}",
			maroon = "{{colors.error.default.hex | to_color | set_lightness: 65}}",

			-- Pink - keywords, harmonize primary toward catppuccin pink
			pink = '{{colors.primary.default.hex | to_color | harmonize: {{ "#f38ba8" | to_color }} | set_hue: 316 | set_lightness: 78 | saturate: 45.0, "hsl"}}',

			-- Mauve - builtins/constructors, primary hue
			mauve = "{{colors.primary.default.hex | to_color | set_lightness: 72}}",

			-- Flamingo/rosewater - misc warm accents
			flamingo = '{{colors.tertiary.default.hex | to_color | harmonize: {{ "#f2cdcd" | to_color }} | set_hue: 340 | set_lightness: 78}}',
			rosewater = '{{colors.tertiary.default.hex | to_color | harmonize: {{ "#f5e0dc" | to_color }} | set_hue: 350 | set_lightness: 82}}',
		},
	},
})
