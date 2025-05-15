{ config, pkgs, ... }:
{

  home.packages =
    with pkgs;

    [

    ];

  # https://github.com/malob/nixpkgs/blob/0ba8facf583289f922ddb59ef1ea1f4b8e9f5059/home/kitty.nix
  # https://github.com/LamprosPitsillos/nixos-config/tree/main/home-manager/programs/terminal
  # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.kitty.enable
  # https://sw.kovidgoyal.net/kitty/shell-integration/

  programs.bash = {
    enable = true;
  };

  programs.bash.shellAliases = {
    nswitch = "sudo nixos-rebuild switch --flake . --impure";
    nsgc = "sudo nix-store --gc";
    ngc = "sudo nix-collect-garbage -d";
    ngc7 = "sudo nix-collect-garbage --delete-older-than 7d";
    ngc14 = "sudo nix-collect-garbage --delete-older-than 14d";
  };

  programs.kitty =
    let
      font_family = "JetBrainsMono NF";
    in
    {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = font_family;
        size = 13;
      };

      keybindings = {
        "kitty_mod+s" = "paste_from_clipboard";
        "kitty_mod+v" = "paste_from_selection";
        "alt+shift+enter" = "clone-in-kitty --type=os-window";
      };
      extraConfig = ''
        modify_font underline_position 2
        modify_font underline_thickness 200%

        modify_font cell_width 100%
        modify_font cell_height -1px


      '';

      settings = {
        bold_font = "${font_family} Bold";
        italic_font = "${font_family} Italic";
        bold_italic_font = "${font_family} Bold Italic";

        disable_ligatures = "cursor";
        copy_on_select = true;

        # fuck sounds
        enable_audio_bell = false;
        window_alert_on_bell = false;
        bell_on_tab = false;
        window_margin_width = 0;
        background_opacity = 0.85;

        adjust_line_height = "130%";

        # Window layout
        hide_window_decorations = "titlebar-only";
        window_padding_width = "10";

        # Tab bar
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_title_template = "Tab {index}: {title}";
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";
        tab_activity_symbol = "";

        allow_remote_control = "socket-only";
        listen_on = "unix:/tmp/kitty";
      };

      shellIntegration.enableBashIntegration = true;
      shellIntegration.mode = "enabled";
      themeFile = "OneHalfDark";

      # https://github.com/kovidgoyal/kitty-themes/tree/master/themes

      #        env.TERM = "xterm-256color";

    };

  programs.ghostty = {
    enable = true;

    settings = {
      alpha-blending = "linear-corrected";
      background-opacity = "0.95";
      background-blur = true;
      window-decoration = "none";
      theme = "tokyonight";
      font-size = 13;
      #      window-decoration = false;
      window-theme = "ghostty";
      # window-theme = "dark";

      #      keybind = [
      #        "ctrl+h=goto_split:left"
      #        "ctrl+l=goto_split:right"
      #      ];
    };

  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.wezterm = {
    enable = true;


  };





  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      lua.disabled = true;
      python.disabled = true;
      golang.disabled = true;
      rlang.disabled = true;
      rust.disabled = true;

    };
  };

}
