local wezterm = require 'wezterm'

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

return {
	enable_tab_bar = false,
	font = wezterm.font_with_fallback({
		'Monaspace Krypton',
		'FSD Emoji',
	}),
	font_size = 15.0,
	harfbuzz_features = {
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
	},
	xcursor_theme = get_cursor_theme() or 'Adwaita',
}
