{ pkgs, ... }:

let
  teams = pkgs.writeShellScriptBin "teams" ''
    chromium --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo
  '';

in {
  environment.systemPackages = [ 
    teams
  ];
}
