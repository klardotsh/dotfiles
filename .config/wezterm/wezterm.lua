local wezterm = require 'wezterm'

-- https://github.com/wez/wezterm/discussions/4728
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

-- The primary issue with Rose Pine as shipped by Wezterm is that you can't see
-- the selection range basically at all (except for during certain weird
-- interactions with colorized text), so we'll fork the built in style to fix
-- selections only. I otherwise quite like Rose Pine and continually return to
-- it even after trying other things.
local rp_dark_with_highlight = wezterm.get_builtin_color_schemes()['rose-pine']
local rp_light_with_highlight = wezterm.get_builtin_color_schemes()['rose-pine-dawn']

rp_dark_bg = rp_dark_with_highlight.background
rp_dark_fg = rp_dark_with_highlight.foreground
rp_dark_with_highlight.selection_bg = "rgba(50% 50% 50% 50%)"

rp_light_bg = rp_light_with_highlight.background
rp_light_fg = rp_light_with_highlight.foreground
rp_light_with_highlight.selection_bg = "rgba(50% 50% 50% 50%)"

--local DARK_THEME = 'rose-pine-highlightable'
--local LIGHT_THEME = 'rose-pine-dawn-highlightable'

-- May be worth revisiting Helium: https://raykzhao.phd/posts/helium
-- local DARK_THEME = 'Selenized Dark (Gogh)'
-- local LIGHT_THEME = 'Selenized Light (Gogh)'

local DARK_THEME = 'GruvboxDark'
local LIGHT_THEME = 'GruvboxLight'

local FP_0X = '0x'
local FP_Adwaita = 'adwaita'
local FP_AgaveC = 'agavec'
local FP_Atkinson = 'atkinson'
local FP_Berk = 'berk'
local FP_Cascadia = 'cascadia'
local FP_Commit = 'commit'
local FP_Fantasque = 'fantasque'
local FP_Fira = 'fira'
local FP_Geist = 'geist'
local FP_Hermit = 'hermit'
local FP_Iosevka = 'iosevka'
local FP_Maple = 'maple'
local FP_MD_IO = 'md_io'
local FP_MonoLisa = 'monolisa'
local FP_Pragmata = 'pragmata'
local FP_Victor = 'victor'

local FONT_PRESET = FP_Berk

local function light_dark_toggle(window, _)
	local currentScheme = window:effective_config().color_scheme
	local newScheme = currentScheme == DARK_THEME and LIGHT_THEME or DARK_THEME

	window:set_config_overrides({ color_scheme = newScheme })
end

local function config_font_for_preset(preset)
	if preset == FP_0X then
		primary_font = '0xProto'
	elseif preset == FP_Adwaita then
		primary_font = 'Adwaita Mono'
	elseif preset == FP_AgaveC then
		primary_font = 'Agave Code'
	elseif preset == FP_Atkinson then
		primary_font = 'Atkinson Hyperlegible Mono'
	elseif preset == FP_Berk then
		primary_font = 'Berkeley Mono'
	elseif preset == FP_Cascadia then
		primary_font = 'Cascadia Code'
	elseif preset == FP_Commit then
		primary_font = 'CommitMono'
	elseif preset == FP_Fantasque then
		primary_font = 'Fantasque Sans Mono'
	elseif preset == FP_Fira then
		primary_font = 'Fira Code'
	elseif preset == FP_Geist then
		primary_font = 'Geist Mono'
	elseif preset == FP_Hermit then
		primary_font = 'Hermit'
	elseif preset == FP_Iosevka then
		primary_font = { family = 'Iosevka Term', stretch = 'Expanded', weight = 'Regular' }
	elseif preset == FP_Maple then
		primary_font = 'Maple Mono'
	elseif preset == FP_MD_IO then
		primary_font = 'MD IO Trial'
	elseif preset == FP_MonoLisa then
		primary_font = 'MonoLisa'
	elseif preset == FP_Pragmata then
		primary_font = 'PragmataPro Mono Liga'
	elseif preset == FP_Victor then
		primary_font = 'Victor Mono'
	end

	return wezterm.font_with_fallback({
		primary_font,
		'Twitter Color Emoji',
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
		table.insert(hb, 'ss03=1') -- Clearer (to me) & character
		table.insert(hb, 'ss08=1') -- Clearer == / != / === / !== rendering
		table.insert(hb, 'ss02=1') -- Flat, not aligned, underbar in >= <=
		table.insert(hb, 'ss09=1') -- Haskell-y >>= and friends
		table.insert(hb, 'cv26=1') -- :- as a glyph
		table.insert(hb, 'ss07=1') -- =~ and !~ as squiggly equal sign
	elseif preset == FP_Commit then
		table.insert(hb, 'ss01=1') -- Ligatures(eq): <= != ===
		table.insert(hb, 'ss02=1') -- Ligatures(arr): >-> =>
		table.insert(hb, 'ss03=1') -- Smart case (?)
		table.insert(hb, 'ss04=1') -- Symbol spacing: ... <<
		table.insert(hb, 'ss05=1') -- Smart kerning (immi)
		table.insert(hb, 'cv06=1') -- More linear 6 and 9 chars
	elseif preset == FP_Iosevka then
		table.insert(hb, 'dlig=1')
		table.insert(hb, 'ss14=1') -- PragmataPro style
		table.insert(hb, 'VSAH=3') -- Hecka curly { and }
		table.insert(hb, 'VLAA=1') -- Flat underbar for >= ligature
		table.insert(hb, 'VLAC=1') -- Some breaks in == and === ligatures
		table.insert(hb, 'VLAD=1') -- Some breaks in -- ligatures
	elseif preset == FP_Maple then
		table.insert(hb, 'dlig=1')
		table.insert(hb, 'cv01=1') -- Disable gaps in @ $ & etc.
		table.insert(hb, 'cv35=1') -- Disable cursive-italic lowercase L

		table.insert(hb, 'ss02=1') -- Disable >= <= ligatures for clarity
		table.insert(hb, 'ss03=1') -- Allow [tOdO] and [TODO] to be equivalent
		table.insert(hb, 'ss04=1') -- Break up __ and ___ for clarity
		table.insert(hb, 'ss05=1') -- Thin down slash in eg. \n
		table.insert(hb, 'ss06=0') -- In italic al / il, don't connect characters?
		-- ss07 is bad: allows ligatures in cases like f>>
		table.insert(hb, 'ss08=1')
	end

	return hb
end

config = {
	color_schemes = {
		["cyberdream"] = require("cyberdream"),
		["cyberdream-light"] = require("cyberdream-light"),
		["rose-pine-highlightable"] = rp_dark_with_highlight,
		["rose-pine-dawn-highlightable"] = rp_light_with_highlight,
	},
	-- Default to dark theme to avoid flashbangs on new windows at night; use keybind to
	-- toggle to light mode after launch.
	color_scheme = DARK_THEME,
	window_background_opacity = 0.925,
	default_cursor_style = 'BlinkingBar',
	enable_tab_bar = false,
	font = config_font_for_preset(FONT_PRESET),
	font_size = 15.0,
	harfbuzz_features = config_harfbuzz_for_preset(FONT_PRESET),

	keys = {
		{ key = "o", mods = "ALT", action = wezterm.action_callback(light_dark_toggle) },
	},
}

if is_linux then
	config.enable_wayland = true
	-- https://www.pling.com/p/1932768
	config.xcursor_theme = "Simp1e-Rose-Pine"
end

return config
