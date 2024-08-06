local videoManager = {}

local monoFileName = "mono.nfpx"

function videoManager.loadFramesToMemory(files)
    for _, fileName in pairs(files)
    do
        FRAME_TABLE[#FRAME_TABLE+1] = {}
        FILE                        = io.open(IN_DIR .. fileName)
        for i=1, #MONITORS_TABLE
        do
            frame = { monitorId=i, colourpalette={}, encoding=nil }
            for i=1, 16 do table.insert(frame.colourpalette, FILE.read(FILE, 'l')) end
            frame.encoding = FILE.read(FILE, 'l')
            table.insert(FRAME_TABLE[#FRAME_TABLE], frame)
        end
        io.close(FILE)
        print("Loaded " .. fileName)
        os.sleep(0.05) -- yield
    end
    print("Loaded " .. #FRAME_TABLE .. " frame(s)")
end

function videoManager.loadMonoFileToMemory()
    FILE = io.open(IN_DIR .. monoFileName)
    while (videoManager.peekNextLine(FILE) ~= nil)
    do
        FRAME_TABLE[#FRAME_TABLE+1] = {}
        for i=1, #MONITORS_TABLE
        do
            frame = { monitorId=i, colourpalette={}, encoding=nil }
            for i=1, 16 do table.insert(frame.colourpalette, FILE.read(FILE, 'l')) end
            frame.encoding = FILE.read(FILE, 'l')
            table.insert(FRAME_TABLE[#FRAME_TABLE], frame)
        end
        print("Loaded frame " .. #FRAME_TABLE)
        os.sleep(0.05) -- yield
    end
    io.close(FILE)
    print("Loaded " .. #FRAME_TABLE .. " frame(s)")
end

function videoManager.peekNextLine(FILE)
    line = FILE.read(FILE, 'l')
    if line ~= nil then FILE.seek(FILE, "cur", -(string.len(line)+2)) end
    return line
end

return videoManager
