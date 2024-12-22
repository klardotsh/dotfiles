local wezterm = require 'wezterm'

local DARK_THEME = 'duskfox'
local LIGHT_THEME = 'dawnfox'

local FP_Iosevka = 'iosevka'
local FP_Maple = 'maple'

local FONT_PRESET = FP_Maple

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

local function config_font_for_preset(preset)
	if preset == FP_Iosevka then
		primary_font = { family = 'Iosevka Term', stretch = 'Expanded', weight = 'Regular' }
	elseif preset == FP_Maple then
		primary_font = 'Maple Mono'
	end

	return wezterm.font_with_fallback({
		primary_font,
		'FSD Emoji',
		'Symbols Nerd Font',
	})
end


local function config_harfbuzz_for_preset(preset)
	local hb = {
		'calt=1', 'liga=1', -- Generically turn ligatures on
	}

	if preset == FP_Iosevka then
		table.insert(hb, 'dlig=0') -- Explicitly disable due to awful [| and friends
		table.insert(hb, 'ss14=1') -- PragmataPro style
	elseif preset == FP_Maple then
		table.insert(hb, 'dlig=1')
		table.insert(hb, 'cv35=1') -- Disable cursive-italic lowercase L

		-- Enable all feature sets in Maple Mono
		table.insert(hb, 'ss01=1')
		table.insert(hb, 'ss02=1')
		table.insert(hb, 'ss03=1')
		table.insert(hb, 'ss04=1')
		table.insert(hb, 'ss05=1')
		table.insert(hb, 'ss06=1')
		table.insert(hb, 'ss07=1')
		table.insert(hb, 'ss08=1')
		table.insert(hb, 'ss09=1')

		table.insert(hb, 'zero=1') -- Dotted zero
	end

	return hb
end

return {
	-- Default to dark theme to avoid flashbangs on new windows at night; use keybind to
	-- toggle to light mode after launch.
	color_scheme = DARK_THEME,
	default_cursor_style = 'BlinkingBar',
	enable_tab_bar = false,
	font = config_font_for_preset(FONT_PRESET),
	font_size = 15.0,
	harfbuzz_features = config_harfbuzz_for_preset(FONT_PRESET),

	keys = {
		{ key = "o", mods = "ALT", action = wezterm.action_callback(light_dark_toggle) },
	},

	xcursor_theme = get_cursor_theme() or 'Adwaita',
}
