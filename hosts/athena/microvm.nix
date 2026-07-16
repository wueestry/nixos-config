# Enables athena to host declarative MicroVMs and gives their tap
# interfaces a private, NAT'd network — independent of the physical wifi
# link, since bridging a wifi NIC directly isn't practical.
{ inputs, ... }:

{
  imports = [ inputs.microvm.nixosModules.host ];

  microvm.vms."example-vm".flake = inputs.self;

  systemd.network.enable = true;

  systemd.network.netdevs."br-vms".netdevConfig = {
    Name = "br-vms";
    Kind = "bridge";
  };

  systemd.network.networks."10-br-vms" = {
    matchConfig.Name = "br-vms";
    networkConfig = {
      Address = [ "192.168.100.1/24" ];
      IPMasquerade = "ipv4";
      ConfigureWithoutCarrier = true;
    };
    linkConfig.RequiredForOnline = "no";
  };

  systemd.network.networks."10-vm-taps" = {
    matchConfig.Name = "vm-*";
    networkConfig.Bridge = "br-vms";
  };

  # NetworkManager handles the physical wifi link; keep it away from the
  # bridge and VM tap interfaces.
  networking.networkmanager.unmanaged = [ "interface-name:br-vms" "interface-name:vm-*" ];
}
