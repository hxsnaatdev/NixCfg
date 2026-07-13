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
      b = "btop";
      nv = "nvim";
      v = "vim";
      zz = "zellij";
      op = "opencode";
      lg = "lazygit";
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
          hash = "sha256-Sf671UGOQXtOMrqoEOIBG5TCt0p5fd+aKGF2ExImbbs=";
        };
      }

      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "244bb1ebf74bf944a1ba1338fc1026075003c5e3";
          hash = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
        };
      }

      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "v0.1.1";
          hash = "sha256-p5E4Mx6j8hcM1bDbeftikyhfHxQ+qPDanuM1wNqGm6E=";
        };
      }
    ];
  };
}
