{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.pi-coding-agent];
    variables = {
      PI_CODING_AGENT_DIR = "/etc/config/pi/agent";
      PI_PACKAGE_DIR = "${pkgs.pi-coding-agent}/lib/node_modules/pi-monorepo";
      PI_SKIP_VERSION_CHECK = "1";
      PI_TELEMETRY = "0";
    };
    etc."config/pi/agent/settings.json".text =
      #json
      ''
        {
          "defaultModel": "gpt-5.4",
          "defaultProvider": "github-copilot",
          "defaultThinkingLevel": "high",
          "editorPaddingX": 1,
          "enabledModels": ["gpt-5.4", "gpt-5-mini"],
          "enableInstallTelemetry": false,
          "hideThinkingBlock": false,
          "theme": "gruvbox-dark"
        }
      '';

    etc."config/pi/agent/themes/gruvbox-dark.json".text =
      #json
      ''
        {
          "$schema": "https://raw.githubusercontent.com/badlogic/pi-mono/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json",
          "name": "gruvbox-dark",
          "vars": {
            "bg0": "#282828", "bg1": "#3c3836", "bg2": "#504945", "bg3": "#665c54",
            "fg": "#ebdbb2", "fg4": "#a89984",
            "red": "#fb4934", "green": "#b8bb26", "yellow": "#fabd2f", "blue": "#83a598",
            "purple": "#d3869b", "aqua": "#8ec07c", "orange": "#fe8019"
          },
          "colors": {
            "accent": "aqua", "border": "bg2", "borderAccent": "aqua", "borderMuted": "bg1",
            "success": "green", "error": "red", "warning": "yellow", "muted": "bg3", "dim": "bg2",
            "text": "", "thinkingText": "bg3",
            "selectedBg": "#3c3836", "userMessageBg": "#3c3836", "userMessageText": "",
            "customMessageBg": "#3c3836", "customMessageText": "", "customMessageLabel": "aqua",
            "toolPendingBg": "#282828", "toolSuccessBg": "#2a3028", "toolErrorBg": "#302828",
            "toolTitle": "aqua", "toolOutput": "",
            "mdHeading": "orange", "mdLink": "blue", "mdLinkUrl": "bg3", "mdCode": "aqua",
            "mdCodeBlock": "", "mdCodeBlockBorder": "bg2", "mdQuote": "bg3", "mdQuoteBorder": "bg2",
            "mdHr": "bg2", "mdListBullet": "aqua",
            "toolDiffAdded": "green", "toolDiffRemoved": "red", "toolDiffContext": "bg3",
            "syntaxComment": "bg3", "syntaxKeyword": "red", "syntaxFunction": "green",
            "syntaxVariable": "blue", "syntaxString": "green", "syntaxNumber": "purple",
            "syntaxType": "yellow", "syntaxOperator": "orange", "syntaxPunctuation": "fg4",
            "thinkingOff": "bg2", "thinkingMinimal": "bg3", "thinkingLow": "blue",
            "thinkingMedium": "aqua", "thinkingHigh": "purple", "thinkingXhigh": "red",
            "bashMode": "orange"
          }
        }
      '';
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/pi 0755 thled root -"
    "d /etc/config/pi/agent 0755 thled root -"
  ];
}
