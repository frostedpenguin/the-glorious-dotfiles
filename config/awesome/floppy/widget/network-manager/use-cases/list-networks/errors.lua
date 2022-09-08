local Error = require("widget.shared.Error")
---@type {scan_error: Error, device_error:Error, no_network_error:Error}
local use_case_errors = {
	scan_error = Error:new(nil, "Unexpected ScanError"),
	device_error = Error:new(nil, "Not available wifi device.s!"),
	no_network_error = Error:new(nil, "No networks found!"),
}
return use_case_errors
