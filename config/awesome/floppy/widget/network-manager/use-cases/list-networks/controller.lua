local awful = require("awful")
local use_case_errors = require("widget.network-manager.use-cases.list-networks.errors")
-- local debug_signals = require("module.debug.types.signals")
local lgi = require("lgi")
local NM = lgi.NM

function is_empty(t)
	local next = next
	if next(t) then
		return false
	else
		return true
	end
end

function ssid_to_utf8(ap)
	local ssid = ap:get_ssid()
	if not ssid then
		return ""
	end
	return NM.utils_ssid_to_utf8(ssid:get_data())
end

function print_device_info(device)
	local active_ap = device:get_active_access_point()
	if active_ap then
		ssid = ssid_to_utf8(active_ap)
	end
	local info = string.format("Device: %s | Driver: %s | Active AP: %s", device:get_iface(), device:get_driver(), ssid)
	print(info)
	print(string.rep("=", info:len()))
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

function map(ap)
	local strength = ap:get_strength()
	-- local frequency = ap:get_frequency()
	local flags = ap:get_flags()
	local wpa_flags = ap:get_wpa_flags()
	local rsn_flags = ap:get_rsn_flags()
	-- remove extra NONE from the flags tables
	ap_dto = {
		name = ssid_to_utf8(ap),
		strength = NM.utils_wifi_strength_bars(strength),
		security = flags_to_security(flags, wpa_flags, rsn_flags),
	}
	return ap_dto
end

-- Call setlocale() else NM.utils_wifi_strength_bars() will think the locale
-- is ASCII-only, and return the fallback characters rather than the unicode bars

os.setlocale("")

local list_networks = function()
	client = NM.Client.new()
	local devs = client:get_devices()
	local available_networks = {}
	local wifi_devices = {}
	for _, dev in ipairs(devs) do
		if dev:get_device_type() == "WIFI" then
			table.insert(wifi_devices, dev)
		end
	end
	if #wifi_devices == 0 then
		return use_case_errors.DeviceError
	end
	for _, dev in ipairs(wifi_devices) do
		for _, ap in ipairs(dev:get_access_points()) do
			local net_dto = map(ap)
			print(net_dto.name)
			table.insert(available_networks, net_dto)
		end
	end
	if #available_networks == 0 then
		return use_case_errors.NoNetworkError
	end
	return available_networks
end

function main()
	local rescan_command = "nmcli device wifi list"
	local networks = {}
	awful.spawn.easy_async_with_shell(rescan_command, function(stdout, stderr)
		if stderr ~= "" then
			return use_case_errors.ScanError
		end
		networks = list_networks()
	end)
	return networks
end

return main
