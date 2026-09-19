{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.wl-kbptr];
    etc."config/wl-kbptr/config".text = ''
      [general]
      modes=floating,click

      [mode_floating]
      source=detect
      label_color=#fb4934ff
      selectable_bg_color=#282828cc
      unselectable_bg_color=#0000
      selectable_border_color=#0000
      label_symbols=shtarenicpdoluwfmxbgyzvkqj
    '';
  };
}
