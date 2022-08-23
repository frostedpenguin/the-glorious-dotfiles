Error = { message = "" }
function Error:new(message, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.message = message or ""
	return o
end

function Error:get_message()
	return self.message
end
return Error
