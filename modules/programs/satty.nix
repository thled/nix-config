{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      grim
      satty
      slurp
    ];
  };
}

