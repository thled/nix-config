{...}: {
  users.groups.uinput = {};

  users.users.thled = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "docker"
      "input"
      "libvirtd"
      "uinput"
      "video"
      "wheel"
    ];
    initialPassword = "123";
  };
}
