-- local widget = require("widget.network-manager.top-panel-button")
local file_reader_thread = require("widget.utils.files")
local awful = require("awful")
local debug_signals = require("module.debug.types.signals")
local script_path = "./widget/network-manager/scripts/list-networks.sh"
local split = require("widget.utils.string-split")
SEP = "\n"

local list_networks = function()
	local networks = {}
	local isDone, script = coroutine.resume(file_reader_thread, script_path)
	if not isDone then
		awful.emit_signal(debug_signals.ERROR, "list_networks: coroutine.resume error")
	end

	awful.spawn.easy_async_with_shell(script, function(stdout, stderr)
		print("err" .. stderr)
		networks_raw = split(stdout, SEP)
		for _, line in ipairs(networks_raw) do
			local networks_entry = {}
		end
	end)

	-- for _, line in ipairs(buffer) do
	-- 	awesome.emit_signal(debug_signals.INFO, line)
	-- 	local network = {}
	-- 	local _, _, name, address = string.find(line, "([^%s]+)%s+([^%s]+)")
	-- 	network.name = name
	-- 	network.address = address
	-- 	table.insert(networks, network)
	-- 	end
	-- end
	return networks
end
return list_networks
