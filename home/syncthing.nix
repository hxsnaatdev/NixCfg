{syncthingGuiPasswordFile, ...}: {
  services.syncthing = {
    enable = true;

    guiAddress = "127.0.0.1:8384";
    guiCredentials = {
      username = "ariz";
      passwordFile = syncthingGuiPasswordFile;
    };

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        m1 = {
          id = "TMDXC4A-4JE25JA-QD3EX7V-OHTMQI5-4RCWPDP-BBJZZ6P-VX3F3MU-BA56UQ4";
          name = "m1";
          addresses = ["dynamic"];
          compression = "metadata";
          introducer = false;
          autoAcceptFolders = false;
        };
      };

      folders = {
        SecondBrain = {
          id = "kwtog-xward";
          label = "SecondBrain";
          path = "/Users/ariz/SecondBrain";
          type = "sendreceive";
          devices = ["m1"];
          rescanIntervalS = 3600;
          fsWatcherEnabled = true;
          fsWatcherDelayS = 10;
          fsWatcherTimeoutS = 0;
          ignorePerms = false;
          autoNormalize = true;
          minDiskFree = {
            unit = "%";
            value = 1;
          };
          maxConflicts = 10;
          markerName = ".stfolder";
          maxConcurrentWrites = 16;
        };
      };

      gui = {
        tls = false;
        theme = "default";
      };

      options = {
        listenAddresses = ["default"];
        globalAnnounceServers = ["default"];
        globalAnnounceEnabled = true;
        localAnnounceEnabled = true;
        localAnnouncePort = 21027;
        localAnnounceMCAddr = "[ff12::8384]:21027";
        relaysEnabled = true;
        natEnabled = true;
        urAccepted = 3;
        urSeen = 3;
        urUniqueID = "dQqZX7jq";
        urURL = "https://data.syncthing.net/newdata";
        urInitialDelayS = 1800;
        autoUpgradeIntervalH = 12;
        keepTemporariesH = 24;
        progressUpdateIntervalS = 5;
        minHomeDiskFree = {
          unit = "%";
          value = 1;
        };
        releasesURL = "https://upgrades.syncthing.net/meta.json";
        setLowPriority = true;
        crashReportingURL = "https://crash.syncthing.net/newcrash";
        crashReportingEnabled = true;
        stunServer = "default";
        announceLANAddresses = true;
      };
    };
  };
}
