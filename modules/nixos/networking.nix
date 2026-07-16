{
  networking.networkmanager.enable = true;

  # Wifi/bluetooth chips generally need redistributable-licensed firmware
  # blobs (e.g. from linux-firmware) to work at all.
  hardware.enableRedistributableFirmware = true;
}
