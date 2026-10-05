{pkgs, ...}: let
  ticktick-capture = pkgs.writeShellApplication {
    name = "ticktick-capture";
    runtimeInputs = with pkgs; [
      coreutils
      curl
      fuzzel
      jq
      libnotify
    ];
    text = ''
      CONFIG_FILE="$HOME/.ticktick-config"
      if [ ! -f "$CONFIG_FILE" ]; then
        notify-send -u critical "TickTick" "Config file not found: $CONFIG_FILE"
        exit 1
      fi

      # This file is a local shell config and should be readable only by your user.
      # shellcheck disable=SC1090
      source "$CONFIG_FILE"

      if [ -z "''${TICKTICK_ACCESS_TOKEN:-}" ]; then
        notify-send -u critical "TickTick" "Set TICKTICK_ACCESS_TOKEN in $CONFIG_FILE"
        exit 1
      fi

      if [ -z "''${TICKTICK_INBOX_PROJECT_ID:-}" ]; then
        notify-send -u critical "TickTick" "Set TICKTICK_INBOX_PROJECT_ID in $CONFIG_FILE"
        exit 1
      fi

      INPUT=$(fuzzel --dmenu --prompt "Capture: " --lines 0) || exit 0
      if [ -z "$INPUT" ]; then
        exit 0
      fi

      BODY=$(jq -n \
        --arg title "$INPUT" \
        --arg projectId "$TICKTICK_INBOX_PROJECT_ID" \
        '{title: $title, projectId: $projectId}')
      RESPONSE_FILE=$(mktemp)
      trap 'rm -f "$RESPONSE_FILE"' EXIT

      if ! HTTP_CODE=$(curl --silent --show-error --connect-timeout 5 --max-time 20 \
        -o "$RESPONSE_FILE" -w "%{http_code}" \
        -X POST "https://api.ticktick.com/open/v1/task" \
        -H "Authorization: Bearer $TICKTICK_ACCESS_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$BODY" 2>/dev/null); then
        notify-send -u critical "TickTick" "Could not reach the TickTick API"
        exit 1
      fi

      case "$HTTP_CODE" in
        2??)
          notify-send "TickTick" "Captured: $INPUT"
          ;;
        *)
          API_ERROR=$(jq -r 'if type == "object" then (.error // .message // .error_description // "") else "" end' "$RESPONSE_FILE" 2>/dev/null || true)
          if [ -n "$API_ERROR" ]; then
            notify-send -u critical "TickTick" "Failed to capture (HTTP $HTTP_CODE): $API_ERROR"
          else
            notify-send -u critical "TickTick" "Failed to capture (HTTP $HTTP_CODE)"
          fi
          exit 1
          ;;
      esac
    '';
  };
in {
  environment.systemPackages = [
    ticktick-capture
  ];
}
