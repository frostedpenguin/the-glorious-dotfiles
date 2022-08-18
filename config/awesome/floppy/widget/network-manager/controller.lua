-- local widget = require("widget.network-manager.top-panel-button")
local file_reader_thread = require("widget.utils.files")
local awful = require("awful")
local debug_signals = require("module.debug.types.signals")
local script_path = "./widget/network-manager/scripts/list-networks.sh"

local list_networks = function()
	local networks = {}
	local isDone, buffer = coroutine.resume(file_reader_thread, script_path)
	if isDone then
		for _, line in ipairs(buffer) do
			local network = {}
			local _, _, name, address = string.find(line, "([^%s]+)%s+([^%s]+)")
			network.name = name
			network.address = address
			table.insert(networks, network)
		end
	else
		awful.emit_signal(debug_signals.ERROR, "list_networks: coroutine.resume error")
	end
	return networks
end
return list_networks
