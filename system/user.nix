{ pkgs, ... }: {
  users.users.thled = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "123";
  };
}

