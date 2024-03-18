{ pkgs
, lib
, config
, ... }: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        # Option A: Offload Mode
        # offload = {
        #   enable = lib.mkOverride 990 true;
        #   enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true;
        # };

        # Option B: Sync Mode
        sync.enable = true;

        intelBusId = lib.mkDefault "PCI:0:2:0";
        nvidiaBusId = lib.mkDefault "PCI:1:0:0";
      };
      powerManagement.enable = false;
    };
    opengl = {
        driSupport = true;
        driSupport32Bit = true;
        enable = true;
        extraPackages = with pkgs; [nvidia-vaapi-driver intel-media-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver intel-media-driver];
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    etc."config/hypr/hyprland.conf".source = ./hyprland.conf;
    etc."config/hypr/hypridle.conf".source = ./hypridle.conf;
    etc."config/waybar/config".source = ./waybar.jsonc;
    etc."config/waybar/style.css".source = ./waybar.css;
    sessionVariables = {
      # hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
      # if cursor invisible
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
    systemPackages = with pkgs; [ 
      fuzzel
      hypridle
      waybar
      waylock
      wl-clipboard
      wlr-randr
      xdg-desktop-portal-gtk

      (pkgs.writeShellScriptBin "nvidia-offload" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$0"
      '')
    ];
  };

  security.pam.services.waylock = {};

  # screen sharing
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr.enable = true;
  };
}

