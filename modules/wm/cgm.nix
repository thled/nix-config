{pkgs, ...}: let
  cgm-waybar = pkgs.writeShellApplication {
    name = "cgm-waybar";
    runtimeInputs = with pkgs; [
      coreutils
      curl
      jq
    ];
    text = ''
      config_file="''${CGM_CONFIG_FILE:-$HOME/.cgm-waybar-config}"

      emit_unavailable() {
        jq -cn --arg message "$1" \
          '{text: "CGM --", tooltip: $message, class: "unavailable"}'
      }

      if [[ ! -r "$config_file" ]]; then
        emit_unavailable "CGM configuration not found: $config_file"
        exit 0
      fi

      # shellcheck disable=SC1090
      source "$config_file"

      if [[ -z "''${CGM_API_URL:-}" || -z "''${CGM_API_TOKEN:-}" ]]; then
        emit_unavailable "Set CGM_API_URL and CGM_API_TOKEN in $config_file"
        exit 0
      fi

      if ! response=$(curl \
        --fail \
        --silent \
        --show-error \
        --connect-timeout 5 \
        --max-time 10 \
        --header "access-token: $CGM_API_TOKEN" \
        "$CGM_API_URL" 2>/dev/null); then
        emit_unavailable "Could not reach the CGM API"
        exit 0
      fi

      if ! jq -e '
        type == "object" and
        (.status == "unavailable" or
          (.status == "ok" and (.value | type == "number")))
      ' >/dev/null <<<"$response"; then
        emit_unavailable "The CGM API returned an invalid response"
        exit 0
      fi

      jq -c '
        def unavailable($message):
          {text: "CGM --", tooltip: $message, class: "unavailable"};

        if .status != "ok" or .value == null then
          unavailable(.message // "No CGM data available")
        else
          (.value | tostring) as $value
          | (.unit // "mg/dL") as $unit
          | (.trend // "→") as $trend
          | (if .delta == null then ""
             elif .delta > 0 then " (+" + (.delta | tostring) + ")"
             else " (" + (.delta | tostring) + ")"
             end) as $delta
          | (.age_seconds // 0) as $age
          | (if $age < 60 then "just now"
             elif $age < 3600 then (($age / 60) | floor | tostring) + " min ago"
             else (($age / 3600) | floor | tostring) + " h ago"
             end) as $age_text
          | (if .value < 100 then "low"
             elif .value > 250 then "high"
             elif ((.delta | type) == "number" and .delta < -25) then "falling"
             else "in-range"
             end) as $range_class
          | ("CGM: " + $value + " " + $unit
             + "\nTrend: " + $trend
             + "\nChange: "
             + (if .delta == null then "n/a" else (.delta | tostring) + " mg/dL" end)
             + "\nUpdated: " + $age_text) as $tooltip
          | {
              text: $value + " ",
              tooltip: $tooltip,
              class: $range_class,
              alt: $range_class
            }
        end
      ' <<<"$response"
    '';
  };
in {
  environment.systemPackages = [cgm-waybar];
}
