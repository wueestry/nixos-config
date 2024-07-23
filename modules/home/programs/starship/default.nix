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
          "[](#${config.stylix.base16Scheme.base01})"
          "$python"
          "$username"
          "[](bg:#${config.stylix.base16Scheme.base02} fg:#${config.stylix.base16Scheme.base01})"
          "$directory"
          "[](fg:#${config.stylix.base16Scheme.base02} bg:#${config.stylix.base16Scheme.base03})"
          "$git_branch"
          "$git_status"
          "[](fg:#${config.stylix.base16Scheme.base03} bg:#${config.stylix.base16Scheme.base0A})"
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
          "[](fg:#${config.stylix.base16Scheme.base0A} bg:#${config.stylix.base16Scheme.base0E})"
          "$docker_context"
          "[](fg:#${config.stylix.base16Scheme.base0E} bg:#${config.stylix.base16Scheme.base09})"
          "$time"
          "[ ](fg:#${config.stylix.base16Scheme.base09})"
        ];
        username = {
          show_always = true;
          style_user = "bg:#${config.stylix.base16Scheme.base01}";
          style_root = "bg:#${config.stylix.base16Scheme.base01}";
          format = "[$user ]($style)";
        };
        directory = {
          style = "bg:#${config.stylix.base16Scheme.base02}";
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
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = " $symbol ($version) ]($style)";
        };

        docker_context = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0E}";
          format = "[ $symbol $context ]($style) $path";
        };

        elixir = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        elm = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        git_branch = {
          symbol = "";
          style = "bg:#${config.stylix.base16Scheme.base03}";
          format = "[ $symbol $branch ]($style)";
        };

        git_status = {
          style = "bg:#${config.stylix.base16Scheme.base03}";
          format = "[$all_status$ahead_behind ]($style)";
        };

        golang = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        haskell = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        julia = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        nim = {
          symbol = " ";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        python = {
          style = "bg:#${config.stylix.base16Scheme.base01}";
          format = "[(\($virtualenv\) )]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:#${config.stylix.base16Scheme.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#${config.stylix.base16Scheme.base09}";
          format = "[ $time ]($style)";
        };
      };
    };
  };
}
