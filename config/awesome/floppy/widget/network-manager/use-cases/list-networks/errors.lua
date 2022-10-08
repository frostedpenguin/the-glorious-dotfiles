local Error = require("widget.shared.Error")
<<<<<<< HEAD
---@type {scan_error: Error, device_error:Error, no_network_error:Error}
local use_case_errors = {
	scan_error = Error:new(nil, "Unexpected ScanError"),
	device_error = Error:new(nil, "Not available wifi device.s!"),
	no_network_error = Error:new(nil, "No networks found!"),
=======
use_case_errors = {
	scan_error = Error:new(nil, "Unexpected ScanError") or "",
	device_error = Error:new(nil, "Not available wifi devices!") or "",
	no_network_error = Error:new(nil, "No networks found!") or "",
>>>>>>> 57ca39b (regular commit)
}
return use_case_errors
