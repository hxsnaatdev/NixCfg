{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
  };

  extensions = lib.optionals (!hostPlatform.isDarwin) [
    {id = "ddkjiahejlhfcafbddmgiahcphecmpfh";}
  ];
}
