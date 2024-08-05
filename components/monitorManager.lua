local monitorManager = {}

function monitorManager.init()
    monitors = { peripheral.find("monitor") }
    for _, monitor in pairs(monitors)
    do
        if MONITOR_LAYOUT[peripheral.getName(monitor)] ~= nil then
            MONITORS_TABLE[MONITOR_LAYOUT[peripheral.getName(monitor)]] = monitor
        end
    end
end

return monitorManager
