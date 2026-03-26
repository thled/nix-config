{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.opencode];
    variables = {
      OPENCODE_ENABLE_EXA = "1";
    };
    etc."config/opencode/opencode.json".text =
      #json
      ''
        {
          "$schema": "https://opencode.ai/config.json",
          "plugin": [
            "@mohak34/opencode-notifier@latest"
          ]
        }
      '';
  };
}
