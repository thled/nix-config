{ pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  users.users.thled = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "docker"
      "libvirtd"
      "video"
      "wheel"
    ];
    initialPassword = "123";
  };
}

