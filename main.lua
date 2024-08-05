----- imports
local config         = require("config")
local monitorManager = require("components.monitorManager")
local videoManager   = require("components.videoManager")
local renderManager  = require("components.renderManager")
----- globals
MONITORS_TABLE = {} -- mempool for all monitors
FRAME_TABLE    = {} -- mempool for all frames
CHUNK_POOL     = {} -- mempool for all chunks
-----

function main()
    threadPool = { t1=nil, t2=nil, t3=nil, t4=nil, t5=nil, t6=nil, t7=nil, t8=nil }

    monitorManager.init()
    if MONO_FILE then videoManager.loadMonoFileToMemory() else videoManager.loadFramesToMemory(fs.list(IN_DIR)) end
    renderManager.init()
    initThreads(threadPool, renderManager.renderCurrentFrame)
    while(true)
    do
    parallel.waitForAll(
        threadPool[1],
        threadPool[2],
        threadPool[3],
        threadPool[4],
        threadPool[5],
        threadPool[6],
        threadPool[7],
        threadPool[8]
    )
        os.sleep(1/FPS)
        renderManager.nextFrame()
    end
end

function initThreads(threadPool, f)
    MAX_THREADS = 8
    nf          = function() return nil end
    for i=1, TOTAL_THREADS             do threadPool[i] = f  end
    for i=TOTAL_THREADS+1, MAX_THREADS do threadPool[i] = nf end
end

main()
