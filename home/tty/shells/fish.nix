{pkgs, ...}: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    interactiveShellInit = ''
      set -g fish_vi_force_cursor 1
      set -g fish_cursor_default block
      set -g fish_cursor_visual block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore
      # Yank to system clipboard
      bind -M visual y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
      bind -M normal yy 'commandline | fish_clipboard_copy'
      bind -M normal Y 'commandline | fish_clipboard_copy'
      bind -M normal p 'commandline -i (fish_clipboard_paste)'

      atuin init fish | source
      set -x HOMEBREW_NO_ENV_HINTS 1
    '';

    shellAbbrs = {
      nv = "nvim";
      v = "vim";
    };
    functions = {
      y = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
              builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
    };

    plugins = [
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "a04308be92daa6cfecdbb0ca58b1e8508664cff2";
          hash = "sha256-1fvd4q916xk152ddyzbr9avw550v07i11a5s6977nhcf87avpzj9=";
        };
      }

      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "244bb1ebf74bf944a1ba1338fc1026075003c5e3";
          hash = "sha256-0mfx43n3ngbmyfp4a4m9a04gcgwlak6f9myx2089bhp5qkrkanmk=";
        };
      }

      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "v0.1.1";
          hash = "sha256-18cvhvdc0dg3kvdg1a1y2hgmya4kcbxpknxhsl61gwm33qrki4d7=";
        };
      }
    ];
  };
}
