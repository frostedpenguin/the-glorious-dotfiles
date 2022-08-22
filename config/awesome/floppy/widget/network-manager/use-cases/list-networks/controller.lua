local awful = require("awful")
-- local debug_signals = require("module.debug.types.signals")
SEP = "\n"

local lgi = require("lgi")
local NM = lgi.NM
-- local pl = require("pl.pretty")

function scan()
	local rescan_command = "nmcli device wifi rescan"
	os.execute(rescan_command)
end

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

---------------------------
-- Main code starts here --
---------------------------
-- Call setlocale() else NM.utils_wifi_strength_bars() will think the locale
-- is ASCII-only, and return the fallback characters rather than the unicode bars

os.setlocale("")

-- get all devices

-- print APs for all Wi-Fi devices
function main() end

local list_networks = function()
	scan()
	local networks = {}
	client = NM.Client.new()
	devs = client:get_devices()

	networks = {}
	for _, dev in ipairs(devs) do
		if dev:get_device_type() == "WIFI" then
			for _, ap in ipairs(dev:get_access_points()) do
				table.insert(networks, map(ap))
			end
		end
	end

	-- local isDone, script = coroutine.resume(file_reader_thread, script_path)
	-- if not isDone then
	-- 	awful.emit_signal(debug_signals.ERROR, "list_networks: coroutine.resume error")
	-- end

	-- awful.spawn.easy_async_with_shell(script, function(stdout, stderr)
	-- 	print("err" .. stderr)
	-- 	networks_raw = split(stdout, SEP)
	-- 	for _, line in ipairs(networks_raw) do
	-- 		local networks_entry = {}
	-- 	end
	-- end)

	return networks
end
return list_networks
