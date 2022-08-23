Error = { message = "", signal = "" }
function Error:new(message, signal, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.message = message or ""
	self.message = signal or ""
	return o
end

function Error:get_message()
	return self.message
end

function Error:get_signal()
	return self.signal
end
return Error
