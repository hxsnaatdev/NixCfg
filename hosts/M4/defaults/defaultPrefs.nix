{
  config,
  lib,
  pkgs,
  ...
}: {
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = 1.75;
    };
    "dock" = {
      autohide = true;
      autohide-delay = 0.0;
    };

    NSGlobalDomain = {
      #keyboard
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.swipescrolldirection" = true; # natural scrolling
      "com.apple.trackpad.scaling" = 1.75;
    };
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      AppleLocale = "en_US@currency=USD";
      AppleLanguage = ["en"];
      AppleAccentColor = 0;
      AppleHighlightColor = "1.000000 0.733333 0.721569 Red";
    };
  };
}
