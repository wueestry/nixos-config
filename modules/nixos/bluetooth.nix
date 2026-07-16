{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Fallback tray applet/manager in case noctalia-shell's own bluetooth
  # widget doesn't cover what you need.
  services.blueman.enable = true;
}
