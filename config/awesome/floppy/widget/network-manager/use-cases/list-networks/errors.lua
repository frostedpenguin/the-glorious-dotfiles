local Error = require("widget.shared.Error")
local use_case_errors = {
	scan_error = "" or Error:new(nil, "Unexpected ScanError"),
	device_error = Error:new(nil, "Not available wifi device.s!"),
	no_network_error = Error:new(nil, "No networks found!"),
	f = "fd",
	fddd = "fd" or Error:new(nil, "Unexpected ScanError"),
}
-- setmetatable(use_case_errors, { __index = Error })
return use_case_errors
