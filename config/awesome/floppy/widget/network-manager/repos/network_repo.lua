local lgi = require("lgi")
local NM = lgi.NM
os.setlocale("")

local NetworkRepository = { networks = {} }

function NetworkRepository:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.networks = {}
	return o
end
function NetworkRepository:get_networks()
	return self.networks
end

function NetworkRepository:add_network(network)
	table.insert(self.networks, network)
end

function NetworkRepository:scan()
	local rescan_command = "nmcli device wifi list"
	local is_success, err = os.execute(rescan_command)
	return is_success
end

function NetworkRepository:get_wifi_devices()
	client = NM.Client.new()
	local devs = client:get_devices()
	local wifi_devs = {}
	for _, dev in ipairs(devs) do
		if dev:get_device_type() == "WIFI" and dev:get_state() == "ACTIVATED" then
			table.insert(wifi_devs, dev)
		end
	end
	print(#wifi_devs)
	return wifi_devs
end

local getAccessPointsForDevice = function(dev)
	local aps = {}
	local ap_list = dev:get_access_points()
	for _, ap in ipairs(ap_list) do
		table.insert(aps, ap)
	end
	return aps
end
return NetworkRepository
