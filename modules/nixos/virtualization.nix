{ settings, pkgs, ... }: {

  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
  };
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  users.users.${settings.username}.extraGroups = [ "libvirtd" "input" ];
}
