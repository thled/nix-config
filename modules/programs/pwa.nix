{ pkgs, ... }:

let
  teams = pkgs.writeShellScriptBin "teams" ''
    chromium --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo
  '';

  rocketchat = pkgs.writeShellScriptBin "rocketchat" ''
    chromium --profile-directory=Default --app-id=ojmcdggepfkoaogdhbfalmccjemhphao
  '';

in {
  environment.systemPackages = [ 
    teams
    rocketchat
  ];
}
