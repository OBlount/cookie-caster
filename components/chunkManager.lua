local chunkManager = {}

-- chunk = {
--     threadLock -- locks the chunk/resource down
--     monitorId  -- the monitor id the chunk is responsible for
--     pallete    -- the colour pallete the chunk uses
--     encoding   -- the image encoding
-- }

local blitTextBuffer             = ""
local blitBackgroundColourBuffer = ""

function chunkManager.updateChunkPool(currentFrameIndex)
    for i=1, #MONITORS_TABLE
    do
        CHUNK_POOL[i] = {
            threadLock = false,
            monitorId  = FRAME_TABLE[currentFrameIndex][i].monitorId,
            pallete    = FRAME_TABLE[currentFrameIndex][i].colourPallete,
            encoding   = FRAME_TABLE[currentFrameIndex][i].encoding
        }
    end
end

function chunkManager.initBlitBuffers()
    for i=1, WIDTH do blitTextBuffer = blitTextBuffer .. "\0"; blitBackgroundColourBuffer = blitBackgroundColourBuffer .. "f" end
end

function chunkManager.areAllChunksThreadLocked()
    for _, chunk in ipairs(CHUNK_POOL) do if not chunk.threadLock then return false end end
    return true
end

function chunkManager.renderChunk(chunk)
    monitor = MONITORS_TABLE[chunk.monitorId]
    monitor.clear()
    monitor.setTextScale(0.5)
    chunkManager.setColourPallete(monitor, chunk.pallete)
    for i=1, HEIGHT
    do
        monitor.setCursorPos(1, i)
        cursor = { lineStart=(WIDTH*i)-(WIDTH-1), lineEnd=WIDTH*i }
        line = string.sub(chunk.encoding, cursor.lineStart, cursor.lineEnd)
        monitor.blit(blitTextBuffer, blitBackgroundColourBuffer, line)
    end
end

function chunkManager.setColourPallete(monitor, pallete)
    for i=0, 15 do monitor.setPaletteColour(2^i, tonumber(pallete[i+1], 16)) end
end

return chunkManager
