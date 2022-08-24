local widget_signal = require("widget.network-manager.types.widget_signal")
local use_case_signal = widget_signal .. "::list-networks"
return {
	EXECUTE = use_case_signal .. "::execute",
	RESPONSE = use_case_signal .. "::response",
	ERROR = use_case_signal .. "..error",
}
