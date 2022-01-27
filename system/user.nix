{ pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  users.users.thled = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "123";
  };
}

