local debug_signals = require("module.debug.types.signals")
---@class Error
---@field message string
local Error = { message = "" }
---@param message string
---@return Error
function Error:new(o, message)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.message = message or ""
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
