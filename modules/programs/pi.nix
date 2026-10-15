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
          "defaultModel": "github-copilot/gpt-5.6-luna",
          "defaultProvider": "github-copilot",
          "defaultThinkingLevel": "max",
          "editorPaddingX": 1,
          "outputPad": 0,
          "tuiMode": "fullscreen",
          "enabledModels": [
            "github-copilot/gpt-5.6-luna",
            "opencode/gpt-6-luna"
          ],
          "enableInstallTelemetry": false,
          "hideThinkingBlock": false,
          "theme": "gruvbox-dark",
          "treeFilterMode": "no-tools"
        }
      '';

    etc."config/pi/agent/keybindings.json".text =
      #json
      ''
        {
          "tui.altScreen.halfPageUp": "shift+up",
          "tui.altScreen.halfPageDown": "shift+down",
          "tui.altScreen.previousPrompt": "ctrl+up",
          "tui.altScreen.nextPrompt": "ctrl+down"
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
            process.stdout.write(`\x1b]777;notify;''${NOTIFICATION_TITLE};''${NOTIFICATION_BODY}\x07`);
        }

        function playSound(): void {
          const soundPath = expandPath(SOUND_PATH);
          const player = findExecutable("ffplay");
          if (!player) return;

          spawnDetached(player, ["-nodisp", "-autoexit", soundPath]);
          return;
        }

        export default function notify(pi: ExtensionAPI) {
          pi.on("agent_end", async () => {
            sendNotification();
            playSound();
          });
        }
      '';

    etc."config/pi/agent/skills/tempo-worklog-description/SKILL.md".text =
      #md
      ''
        ---
        name: tempo-worklog-description
        description: Creates a customer-facing, Tempo-ready worklog description from the current session context, optionally using Git evidence, while applying the organization's Leistungserfassung guideline and always estimating effort in hours. Use when a concise description and effort estimate are needed for a Tempo booking.
        ---

        # Tempo worklog description

        Create one description that can be pasted into a Tempo worklog and an estimated effort in hours. This skill produces text only; it must not create, edit, or submit a Tempo booking.

        ## Input

        Use the complete current session context as the primary input: the user's request, conversation, work performed, inspected files or changes, commands and results, decisions, and outcomes. A Git commit reference may be supplied after the skill name as optional supporting evidence, but a commit is not required:

        ```text
        /skill:tempo-worklog-description [optional commit or additional context]
        ```

        If an optional commit reference is supplied, resolve and inspect it when useful. If it cannot be resolved, report that clearly but continue with the session context when it contains sufficient evidence. If the session context does not provide enough information for a reliable description or effort estimate, ask a concise follow-up question rather than requiring a commit.

        ## Required procedure

        1. Before drafting anything, read the complete guideline at:
           `~/references/Leistungserfassung.md`
           Do not rely on memory or on this skill as a substitute for the guideline. If the file cannot be read, say so and do not invent a description.
        2. Review the session context and identify the concrete activities performed, what they concerned or supported, and—when evident—the result or purpose. A commit is optional, not a prerequisite.
        3. If a commit reference is available and useful, identify the Git repository, verify that it resolves to a commit, and inspect its message, changed paths, summary, and relevant diff. Use Git commands with the supplied reference quoted safely. At minimum, use the equivalent of:
           - `git rev-parse --show-toplevel`
           - `git rev-parse --verify '<ref>^{commit}'`
           - `git show --no-ext-diff --format=fuller --stat --summary '<ref>'`
           - `git show --no-ext-diff --format= --find-renames '<ref>'`
        4. Infer only what the session context and any supporting evidence actually support. Never fabricate a ticket context, business purpose, customer, outcome, or work that is not evident.
        5. Estimate the effort represented by the session's work in hours. Use a sensible level of precision and do not present unsupported precision. The successful output must always contain this estimate; if the context is too sparse to estimate it responsibly, ask for the missing information instead.
        6. Draft the result in German by default. Follow an explicitly requested output language instead.
        7. Check the description and effort estimate against the guideline before returning them.

        ## Writing requirements

        The final description must:

        - be one clear, customer-facing sentence, ideally 40–200 characters;
        - state the concrete activity and what it concerned or supported, so it is understandable without knowing the ticket;
        - use a factual, neutral nominal style, for example `Analyse`, `Abstimmung`, `Erstellung`, `Implementierung`, `Anpassung`, or `Fehlerbehebung`;
        - use customer-understandable terms and name the result or goal when the evidence supports doing so;
        - be specific rather than using empty phrases such as `Meeting`, `Bugfix`, `Doku`, `Testing`, `Weiterarbeit`, or `siehe Ticket`;
        - avoid internal abbreviations, project slang, implementation details that are not useful to the customer, internal calculations, names of third parties, other customers, confidential information, criticism, emotions, and unsupported claims;
        - not use the commit hash or a ticket number as a substitute for describing the work;
        - not copy the same generic wording merely because several commits are related; and
        - always include a separate estimated effort in hours, based on the work evident in the session context rather than implying that it is tracked time;

        The session context is evidence of work, not automatically a complete worklog entry. If the context—or an optional commit—is ambiguous, contains only internal maintenance, or does not provide enough information to say what was done and for what, ask a concise follow-up question rather than guessing.

        ## Output

        When the evidence is sufficient, return exactly one ready-to-paste description in a code block, followed by its character count and the estimated effort in hours:

        ```text
        <description>
        ```
        Zeichen: <count>
        Geschätzter Aufwand: <number> Stunden

        Do not provide several alternatives or a long explanation. Never return a successful result without the effort estimate. If essential context is missing, ask for that context instead of returning a speculative description.
      '';
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/pi 0755 thled root -"
    "d /etc/config/pi/agent 0755 thled root -"
    "d /etc/config/pi/agent/extensions 0755 thled root -"
    "d /etc/config/pi/agent/skills 0755 thled root -"
  ];
}
