{pkgs, ...}: let
  mindwtr-capture = pkgs.writeShellScriptBin "mindwtr-capture" ''
    CONFIG_FILE="$HOME/.mindwtr-config"
    if [ ! -f "$CONFIG_FILE" ]; then
      notify-send -u critical "Mindwtr" "Config file not found: $CONFIG_FILE"
      exit 1
    fi

    source "$CONFIG_FILE"

    if [ -z "$MINDWTR_TOKEN" ] || [ -z "$MINDWTR_URL" ]; then
      notify-send -u critical "Mindwtr" "MINDWTR_TOKEN and MINDWTR_URL must be set in $CONFIG_FILE"
      exit 1
    fi

    INPUT=$(fuzzel --dmenu --prompt "Capture: " --lines 0)
    if [ -z "$INPUT" ]; then
      exit 0
    fi

    BODY=$(jq -n --arg title "$INPUT" '{title: $title}')

    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
      -X POST "$MINDWTR_URL" \
      -H "Authorization: Bearer $MINDWTR_TOKEN" \
      -H "Content-Type: application/json" \
      -d "$BODY")

    if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
      notify-send "Mindwtr" "Captured: $INPUT"
    else
      notify-send -u critical "Mindwtr" "Failed to capture (HTTP $HTTP_CODE)"
    fi
  '';
in {
  environment.systemPackages = [
    mindwtr-capture
  ];
}
