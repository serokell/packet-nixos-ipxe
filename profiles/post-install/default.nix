{ lib, ... }:

{
  boot.loader.grub = {
    enable = lib.mkDefault true;
    version = lib.mkDefault 2;
    extraConfig = ''
      serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
      terminal_output serial console
      terminal_input serial console
    '';
  };

  fileSystems."/" = {
    fsType = "btrfs";
    label = "root";
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault true;

  services.btrfs.autoScrub = {
    enable = lib.mkDefault true;
    fileSystems = [ "/" ];
  };

  services.fstrim.enable = lib.mkDefault true;

  services.openssh.enable = lib.mkDefault true;
}
