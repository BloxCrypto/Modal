local fs = require("@lune/fs")
local process = require("@lune/process")
local BuildCodegen = require("./build/modules/BuildCodegen")

local FilePath = "dist/main.lua"
local TempFile = "dist/temp.lua"
local Header = fs.readFile("build/header.luau")

local function minify(text)
	fs.writeFile(TempFile, text)
    local success, _, stderr = process.exec("darklua", {"process", TempFile, TempFile, "--config", "build/darklua.json"})

    if not success then
        error("darklua failed:\n" .. tostring(stderr))
    end

	local value = fs.readFile(TempFile)
	fs.removeFile(TempFile)
    
	return value
end

local Module = fs.readFile("dist/main.rbxm")
local ModelCodegen = BuildCodegen(Module, false)

fs.writeFile(FilePath, Header .. "\n" .. minify(ModelCodegen))