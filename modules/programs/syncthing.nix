{ ... }: {
  services.syncthing = {
    enable = true;
    user = "thled";
    dataDir = "/home/thled/sync";
    configDir = "/home/thled/sync/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "pixel4a" = { id = "A4BICQY-5SI372K-YGFDIMG-VI2EEET-0Y72ZER-YD6WGCG-V30NUKI-Q7R3YAN"; };
    };
    folders = {
      "Sync" = {
        path = "/home/thled/sync";
        devices = [ "pixel4a" ];
      };
      "Obsidian" = {
        path = "/home/thled/projects/references";
        devices = [ "pixel4a" ];
      };
    };
  };
}
