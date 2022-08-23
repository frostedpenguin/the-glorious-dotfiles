local Error = require("widget.shared.Error")
local prefix = "network-manager::"
use_case_errors = {
	ScanError = Error:new("Unexpected ScanError"),
	DeviceError = Error:new("Not available wifi devices!"),
	NoNetworkError = Error:new("No networks found!"),
}
return use_case_errors
