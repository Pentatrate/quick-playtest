return {
    editorMenu = {
		type = "bool",
		name = "Configs in Editor",
		tooltips = { long = "Adjust the configs directly in the editor in the same menu format\nMore buttons are availiable in the Editor for clearing caches manually", short = "Show this menu in the editor" },
		default = true
	},
	tooltips = {
		type = "combo",
		name = "Tooltips",
		tooltips = { short = "Tooltip length when hovering" },
		values = { "long", "short", "none" },
		valueTooltips = {
			{ long = "When hovering over menu options, display a detailed tooltip", short = "Display detailed tooltip" },
			{ short = "Shorten tooltip" }
		},
		default = "long"
	},
	search = {
		type = "text",
		name = "Search",
		tooltips = { short = "Search for configs" },
		default = "",
		off = ""
	},
    playOffset = {
		type = "float",
		name = "Play Offset",
		tooltips = { long = "Editor playtest starts this many beats before the current beat", short = "Playtest position offset in beats" },
		default = 1,
		off = 1
	},
    detectChanges = {
		type = "bool",
		name = "Detect Changes",
		tooltips = { long = "Check if any files have changed and should be reloaded.\nScanning for changes within the level files will cause additional lag.\nWhen enabled there is a small chance for an obscure crash to occur if you playtest right after saving a .json file.\nWhen disabled you will be required to clear the cache whenever you have made any outside changes to the level files.\nThis includes changes to images and json files etc.", short = "Reload cache upon detected file edits" },
		default = false,
		off = false
	}
}