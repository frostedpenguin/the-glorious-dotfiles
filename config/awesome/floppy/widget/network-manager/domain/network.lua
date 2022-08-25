Network = { ssid = "", signal = "", security = "", device_name = "" }
function Network:new(ssid, signal, security, device_name)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.SSID = ssid
	self.signal = signal
	self.security = security
	self.device_name = device_name
	return o
end
function Network:get_ssid()
	return self.SSID
end

function Network:get_signal()
	return self.signal
end

function Network:get_security()
	return self.security
end

return Network
