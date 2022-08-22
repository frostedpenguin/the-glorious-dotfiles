local use_case_controller = require("widget.network-manager.use-cases.list-networks.controller")
local network = require("widget.network-manager.domain.network")
local network_repo = require("widget.network-manager.repos.network_repo")
local signals = require("widget.network-manager.types.signals")
local debug_signals = require("module.debug.types.signals")

awesome.connect_signal(signals.LIST_NETWORKS, function()
	execute()
end)

function execute()
	local available_networks = use_case_controller()
	local repo = network_repo:new()
	for _, net in ipairs(available_networks) do
		local curr_network = network:new(net.name, net.strength, net.security)
		awesome.emit_signal(debug_signals.INFO, net.name)
		repo:add_network(curr_network)
	end
	awesome.emit_signal(signals.LIST_NETWORKS_RESPONSE, repo)
end
