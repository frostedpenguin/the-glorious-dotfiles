local Error = require("widget.shared.Error")
use_case_errors = {
	scan_error = Error:new(nil, "Unexpected ScanError"),
	device_error = Error:new(nil, "Not available wifi devices!"),
	no_network_error = Error:new(nil, "No networks found!"),
}
local err = Error:new(nil, "Unexpected ScanError")
print(err)
return use_case_errors
