{...}: {
  users.users.thled = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "input"
      "docker"
      "libvirtd"
      "video"
      "wheel"
    ];
    initialPassword = "123";
  };
}
