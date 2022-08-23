local Error = require("widget.shared.Error")
local prefix = "network-manager::"
use_case_errors = {
	ScanError = Error:new("Unexpected ScanError", prefix .. "scan-error"),
	DeviceError = Error:new("Not available wifi devices!", prefix .. "device-error"),
	NoNetworkError = Error:new("No networks found!", prefix .. "no-network-error"),
}
return use_case_errors
