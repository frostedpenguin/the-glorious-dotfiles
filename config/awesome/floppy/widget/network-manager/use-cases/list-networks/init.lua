local use_case_controller = require("widget.network-manager.use-cases.list-networks.controller")
local network = require("widget.network-manager.domain.network")
local network_repo = require("widget.network-manager.repos.network_repo")
local debug_signals = require("module.debug.types.signals")
local use_case_signals = require("widget.network-manager.use-cases.list-networks.signals")

awesome.connect_signal(use_case_signals.EXECUTE, function()
	execute()
end)

function execute()
	local networks_or_error = use_case_controller()
	-- print("networks_or_error", networks_or_error[1].get_ssid())
	if getmetatable(networks_or_error) == Error then
		awesome.emit_signal(use_case_signals.ERROR, networks_or_error.get_message())
		return
	end
	local repo = network_repo:new()
	for _, net in ipairs(networks_or_error) do
		local curr_network = network:new(net.name, net.strength, net.security)
		awesome.emit_signal(debug_signals.INFO, net.name)
		repo:add_network(curr_network)
	end
	awesome.emit_signal(use_case_signals.RESPONSE, repo)
end
