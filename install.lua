PROJECT_NAME = "cookie-caster"

local root = {
    { name="main",   code="R4DEec6z" },
    { name="config", code="bamSVq0N" }
}

local components = {
    { name="monitorManager", code="bq4UTeRB" },
    { name="chunkManager",   code="PCcAQJz3" },
    { name="videoManager",   code="Z4gmevQ2" },
    { name="renderManager",  code="E0aTxi4c" }
}

local pastebinPath = "/rom/programs/http/pastebin.lua"
for _, file in pairs(root)       do shell.run(pastebinPath, "get", file.code, PROJECT_NAME .. "/"            .. file.name .. ".lua") end
for _, file in pairs(components) do shell.run(pastebinPath, "get", file.code, PROJECT_NAME .. "/components/" .. file.name .. ".lua") end
fs.makeDir(PROJECT_NAME .. "/build/")
