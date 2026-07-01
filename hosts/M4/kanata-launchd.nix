{...}: {
  launchd.daemons.Kanata-local = {
    script = "/Users/ariz/.config/keyboard/kanata/executables/macos-binaries-arm64/kanata_macos_cmd_allowed_arm64 --nodelay --cfg /Users/ariz/.config/keyboard/kanata/ariz.kbd";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      Nice = -19;
    };
  };

  launchd.user.agents.Kanata-tray-local = {
    command = "sudo --preserve-env /Users/ariz/.config/keyboard/kanata/executables/kanata-tray/kanata-tray-macos";
    serviceConfig = {
      RunAtLoad = true;
      keepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      Nice = -19;
    };
  };
}
