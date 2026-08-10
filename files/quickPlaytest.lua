_G.quickPlaytest = quickPlaytest or {}

quickPlaytest.types = quickPlaytest.types or { deco = {}, decoSheet = {}, decoJson = {}, tag = {}, texture3d = {}, deco3d = {}, shader = {}, font = {}, sound = {}, midi = {}, facesprite = {} }
quickPlaytest.modtimes = quickPlaytest.modtimes or {}
quickPlaytest.loadedFiles = quickPlaytest.loadedFiles or {}
quickPlaytest.cache = quickPlaytest.cache or { sprites = {}, animated = {}, tags = {}, textures = {}, models = {}, shaders = {}, fonts = {}, sounds = {}, midi = {}, facesprites = {} }

function quickPlaytest.getModtime(type, filePath)
	if not quickPlaytest.types[type] then modwarn(mod, "INVALID TYPE", type, filePath) return end

	if not mod.config.detectChanges then return end
	local info = love.filesystem.getInfo(filePath, "file")
	return info and (info.modtime or true)
end

function quickPlaytest.fileLoaded(type, filePath, modtime)
	if not quickPlaytest.types[type] then modwarn(mod, "INVALID TYPE", type, filePath, modtime) return end

	if not quickPlaytest.loadedFiles[filePath] then return false end

	if not mod.config.detectChanges then return true end
	return quickPlaytest.modtimes[filePath] == modtime
end

function quickPlaytest.loadFile(type, filePath, modtime)
	if not quickPlaytest.types[type] then modwarn(mod, "INVALID TYPE", type, filePath, modtime) return end

	quickPlaytest.loadedFiles[filePath] = quickPlaytest.loadedFiles[filePath] or {}
	quickPlaytest.loadedFiles[filePath][type] = true

	quickPlaytest.types[type][filePath] = true

	if not mod.config.detectChanges then return end
	quickPlaytest.modtimes[filePath] = modtime
end

function quickPlaytest.clearCache(cache)
	if not cache then
		quickPlaytest.types = { deco = {}, decoSheet = {}, decoJson = {}, tag = {}, texture3d = {}, deco3d = {}, shader = {}, font = {}, sound = {}, midi = {}, facesprite = {} }
		quickPlaytest.modtimes = {}
		quickPlaytest.loadedFiles = {}
		return
	end

	for filePath, _ in pairs(quickPlaytest.types[cache]) do
		if quickPlaytest.loadedFiles[filePath] then
			for type, _ in pairs(quickPlaytest.loadedFiles[filePath]) do -- deco and decoSheet might overlap since they are both pngs
				quickPlaytest.types[type][filePath] = nil
			end
			quickPlaytest.loadedFiles[filePath] = nil
			quickPlaytest.modtimes[filePath] = nil
		end
		quickPlaytest.types[cache][filePath] = nil
	end
end

function quickPlaytest.loadCache()
	if quickPlaytest.lastLevel == nil or quickPlaytest.lastLevel ~= cLevel then -- different level
		-- makes the state specific vars global so Editor and Game can access them both
		quickPlaytest.cache.sprites, quickPlaytest.cache.animated, quickPlaytest.cache.tags, quickPlaytest.cache.textures, quickPlaytest.cache.models, quickPlaytest.cache.shaders, quickPlaytest.cache.fonts, quickPlaytest.cache.sounds, quickPlaytest.cache.midi, quickPlaytest.cache.facesprites = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}

		quickPlaytest.lastLevel = cLevel
		quickPlaytest.clearCache()
	end
	return quickPlaytest.cache.sprites, quickPlaytest.cache.animated, quickPlaytest.cache.tags, quickPlaytest.cache.textures, quickPlaytest.cache.models, quickPlaytest.cache.fonts, quickPlaytest.cache.sounds, quickPlaytest.cache.midi, quickPlaytest.cache.facesprites
end

return quickPlaytest