# Graphical boot splash (Plymouth) that also themes the LUKS decryption
# prompt: the LUKS device is already in the initrd (see hardware-config),
# and the NixOS module wires systemd-ask-password-plymouth into the
# systemd-based initrd, so the password dialog renders on the splash.
{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;

    # Themed splash. bgrt (the default) is the safest with the EFI/NVIDIA
    # framebuffer; uncomment to use a custom theme instead.
    # theme = "rings";
    # themePackages = [
    #   (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "rings" ]; })
    # ];

    # HiDPI: the Yoga panel is high-resolution.
    extraConfig = ''
      [Daemon]
      DeviceScale=2
    '';
  };

  # "Silent boot": keep the console quiet so the splash stays clean.
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];

  # Hide the bootloader menu unless a key is pressed.
  boot.loader.timeout = 0;
}
