{
  imports = [
    ../../modules/home-manager
  ];

  home.username = "ryan";
  home.homeDirectory = "/home/ryan";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
