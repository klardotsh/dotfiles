local wezterm = require 'wezterm'

local DARK_THEME = 'duskfox'
local LIGHT_THEME = 'dawnfox'

-- Thanks, https://github.com/wez/wezterm/issues/4681#issuecomment-2320537074
local function get_cursor_theme()
	local success, stdout, stderr =
		wezterm.run_child_process { 'xprop', '-root' }
	if not success then
		wezterm.log_error(
			('Command exited with non-zero exit code.\nStdout:\n%s\nStderr:\n%s'):format(
				stdout,
				stderr
			)
		)
		return nil
	end

	return stdout:match [[RESOURCE_MANAGER%(STRING%) = ".+\nXcursor.theme:\t(.+)\n.+"]]
end

local function light_dark_toggle(window, _)
	local currentScheme = window:effective_config().color_scheme
	local newScheme = currentScheme == DARK_THEME and LIGHT_THEME or DARK_THEME

	window:set_config_overrides({ color_scheme = newScheme })
end

return {
	-- Default to dark theme to avoid flashbangs on new windows at night; use keybind to
	-- toggle to light mode after launch.
	color_scheme = DARK_THEME,
	default_cursor_style = 'BlinkingBar',
	enable_tab_bar = false,
	font = wezterm.font_with_fallback({
		'Maple Mono',
		'FSD Emoji',
		'Symbols Nerd Font',
	}),
	font_size = 15.0,
	harfbuzz_features = {
		'zero=1',
		'calt=1',
		'dlig=1',
		'clig=1',
		'liga=1',
		'ss01=1',
		'ss02=1',
		'ss03=1',
		'ss04=1',
		'ss05=1',
		'ss06=1',
		'ss07=1',
		'ss08=1',
		'ss09=1',
		'cv35=1',
	},

	keys = {
		{ key = "o", mods = "ALT", action = wezterm.action_callback(light_dark_toggle) },
	},

	xcursor_theme = get_cursor_theme() or 'Adwaita',
}
