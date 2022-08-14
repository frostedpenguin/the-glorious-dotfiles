local awful = require("awful")
local debug_signals = require("module.debug.types.signals")
function file_exists(file)
	local f = io.open(file, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function lines_from(file)
	if not file_exists(file) then
		awesome.emit_signal(debug_signals.ERROR, "file not found:" .. file)
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

return lines_from
