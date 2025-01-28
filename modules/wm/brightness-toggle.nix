{ pkgs, ... }:

let
  brightness = pkgs.writeShellScriptBin "brightness-toggle" ''
    #!/usr/bin/env bash
    BUS=5
    LOW=30
    HIGH=70

    current=$(ddcutil --bus=$BUS getvcp 10 | cut -d"=" -f2 | cut -d"," -f1 | xargs)
    [ "$current" -eq $LOW ] && new_value=$HIGH || new_value=$LOW

    ddcutil --bus=$BUS setvcp 10 "$new_value"
    notify-send "Brightness: $new_value"
  '';

in {
  environment.systemPackages = [ 
    brightness
  ];
}
