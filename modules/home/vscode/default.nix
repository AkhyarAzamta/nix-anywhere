{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          thorerik.hacker-theme
          pkief.material-icon-theme

          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          golang.go
          ms-python.python
          ms-python.vscode-pylance
          bradlc.vscode-tailwindcss
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode

          eamodio.gitlens
          mhutchie.git-graph

          usernamehw.errorlens
          christian-kohler.path-intellisense
          formulahendry.auto-rename-tag
          formulahendry.auto-close-tag

          yzhang.markdown-all-in-one
          redhat.vscode-yaml
          tamasfe.even-better-toml
        ];

        userSettings = {
          "workbench.colorTheme" = "Hacker Theme";
          "workbench.iconTheme" = "material-icon-theme";
          "material-icon-theme.activeIconPack" = "react";

          "workbench.colorCustomizations" = {
            "titleBar.activeBackground" = "#000000";
            "titleBar.activeForeground" = "#00ff00";
            "titleBar.inactiveBackground" = "#0a0a0a";
            "activityBar.background" = "#000000";
            "activityBar.foreground" = "#00ff00";
            "activityBarBadge.background" = "#00ff00";
            "activityBarBadge.foreground" = "#000000";
            "statusBar.background" = "#000000";
            "statusBar.foreground" = "#00ff00";
            "statusBar.debuggingBackground" = "#333333";
            "statusBar.noFolderBackground" = "#000000";
            "tab.activeBackground" = "#0a0a0a";
            "tab.activeBorderTop" = "#00ff00";
            "editor.background" = "#000000";
            "editor.foreground" = "#00ff00";
            "editor.selectionBackground" = "#00ff0033";
            "editor.selectionHighlightBackground" = "#00ff0022";
            "editorCursor.foreground" = "#00ff00";
            "editorLineNumber.activeForeground" = "#00ff00";
            "progressBar.background" = "#00ff00";
            "focusBorder" = "#00ff00";
            "inputOption.activeBorder" = "#00ff00";
            "button.background" = "#00ff00";
            "button.hoverBackground" = "#00cc00";
            "button.foreground" = "#000000";
            "list.activeSelectionBackground" = "#00ff0022";
            "list.hoverBackground" = "#00ff0011";
            "badge.background" = "#00ff00";
            "badge.foreground" = "#000000";
          };

          "editor.fontFamily" = "'Fira Code iScript', 'JetBrainsMono Nerd Font', 'Fira Code', monospace";
          "editor.fontSize" = 17;
          "editor.fontLigatures" = true;
          "editor.fontWeight" = "normal";
          "editor.lineHeight" = 1.6;
          "editor.fontVariations" = true;

          "editor.smoothScrolling" = true;
          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.minimap.enabled" = false;
          "editor.renderWhitespace" = "selection";
          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.bracketPairs" = "active";
          "editor.formatOnSave" = true;
          "editor.tabSize" = 2;
          "editor.wordWrap" = "on";
          "editor.codeActionsOnSave" = {};

          "editor.tokenColorCustomizations" = {
            "textMateRules" = [
              {
                "scope" = [
                  "comment"
                  "keyword"
                  "storage"
                  "storage.type"
                  "storage.modifier"
                  "entity.name.function"
                  "variable.language"
                  "support.class"
                  "constant.language"
                ];
                "settings" = {
                  "fontStyle" = "italic";
                };
              }
            ];
          };

          "window.titleBarStyle" = "custom";
          "window.menuBarVisibility" = "toggle";
          "window.customTitleBarVisibility" = "auto";
          "workbench.activityBar.location" = "top";
          "workbench.secondarySideBar.defaultVisibility" = "hidden";

          "terminal.integrated.fontFamily" = "'Fira Code iScript'";
          "terminal.integrated.fontSize" = 13;
          "terminal.integrated.env.linux" = {};
          "terminal.integrated.env.windows" = {};
          "terminal.integrated.enableMultiLinePasteWarning" = "never";

          "files.autoSave" = "afterDelay";
          "files.autoSaveDelay" = 1000;
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "security.workspace.trust.untrustedFiles" = "open";

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";

          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "git.ignoreRebaseWarning" = true;

          "telemetry.telemetryLevel" = "off";
          "redhat.telemetry.enabled" = false;
          "http.systemCertificates" = true;

          "json.schemas" = [];
          "[json]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };

          "[html]" = {
            "editor.defaultFormatter" = "vscode.html-language-features";
          };
          "[css]" = {
            "editor.defaultFormatter" = "vscode.css-language-features";
          };
          "[javascript]" = {
            "editor.defaultFormatter" = "vscode.typescript-language-features";
          };
          "[javascriptreact]" = {
            "editor.defaultFormatter" = "vscode.typescript-language-features";
          };
          "javascript.updateImportsOnFileMove.enabled" = "always";
          "typescript.updateImportsOnFileMove.enabled" = "always";
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "vscode.typescript-language-features";
          };
          "[python]" = {
            "editor.formatOnType" = true;
          };
          "[php]" = {
            "editor.defaultFormatter" = "DEVSENSE.phptools-vscode";
          };
          "[vue]" = {
            "editor.defaultFormatter" = "Vue.volar";
          };
          "[blade]" = {
            "editor.defaultFormatter" = "shufo.vscode-blade-formatter";
          };
          "[dockercompose]" = {
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
            "editor.autoIndent" = "advanced";
            "editor.quickSuggestions" = {
              "other" = true;
              "comments" = false;
              "strings" = true;
            };
            "editor.defaultFormatter" = "redhat.vscode-yaml";
          };
          "[github-actions-workflow]" = {
            "editor.defaultFormatter" = "redhat.vscode-yaml";
          };

          "emmet.includeLanguages" = {
            "javascript" = "html";
          };

          "fiveServer.browser" = [];
          "fiveServer.php.executable" = "/usr/bin/php";
          "fiveServer.ignore" = [];
          "liveServer.settings.donotShowInfoMsg" = true;

          "arduino.useArduinoCli" = true;
          "arduino.ignoreBoards" = [];
          "arduino.additionalUrls" = [
            "https://dl.espressif.com/dl/package_esp32_index.json"
            "http://arduino.esp8266.com/stable/package_esp8266com_index.json"
          ];

          "workbench.editorAssociations" = {
            "*.sqlite3" = "default";
            "*.sqlite" = "default";
          };

          "bootstrapIntelliSense.version" = "Bootstrap v5.3";
          "bootstrapIntelliSense" = {
            "enable" = false;
            "bsVersion" = "5.3.7";
            "useLocalFile" = false;
            "cssFilePath" = "";
            "languageSupport" = [];
          };

          "openapi.securityAuditToken" = "CiAlEyEUn8oC3blfowo8Cppd8PyrkbJllrtMiO5zV90Q1BIYVuH0QAVcMtPhX9gf3yZrpmLFSgwFPZYuGnQYypSqpIjr90Qj9QctS8/h8GzZfuPyY4qRenHMJHAVN0Scl5w8psMRvLFgiZa0d3rnwUoDS4XjIb20fVbUngR9Vm9r5hCnoKWqLVQm1UjcoUV/rPpFzvu/59L731azr2fOMBpNcnK2kNf6BF4h/99v/pA/Ag==";
          "console-ninja.featureSet" = "Community";
          "cmake.configureOnOpen" = true;
          "cmake.pinnedCommands" = [
            "workbench.action.tasks.configureTaskRunner"
            "workbench.action.tasks.runTask"
          ];
          "cmake.options.advanced" = {
            "build" = {
              "statusBarVisibility" = "inherit";
              "inheritDefault" = "visible";
            };
            "launch" = {
              "statusBarVisibility" = "inherit";
              "inheritDefault" = "visible";
            };
            "debug" = {
              "statusBarVisibility" = "inherit";
              "inheritDefault" = "visible";
            };
          };

          "dart.flutterSdkPath" = "/usr/bin/flutter";
          "android.sdkPath" = "/home/azam/android-sdk";
          "prisma.showPrismaDataPlatformNotification" = false;
          "codeium.enableCodeLens" = false;
          "database-client.autoSync" = true;
          "platformio-ide.pythonPath" = "/home/azam/.platformio/penv/bin/python";
          "diffEditor.maxComputationTime" = 0;
          "diffEditor.codeLens" = true;
          "diffEditor.ignoreTrimWhitespace" = false;
          "remote.portsAttributes" = {
            "8000" = {
              "protocol" = "http";
            };
          };
        };
      };
    };

    home.packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];
  };
}
