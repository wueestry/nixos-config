{ ... }:
{
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };
}
