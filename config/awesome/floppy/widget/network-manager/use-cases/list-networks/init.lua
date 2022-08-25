local network = require("widget.network-manager.domain.network")
local network_repo = require("widget.network-manager.repos.network_repo")
local debug_signals = require("module.debug.types.signals")
local use_case_signals = require("widget.network-manager.use-cases.list-networks.signals")
local use_case_errors = require("widget.network-manager.use-cases.list-networks.errors")
local lgi = require("lgi")
local NM = lgi.NM

awesome.connect_signal(use_case_signals.EXECUTE, function()
	local response = execute()
	awesome.emit_signal(debug_signals.RESPONSE, response)
end)

function ssid_to_utf8(ap)
	local ssid = ap:get_ssid()
	if not ssid then
		return ""
	end
	return NM.utils_ssid_to_utf8(ssid:get_data())
end
function flags_to_string(flags)
	local str = ""
	for flag, _ in pairs(flags) do
		str = str .. " " .. flag
	end
	if str == "" then
		str = "NONE"
	end
	return (str:gsub("^%s", ""))
end

function flags_to_security(flags, wpa_flags, rsn_flags)
	local str = ""
	if flags["PRIVACY"] and is_empty(wpa_flags) and is_empty(rsn_flags) then
		str = str .. " WEP"
	end
	if not is_empty(wpa_flags) then
		str = str .. " WPA1"
	end
	if not is_empty(rsn_flags) then
		str = str .. " WPA2"
	end
	if wpa_flags["KEY_MGMT_802_1X"] or rsn_flags["KEY_MGMT_802_1X"] then
		str = str .. " 802.1X"
	end
	return (str:gsub("^%s", ""))
end

function get_network_dto(ap, dev)
	local strength = ap:get_strength()
	local flags = ap:get_flags()
	local wpa_flags = ap:get_wpa_flags()
	local rsn_flags = ap:get_rsn_flags()
	-- remove extra NONE from the flags tables
	ap_dto = {
		name = ssid_to_utf8(ap),
		strength = NM.utils_wifi_strength_bars(strength),
		security = flags_to_security(flags, wpa_flags, rsn_flags),
		device_name = dev[NM.DEVICE_INTERFACE],
	}
	return ap_dto
end

function execute(repo)
	repo = repo or network_repo:new()
	aps = {}
	local is_success = repo:scan()
	if not is_success then
		return use_case_errors.RESCAN_FAILED
	end
	local wifi_devices = repo:get_wifi_devices()
	if is_empty(wifi_devices) then
		return use_case_errors.NO_WIFI_DEVICES
	end

	for _, dev in ipairs(wifi_devices) do
		aps = repo:get_access_points_for_device(dev)
		for _, ap in ipairs(aps) do
			local network_dto = get_network_dto(ap, dev)
			local curr_network = network:new(table.unpack(network_dto))
			repo:add_network(curr_network)
		end
	end

	if is_empty(repo:get_networks()) then
		return use_case_errors.NO_NETWORKS
	end
	return repo
end
