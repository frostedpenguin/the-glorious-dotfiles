-- local widget = require("widget.network-manager.top-panel-button")
local file_reader = require("widget.utils.files")
local awful = require("awful")
local debug_signals = require("module.debug.types.signals")

local list_networks = function()
	local networks = {}
	local buffer = file_reader("/scripts/list-networks.sh")
	awesome.emit_signal(debug_signals.INFO, buffer)
	return networks
end
return list_networks
