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
  col = config.stylix.base16Scheme;
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
          "[](${col.base01})"
          "$python"
          "$username"
          "[](bg:${col.base02} fg:${col.base01})"
          "$directory"
          "[](fg:${col.base02} bg:${col.base03})"
          "$git_branch"
          "$git_status"
          "[](fg:${col.base03} bg:${col.base0A})"
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
          "[](fg:${col.base0A} bg:${col.base0E})"
          "$docker_context"
          "[](fg:${col.base0E} bg:${col.base09})"
          "$time"
          "[ ](fg:${col.base09})"
        ];
        username = {
          show_always = true;
          style_user = "bg:${col.base01}";
          style_root = "bg:${col.base01}";
          format = "[$user ]($style)";
        };
        directory = {
          style = "bg:${col.base02}";
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
          style = "bg:${col.base0A}";
          format = " $symbol ($version) ]($style)";
        };

        docker_context = {
          symbol = " ";
          style = "bg:${col.base0E}";
          format = "[ $symbol $context ]($style) $path";
        };

        elixir = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        elm = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        git_branch = {
          symbol = "";
          style = "bg:${col.base03}";
          format = "[ $symbol $branch ]($style)";
        };

        git_status = {
          style = "bg:${col.base03}";
          format = "[$all_status$ahead_behind ]($style)";
        };

        golang = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        haskell = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        julia = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        nim = {
          symbol = " ";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        python = {
          style = "bg:${col.base01}";
          format = "[(\($virtualenv\) )]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:${col.base0A}";
          format = "[ $symbol ($version) ]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:${col.base09}";
          format = "[ $time ]($style)";
        };
      };
    };
  };
}
