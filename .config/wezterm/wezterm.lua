local wezterm = require 'wezterm'

local DARK_THEME = 'zenwritten_dark'
local LIGHT_THEME = 'zenwritten_light'

local FP_Adwaita = 'adwaita'
local FP_AgaveC = 'agavec'
local FP_Atkinson = 'atkinson'
local FP_Fira = 'fira'
local FP_Hermit = 'hermit'
local FP_Iosevka = 'iosevka'
local FP_Maple = 'maple'
local FP_MonoLisa = 'monolisa'
local FP_Victor = 'victor'

local FONT_PRESET = FP_Iosevka

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
	if preset == FP_Adwaita then
		primary_font = 'Adwaita Mono'
	elseif preset == FP_AgaveC then
		primary_font = 'Agave Code'
	elseif preset == FP_Atkinson then
		primary_font = 'Atkinson Hyperlegible Mono'
	elseif preset == FP_Fira then
		primary_font = 'Fira Code'
	elseif preset == FP_Hermit then
		primary_font = 'Hermit'
	elseif preset == FP_Iosevka then
		primary_font = { family = 'Iosevka Term', stretch = 'Expanded', weight = 'Regular' }
	elseif preset == FP_Maple then
		primary_font = 'Maple Mono'
	elseif preset == FP_MonoLisa then
		primary_font = 'MonoLisa'
	elseif preset == FP_Victor then
		primary_font = 'Victor Mono'
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

	if preset == FP_Fira then
		table.insert(hb, 'cv06=1') -- Flowy i character
		table.insert(hb, 'cv12=1') -- Reverse-slashed 0 character
		table.insert(hb, 'cv14=1') -- 3 character with flat top
		table.insert(hb, 'ss04=1') -- Gentler $ character
		table.insert(hb, 'cv18=1') -- Simpler % character
		table.insert(hb, 'ss08=1') -- Clearer == / != / === / !== rendering
		table.insert(hb, 'ss09=1') -- Haskell-y >>= and friends
		table.insert(hb, 'cv26=1') -- :- as a glyph
		table.insert(hb, 'ss07=1') -- =~ as squiggly equal sign
	elseif preset == FP_Iosevka then
		table.insert(hb, 'dlig=0') -- Explicitly disable due to awful [| and friends
		table.insert(hb, 'ss14=1') -- PragmataPro style
	elseif preset == FP_Maple then
		table.insert(hb, 'dlig=1')
		table.insert(hb, 'cv35=1') -- Disable cursive-italic lowercase L

		-- Enable most feature sets in Maple Mono
		table.insert(hb, 'ss01=1') -- Disable === ligatures for clarity
		table.insert(hb, 'ss02=1') -- Disable >= <= ligatures for clarity
		table.insert(hb, 'ss03=1') -- Allow [tOdO] and [TODO] to be equivalent
		table.insert(hb, 'ss04=1') -- Break up __ and ___ for clarity
		table.insert(hb, 'ss05=1') -- Thin down slash in eg. \n
		table.insert(hb, 'ss06=0') -- In italic al / il, don't connect characters?
		-- ss07 is bad: allows ligatures in cases like f>>
		table.insert(hb, 'ss08=1')

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
