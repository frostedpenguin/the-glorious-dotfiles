local Signal = { tag = "" }
setmetatable(Signal, Signal)
Signal.__index = Signal

local delimeter = "::"
Init_tag = ""

function Signal:__call(tag)
	local o = {}
	o.tag = tag .. delimeter
	setmetatable(o, Signal)
	return o
end
-- function Signal:emit(...)
-- 	if self.tag == "" then
-- 		return
-- 	end
-- 	awful.spawn.with_shell(
-- 		"/usr/bin/dbus-send --print-reply --dest=org.freedesktop.NetworkManager /org/freedesktop/NetworkManager org.freedesktop.NetworkManager."
-- 			.. self.tag
-- 			.. " "
-- 			.. table.concat(arg, " ")
-- 	)
-- end
-- function Signal:get_tag()
-- 	return self.tag
-- end
-- local test = Signal("test")
-- print(test.tag)
return Signal
