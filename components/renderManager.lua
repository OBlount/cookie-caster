local chunkManager = require("components.chunkManager")

local renderManager = {}

local currentFrameIndex = 1

function renderManager.init()
    chunkManager.initBlitBuffers()
    chunkManager.updateChunkPool(currentFrameIndex)
end

function renderManager.nextFrame()
    if currentFrameIndex >= #FRAME_TABLE then currentFrameIndex = 1 else currentFrameIndex = currentFrameIndex + 1 end
    chunkManager.updateChunkPool(currentFrameIndex)
end

function renderManager.renderCurrentFrame()
    while(true)
    do
        if chunkManager.areAllChunksThreadLocked() then return end
        for _, chunk in pairs(CHUNK_POOL)
        do
            if not chunk.threadLock then
                chunk.threadLock = true
                chunkManager.renderChunk(chunk)
            end
        end
    end
end

return renderManager
