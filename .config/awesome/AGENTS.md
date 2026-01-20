# AGENTS.md for Awesome WM Configuration

This file provides guidelines for agentic coding agents working on this Awesome WM configuration codebase. The codebase is written in Lua and consists of configuration files for the Awesome window manager.

## Build/Lint/Test Commands

Since this is a window manager configuration rather than a traditional software project, there are no build processes or automated tests. However, the following commands can be used to validate the configuration:

### Syntax Checking
- **Lua syntax check**: `luac -p <file.lua>` - Checks syntax of individual Lua files without executing them.
- **Awesome config check**: `awesome -k` - Validates the entire Awesome configuration for syntax errors (run from the config directory).
- **Full config load test**: `lua -e "require('rc')"` - Attempts to load the main rc.lua file to catch runtime errors (note: requires Awesome libraries).

### Linting
- **Luacheck**: If installed, run `luacheck .` to lint all Lua files for style and potential issues. Install via `luarocks install luacheck` if not available.
- **Manual style check**: Use consistent formatting as described below.

### Testing
This configuration has no unit tests or automated test suite, as it's a runtime configuration file. Testing involves:
- **Manual testing**: Restart Awesome WM and verify functionality (e.g., keybindings work as expected).
- **Single "test"**: To test a specific binding or feature, modify the config and restart Awesome, then check the feature.
- **Error logging**: Check `~/.cache/awesome/stderr` for runtime errors after restarting.

### Development Workflow
1. Make changes to Lua files
2. Run `luac -p <modified_file.lua>` to check syntax
3. Run `awesome -k` to validate entire config
4. Restart Awesome WM to test changes
5. Check logs for errors

## Code Style Guidelines

### General Principles
- **Consistency**: Follow the existing code style in the repository. The codebase uses a mix of styles, but prioritize clarity and maintainability.
- **Readability**: Code should be self-documenting. Use descriptive variable names and comments where necessary.
- **Modularity**: Organize code into logical modules (e.g., bindings, widgets). Avoid monolithic files.
- **Error Handling**: Use `pcall` for potentially failing operations, especially when loading external modules or spawning processes.
- **Performance**: Avoid unnecessary computations in event handlers. Keep the config lightweight.

### File Structure
- **Main config**: `rc.lua` - Entry point, sets up screens, rules, signals.
- **Bindings**: `bindings/` directory - Separate files for different keybinding modes.
- **Widgets**: `widgets/` directory - Custom widgets like volume, CPU, etc.
- **Themes**: `themes/` directory - Visual themes.
- **Applications**: `applications.lua` - Menu definitions.

### Lua-Specific Guidelines
- **Version**: Lua 5.3+ (as used by Awesome WM).
- **Imports**: Place `require` statements at the top of files, grouped logically (standard libraries first, then Awesome modules, then custom modules).
- **Indentation**: Use 4 spaces for indentation. No tabs.
- **Line Length**: Limit lines to 100 characters where possible.
- **Naming Conventions**:
  - **Variables**: Use `snake_case` for local variables (e.g., `current_mode`, `mytextclock`).
  - **Functions**: Use `snake_case` for function names (e.g., `toggle_key_mode`, `refresh_borders`).
  - **Constants**: Use `UPPER_CASE` for constants (e.g., `modkey = "Mod4"`).
  - **Tables/Modules**: Use descriptive names (e.g., `shared_keys`, `volume_widget`).
- **Tables**:
  - Use table constructors `{}` for static data.
  - Prefer array-style tables for lists.
  - Use consistent comma placement (trailing commas allowed).
- **Functions**:
  - Use anonymous functions for callbacks.
  - Keep functions short and focused.
  - Use `local` for functions unless they need to be global.

### Awesome WM Specifics
- **Global Variables**: Minimize global variables. Use locals where possible.
- **Signals**: Connect to signals using `client.connect_signal` or `screen.connect_signal`. Use anonymous functions for simple handlers.
- **Keybindings**: Define keys using `awful.key`. Group related keys in tables.
- **Rules**: Define client rules in `awful.rules.rules`. Use properties tables consistently.
- **Widgets**: Create widgets using `wibox` constructors. Follow the existing widget patterns.
- **Themes**: Use `beautiful` for theming. Define colors, fonts, and icons in theme files.

### Imports and Dependencies
- **Standard Libraries**: `gears`, `awful`, `wibox`, `beautiful`, `naughty` are core Awesome modules.
- **External Modules**: Require custom modules like `require("bindings.keybinds")`.
- **Conditional Requires**: Use `pcall(require, "module")` for optional dependencies.
- **Avoid Globals**: Do not pollute the global namespace unnecessarily.

### Formatting
- **Spacing**: One space around operators (`=`, `+`, etc.). No spaces inside parentheses.
- **Braces**: Use consistent brace placement (e.g., `function() {` on same line).
- **Strings**: Use double quotes for consistency.
- **Comments**: Use `--` for single-line comments. Add comments for complex logic.
- **Blank Lines**: Use blank lines to separate logical sections.

### Types and Type Safety
- Lua is dynamically typed, so no explicit type annotations.
- Use descriptive names to imply types (e.g., `client_list` for a table of clients).
- Validate inputs where critical (e.g., check if a variable is a table before iterating).

### Error Handling
- **Pcall Usage**: Wrap risky operations in `pcall` (e.g., `pcall(function() awesome.restart() end)`).
- **Notifications**: Use `naughty.notify` to inform users of errors.
- **Logging**: Print errors to stderr for debugging.
- **Graceful Degradation**: If a module fails to load, provide fallbacks or disable features.

### Security
- Avoid executing untrusted code.
- Be cautious with `awful.spawn` and external commands.
- Do not hardcode sensitive information.

### Documentation
- **Inline Comments**: Explain non-obvious code.
- **Module Comments**: Add brief descriptions at the top of files.
- **Function Comments**: Document complex functions with parameter descriptions.

### Example Code Snippets

#### Keybinding Definition
```lua
awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
end, { description = "open a terminal", group = "launcher" })
```

#### Signal Connection
```lua
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
```

#### Widget Creation
```lua
local mywidget = wibox.widget.textbox()
mywidget.text = "Hello World"
```

#### Error Handling
```lua
local status, result = pcall(function()
    require("some_module")
end)
if not status then
    naughty.notify({ title = "Module Error", text = result })
end
```

### Commit Guidelines
- Use descriptive commit messages.
- Commit logical changes together.
- Test configuration after commits.

### Version Control
- Use Git for version control.
- Branch for experimental changes.
- Pull requests for major changes (if applicable).

This AGENTS.md ensures consistent development practices for maintaining this Awesome WM configuration. Agents should adhere to these guidelines to produce high-quality, maintainable code.