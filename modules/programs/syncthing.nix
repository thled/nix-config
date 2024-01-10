_: {
  services.syncthing = {
    enable = true;
    user = "thled";
    dataDir = "/home/thled/sync";
    configDir = "/home/thled/sync/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        pixel4a = { id = "A4BICQY-5SI372K-YGFDIMG-VI2EEET-OY72ZER-YD6WGCG-V3ONUKI-Q7R3YAN"; };
      };
      folders = {
        Sync = {
          path = "/home/thled/sync/pixel";
          devices = [ "pixel4a" ];
        };
        Obsidian = {
          path = "/home/thled/dev/references";
          devices = [ "pixel4a" ];
        };
      };
    };
  };
}
