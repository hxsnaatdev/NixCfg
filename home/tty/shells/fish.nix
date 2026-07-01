{pkgs, ...}: {
  programs.fish = {
    enable = true;
    packages = pkgs.fish;

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
          rev = "v4.4.8";
          hash = pkgs.lib.fakeHash;
        };
      }

      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair";
          rev = "v1.0.4";
          hash = pkgs.lib.fakeHash;
        };
      }

      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "v0.1.1";
          hash = pkgs.lib.fakeHash;
        };
      }
    ];
  };
}
