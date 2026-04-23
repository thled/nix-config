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

    etc."config/pi/agent/extensions/notify.ts".text =
      #ts
      ''
        import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
        import { spawn } from "node:child_process";
        import { accessSync, constants } from "node:fs";
        import { homedir } from "node:os";
        import { delimiter, isAbsolute, join } from "node:path";

        const SOUND_PATH = "~/completed.mp3";
        const NOTIFICATION_TITLE = "Pi";
        const NOTIFICATION_BODY = "Agent finished";

        function expandPath(input: string): string {
          if (input.startsWith("~/")) return join(homedir(), input.slice(2));
          return input;
        }

        function findExecutable(name: string): string | undefined {
          if (isAbsolute(name)) {
            try {
              accessSync(name, constants.X_OK);
              return name;
            } catch {
              return undefined;
            }
          }

          for (const dir of (process.env.PATH ?? "").split(delimiter)) {
            if (!dir) continue;
            const candidate = join(dir, name);
            try {
              accessSync(candidate, constants.X_OK);
              return candidate;
            } catch {
              // try next PATH entry
            }
          }

          return undefined;
        }

        function spawnDetached(command: string, args: string[]): void {
          const child = spawn(command, args, {
            detached: true,
            stdio: "ignore",
            env: process.env,
          });
          child.unref();
        }

        function sendNotification(): void {
          const notifySend = findExecutable("notify-send");
          if (!notifySend) return;

          spawnDetached(notifySend, [
            "--app-name=pi",
            "--urgency=low",
            NOTIFICATION_TITLE,
            NOTIFICATION_BODY,
          ]);
        }

        function playSound(): void {
          const soundPath = expandPath(SOUND_PATH);
          const mpv = findExecutable("mpv");
          if (!mpv) return;

          spawnDetached(mpv, ["--no-video", "--really-quiet", soundPath]);
          return;
        }

        export default function notify(pi: ExtensionAPI) {
          pi.on("agent_end", async () => {
            sendNotification();
            playSound();
          });
        }
      '';
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/pi 0755 thled root -"
    "d /etc/config/pi/agent 0755 thled root -"
    "d /etc/config/pi/agent/extensions 0755 thled root -"
  ];
}
