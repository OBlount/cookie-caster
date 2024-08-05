----- config
IN_DIR        = "cookie-caster/build/" -- the dir containing all the video frames in the .nfpx format
FPS           = 20                     -- maximum 20 frames per second
TOTAL_THREADS = 4                      -- maximum of 8 threads
WIDTH         = 164                    -- width of 1 monitor/chunk in pixels
HEIGHT        = 81                     -- height of 1 monitor/chunk in pixels
MONO_FILE     = true                   -- flag to load in one "mono" file which contains all the frames

-- the monitor layout is as follows (starts from the top left):
-- 0|__1____2____3__.....__x__
-- 1|[ 1 ][ 2 ][ 3 ].....[ x ]
-- 2|[x+1][x+2][x+3].....[x*y]
-- y|
MONITOR_LAYOUT = {                     -- to map the monitor name => monitor position
    monitor_0=1,
    monitor_1=2
}
