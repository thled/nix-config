{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
  };
}

