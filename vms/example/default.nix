# Template MicroVM. Copy this directory (and add an entry in flake.nix +
# microvm.vms on the host) to start a new isolated per-app VM. This one is
# headless — add waypipe/virtio-gpu wiring separately if you want a VM's
# GUI to show up on the host desktop.
{ ... }:

{
  networking.hostName = "example-vm";

  microvm = {
    vcpu = 2;
    mem = 1024;
    hypervisor = "qemu";

    interfaces = [
      {
        type = "tap";
        id = "vm-example";
        mac = "02:00:00:00:00:01";
      }
    ];

    volumes = [
      {
        image = "example-vm.img";
        mountPoint = "/var";
        size = 2048;
      }
    ];

    shares = [
      {
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        tag = "ro-store";
        proto = "virtiofs";
      }
    ];
  };

  systemd.network.enable = true;
  systemd.network.networks."20-lan" = {
    matchConfig.Type = "ether";
    networkConfig = {
      Address = [ "192.168.100.2/24" ];
      Gateway = "192.168.100.1";
      DNS = [ "1.1.1.1" ];
      DHCP = "no";
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "26.05";
}
