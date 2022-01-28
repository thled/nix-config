{ pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  users.users.thled = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "docker"
      "libvirt"
      "video"
      "wheel"
    ];
    initialPassword = "123";
  };
}

