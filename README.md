# Terminal in MATLAB®


[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=prabhakk-mw/matlab-terminal&file=toolbox/doc/Install.m) &nbsp; [![Download Latest](https://img.shields.io/github/v/release/prabhakk-mw/matlab-terminal?label=Download%20Latest&logo=github)](../../releases/latest/download/Terminal.mltbx)

Run a terminal in MATLAB®. Use the terminal to run command-line interface tools such AI coding agents, `git`, and `docker` without leaving the MATLAB desktop.

<video src="https://github.com/user-attachments/assets/da4858b9-684f-43ad-9e66-bb64ab268d03" autoplay loop muted playsinline></video>

## Table of Contents 

- [Get Started](#get-started)
- [Set Up AI Agents](#set-up-ai-agents)
- [Additional Terminal Commands](#additional-terminal-commands)
- [Licensing](#licensing)
- [Contact Support](#contact-support)

## Get Started

- You require MATLAB R2024b or later.  
- Download [MATLAB Terminal (GitHub)](../../releases/latest/download/Terminal.mltbx) and install the toolbox in MATLAB:
  ```matlab
  matlab.addons.install('Terminal.mltbx')
  ```
- Open a terminal in MATLAB:
  ```matlab
  % Open a docked terminal
  t = terminal();
  ```

### Set Up AI Agents

To use AI agents in the MATLAB terminal, you can use a wizard which sets up for you:

- an AI agent such as Claude Code, Gemini, or Amp.
- the [MATLAB MCP Core Server](https://github.com/matlab/matlab-mcp-core-server)
- skills to help your AI agent use MATLAB and Simulink, from [MATLAB Agentic Toolkit (GitHub)](https://github.com/matlab/matlab-agentic-toolkit) and [Simulink Agentic Toolkit (GitHub)](https://github.com/matlab/simulink-agentic-toolkit)

Run the wizard:

```matlab
% Interactive wizard (first run)
t = terminal(Agentic=true);
```

You can also programmatically specify your agent and toolkits.

```
t = terminal(Agent="claude");
t = terminal(Agent="gemini", Toolkits=["matlab","simulink"]);
```

For more information about using the AI setup process, see [Using the Terminal AI Setup (GitHub)](/guides/terminal-ai-setup).


## Additional Terminal Commands

You can use these additional commands with your terminal.

| Description | Command |
|---|---|
| Copy | `Ctrl` + `Shift` + `C` |
| Paste | `Ctrl` + `Shift` + `V` |
| Update terminal | terminal.update() |
| Uninstall terminal | matlab.addons.uninstall('Terminal') |
| Open with a custom title | `t = terminal(Name="Build");` |
| Open in a floating window | `t = terminal(WindowStyle="normal");` |
| Open with a specific shell | Linux/macOS: `t = terminal(Shell="zsh");`<br><br>Windows: `t = terminal(Shell="powershell.exe");` |
| Customize terminal color theme | For instructions, see [Customize Terminal Theme](/guides/customize-terminal-theme) |
| List all running terminals | `terminal.list()` |
| Close all running terminals | `terminal.closeAll()` |
| Close a single terminal | `delete(t);` or `exit` |
| Query the shell in use | `t.Shell` |
| Check the installed version | `terminal.version()` |

## Licensing

The license is available in the [LICENSE.md](LICENSE.md) file in this GitHub repository.

## Contact Support

MathWorks encourages you to use this repository and provide feedback. To request technical support or submit an enhancement request, [create a GitHub issue](../../issues) or contact [MathWorks Technical Support](https://www.mathworks.com/support/contact_us.html).

---

Copyright 2026 The MathWorks, Inc.

---
