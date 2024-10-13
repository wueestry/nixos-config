{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.starship;
  stylix = config.lib.stylix.colors;
in {
  options.${namespace}.programs.starship = with types; {
    enable = mkBoolOpt false "Enable starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        command_timeout = 5000;
        format = concatStrings [
          "[](#${stylix.base01})"
          "$python"
          "$username"
          "[](bg:#${stylix.base02} fg:#${stylix.base01})"
          "$directory"
          "[](fg:#${stylix.base02} bg:#${stylix.base03})"
          "$git_branch"
          "$git_status"
          "[](fg:#${stylix.base03} bg:#${stylix.base0A})"
          "$c"
          "$elixir"
          "$elm"
          "$golang"
          "$haskell"
          "$java"
          "$julia"
          "$nodejs"
          "$nim"
          "$rust"
          "[](fg:#${stylix.base0A} bg:#${stylix.base0E})"
          "$docker_context"
          "[](fg:#${stylix.base0E} bg:#${stylix.base09})"
          "$time"
          "[ ](fg:#${stylix.base09})"
        ];
        username = {
          show_always = true;
          style_user = "bg:#${stylix.base01}";
          style_root = "bg:#${stylix.base01}";
          format = "[$user ]($style)";
        };
        directory = {
          style = "bg:#${stylix.base02}";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };

        c = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = " $symbol ($version) ]($style)";
        };

        docker_context = {
          symbol = " ";
          style = "bg:#${stylix.base0E}";
          format = "[ $symbol $context ]($style) $path";
        };

        elixir = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        elm = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        git_branch = {
          symbol = "";
          style = "bg:#${stylix.base03}";
          format = "[ $symbol $branch ]($style)";
        };

        git_status = {
          style = "bg:#${stylix.base03}";
          format = "[$all_status$ahead_behind ]($style)";
        };

        golang = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        haskell = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        julia = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        nim = {
          symbol = " ";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        python = {
          style = "bg:#${stylix.base01}";
          format = "[(\($virtualenv\) )]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:#${stylix.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#${stylix.base09}";
          format = "[ $time ]($style)";
        };
      };
    };
  };
}
