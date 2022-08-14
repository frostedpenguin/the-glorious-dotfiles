local gears = require("gears")
local naughty = require("naughty")

local config = require("configuration.config")
local widget_button = require("widget.network-manager.top-panel-button")
local controller = require("widget.network-manager.controller")

-- Configuration
local interfaces = {
	wlan_interface = config.widget.network.wireless_interface or "wlan0",
	lan_interface = config.widget.network.wired_interface or "enp0s25",
}

local return_button = function()
	return widget_button
end

return return_button
