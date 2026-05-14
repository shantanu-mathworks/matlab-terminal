# Terminal in MATLAB®


[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=prabhakk-mw/matlab-terminal&file=toolbox/doc/Install.m) &nbsp; [![Download Latest](https://img.shields.io/github/v/release/prabhakk-mw/matlab-terminal?label=Download%20Latest&logo=github)](../../releases/latest/download/Terminal.mltbx)

Run a terminal in MATLAB®. Use the terminal to run command-line interface tools such AI coding agents, `git`, and `docker` without leaving the MATLAB desktop.

<video src="https://github.com/user-attachments/assets/da4858b9-684f-43ad-9e66-bb64ab268d03" autoplay loop muted playsinline></video>

## Install

- You require MATLAB R2024b or later.  
- Download [MATLAB Terminal (GitHub)](../../releases/latest/download/Terminal.mltbx) and install the toolbox in MATLAB:
  ```matlab
  matlab.addons.install('Terminal.mltbx')
  ```

## Get Started

```matlab
% Open a docked terminal
t = terminal();
```

## Customize Terminal

You can use additional commands to customize your terminal.

| Description | Command |
|---|---|
| Update Terminal | terminal.update() |
| Uninstall Terminal | matlab.addons.uninstall('Terminal') |
| Open with a custom title | `t = terminal(Name="Build");` |
| Open in a floating window | `t = terminal(WindowStyle="normal");` |
| Open with a specific shell | Linux/macOS: `t = terminal(Shell="zsh");`<br><br>Windows: `t = terminal(Shell="powershell.exe");` |
| Open with a color theme | `t = terminal(Theme="dracula");` |
| Open with a different color theme | `t = terminal(Theme="solarized-light");` |
| Change theme on the fly | `t.Theme = "monokai";` |
| List all running terminals | `terminal.list()` |
| Close all running terminals | `terminal.closeAll()` |
| Close a single terminal | `delete(t);` |
| Query the shell in use | `t.Shell` |
| Check the installed version | `terminal.version()` |
| Set up AI agent integration with MathWorks toolkits | `t = terminal(Agentic=true);` |
| Check for updates and install the latest version from GitHub | `terminal.update()` |
| Run the built-in test suite | `terminal.test()` |



| Shortcut     | Action                     |
| ------------ | -------------------------- |
| Ctrl+Shift+C | Copy selection             |
| Ctrl+Shift+V | Paste                      |
| `exit`       | Close current terminal tab |

## AI Agent Integration

Terminal can set up AI coding agents to work with MATLAB and Simulink via the [Model Context Protocol (MCP)](https://modelcontextprotocol.io). This allows agents like Claude, Codex, Copilot, Gemini, Cursor, and Amp to evaluate MATLAB code, run files, interact with the editor, and build Simulink models.

```matlab
% Interactive wizard (first run)
t = terminal(Agentic=true);

% Skip the wizard — specify your agent directly
t = terminal(Agent="claude");
t = terminal(Agent="gemini", Toolkits=["matlab","simulink"]);
```

On first run, a setup wizard prompts you to select an agent and toolkits. Preferences are saved — subsequent calls only re-share the MATLAB session without repeating setup.

### Supported Agents

| Agent   | Registration                                  |
| ------- | --------------------------------------------- |
| Claude  | CLI command pre-populated in terminal         |
| Gemini  | Config written to `.gemini/settings.json`     |
| Amp     | Config written to `.config/amp/settings.json` |

### Custom Agent CLI

If your agent binary has a non-standard name or path, use `AgentCLI`:

```matlab
t = terminal(Agent="claude", AgentCLI="devai launch claude");
t = terminal(Agent="claude", AgentCLI="/usr/local/bin/my-claude-wrapper");
```

The custom CLI command is saved in `config.json` for subsequent runs.

### Toolkits

- **[MATLAB Agentic Toolkit](https://github.com/matlab/matlab-agentic-toolkit)** — MCP tools + skills for MATLAB (evaluate code, run files, run tests, check code, detect errors, and more)
- **[Simulink Agentic Toolkit](https://github.com/matlab/simulink-agentic-toolkit)** — MCP tools + skills for Simulink model building

Toolkits are downloaded automatically from GitHub on first use (with confirmation).

### Editor Tools

Terminal bundles additional MCP tools that give AI agents read-only access to the MATLAB editor:

| Tool                      | Description                                                |
| ------------------------- | ---------------------------------------------------------- |
| `matlab_editor_list`      | List all files open in the editor with modification status |
| `matlab_editor_active`    | Get the active file, cursor position, and selected text    |
| `matlab_editor_selection` | Get the currently highlighted text                         |
| `matlab_editor_read`      | Read contents of an open file (reflects unsaved edits)     |

### Managing Toolkits

```matlab
terminal.updateAgenticToolkit()            % update all installed toolkits
terminal.updateAgenticToolkit("matlab")    % update MATLAB toolkit only
terminal.updateAgenticToolkit("simulink")  % update Simulink toolkit only
terminal.resetAgentOptions()               % clear preferences and config, re-run wizard
```

### Requirements

- [MATLAB MCP Core Server Toolkit](https://github.com/matlab/matlab-mcp-core-server) (auto-installed on first use)
- `matlab-mcp-core-server` binary v0.8.0 or later (auto-downloaded on first use)

### How It Works

`terminal(Agentic=true)` shares the MATLAB Embedded Connector so the MCP Core Server can connect to the running MATLAB session. It downloads the selected agentic toolkits, merges their tool definitions with the bundled editor tools, and registers the MCP server with your chosen AI agent. For CLI agents (Claude), the registration command is pre-populated in the terminal. For config-file agents (Gemini, Amp), the config is written directly.

On subsequent calls, setup is skipped — only the MATLAB session is re-shared and Simulink toolkit re-initialized (if enabled).




## Themes

By default, Terminal follows the MATLAB Desktop theme — light or dark — and updates automatically when the MATLAB theme changes. Override this with a named preset, or define a fully custom color scheme.
## License

See [LICENSE.md](LICENSE.md) for details.

## Community Support

This repository is maintained by The MathWorks, Inc. Filed issues are reviewed by maintainers but responses are not guaranteed.

- **Bug reports and feature requests** — [GitHub Issues](../../issues)
- **Security vulnerabilities** — Report to [security@mathworks.com](mailto:security@mathworks.com). See [SECURITY.md](SECURITY.md) for details.

---

Copyright 2026 The MathWorks, Inc.
