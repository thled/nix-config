{pkgs, ...}: let
  wlKbptrBold = pkgs.wl-kbptr.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src/mode_floating.c \
        --replace-fail CAIRO_FONT_WEIGHT_NORMAL CAIRO_FONT_WEIGHT_BOLD
    '';
  });
in {
  environment = {
    systemPackages = [wlKbptrBold];
    etc."config/wl-kbptr/config".text = ''
      [general]
      modes=floating,click

      [mode_floating]
      source=detect
      label_font_family=Iosevka Term
      label_color=#fb4934ff
      selectable_bg_color=#282828cc
      unselectable_bg_color=#0000
      selectable_border_color=#0000
      label_symbols=shtarenicpdoluwfmxbgyzvkqj
    '';
  };
}
