{ settings, pkgs, pkgs-stable, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/appearance.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/ime.nix
    ../../modules/nixos/periferals.nix
    ../../modules/nixos/software.nix
    ../../modules/nixos/resolve.nix

    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/syncthing.nix
  ];

  base = {
    username = settings.username;
    hostname = "nixos-desktop";
  };

  networking.interfaces."enp4s0".wakeOnLan.enable = true;

  hardware.amdgpu.opencl.enable = true;

  periferals.drawingTablet.enable = true;

  systemd.user.services.wayvnc = {
    description = "wayvnc VNC server";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.wayvnc}/bin/wayvnc";
      Restart = "on-failure";
    };
  };

  environment.systemPackages = with pkgs; [
    (blender.override {
      rocmSupport = true;
      cudaSupport = false;

    })
  ] ++ [
    pkgs-stable.bambu-studio
    (pkgs-stable.renderdoc.overrideAttrs (oldAttrs: rec {
      cmakeFlags = oldAttrs.cmakeFlags or [ ] ++ [
        "-DENABLE_UNSUPPORTED_EXPERIMENTAL_POSSIBLY_BROKEN_WAYLAND=ON"
      ];
    }))
  ];

  fileSystems."/run/media/forest/backups" = {
    device = "/dev/disk/by-uuid/26975e28-ef0a-4681-8e45-5c0af5da170a";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults"
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "x-gvfs-show" # snow drive in fileexplorer
    ];
  };
  fileSystems."/run/media/forest/random_data" = {
    device = "/dev/disk/by-uuid/4f1790d6-78dd-41c7-ba2d-5b24f3f5848f";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults"
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "x-gvfs-show" # snow drive in fileexplorer
      # allow exec so steam can use drive
      "exec"
    ];
  };
  systemd = {
    services.gpp0disable = {
      description = "fixes gpp0 waking up system, and breaking sleep";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''/bin/sh -c "if grep -q '^GPP0.*\\*enabled' /proc/acpi/wakeup; then echo Disabling GPP0; echo GPP0 | tee /proc/acpi/wakeup; else echo GPP0 already disabled; fi" '';
      };
    };
  };
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      ffmpeg = pkgs.ffmpeg-full;
    };
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
      droidcam-obs
    ];
    enableVirtualCamera = true;
  };



  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  services = {
    syncthingSync = {
      enable = true;
      username = settings.username;
      devices = {
        server = "IBSKWS6-RSVTTNQ-7BYL3UU-HX4W3AO-TYH5QGQ-BRE5556-743ZJVD-TYHSPQW";
        laptop = "VZOYB44-PL3RROB-ZXQAYVC-GEPOXOK-ISOGJ26-CRZ6BBU-4HMTIML-6LHENQU";
      };
      folders = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".local/share/PrismLauncher"
        ".dotfiles"
      ];
    };
  };
}
