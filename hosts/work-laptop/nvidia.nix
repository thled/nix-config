{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      powerManagement.enable = false;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        intel-media-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        nvidia-vaapi-driver
        intel-media-driver
      ];
    };
  };
}
