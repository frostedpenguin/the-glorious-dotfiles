Network = { ssid = "", signal = "", security = "" }
function Network:new(ssid, signal, security)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.SSID = ssid
	self.signal = signal
	self.security = security
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
