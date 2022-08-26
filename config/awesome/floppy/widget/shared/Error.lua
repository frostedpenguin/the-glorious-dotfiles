local debug_signals = require("module.debug.types.signals")
Error = { message = "" }
function Error:new(o, message)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.message = message or ""
	print(self.message)
	return o
end
function Error:__tostring()
	return self.message
end
function Error:emit()
	awesome.emit_signal(debug_signals.ERROR, self.message)
end
function Error:emit_to_custom_signal(signal)
	awesome.emit_signal(signal, self.message)
end
return Error
