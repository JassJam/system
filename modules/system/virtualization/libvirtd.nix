{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-libvirtd = config.system.virtualization.libvirtd;
in
{
  options.system.virtualization.libvirtd = {
    enable = lib.mkEnableOption "Enable Libvirt virtualization for managing virtual machines.";
  };

  config = lib.mkIf cfg-libvirtd.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    users.users.${userName}.extraGroups = [
      "libvirtd"
    ];

    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        virt-manager
        virt-viewer
        spice
        spice-gtk
        spice-protocol
        virtio-win
        win-spice
        qemu
      ];
    };
  };
}
