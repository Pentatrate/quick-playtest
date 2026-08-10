if not utilitools then imgui.Text("Utilitools is disabled") return end
local configHelpers = utilitools.configHelpers
configHelpers.setMod(mod)

configHelpers.treeNode("Menu Options", function()
	configHelpers.input("tooltips")
	imgui.Separator()
	configHelpers.presets.menuButtons()
	imgui.Separator()
	configHelpers.input("editorMenu")
end, not cs or cs.name ~= "Editor" and 2 ^ 5 or nil)
configHelpers.treeNode("Features", function()
	configHelpers.input("playOffset")
	configHelpers.input("detectChanges")
end, cs and cs.name == "Editor" and 2 ^ 5 or nil)
configHelpers.treeNode("Search", function()
	configHelpers.presets.search()
end)
