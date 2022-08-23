local widget_signal = require("widget.network-manager.types.widget_signal")
local use_case_signal = widget_signal:new(nil, "list-networks")
print("use_case_signal", use_case_signal:get_signal())
return {
	EXECUTE = use_case_signal:new(nil, "execute"):get_signal(),
	RESPONSE = use_case_signal:new(nil, "response"):get_signal(),
	ERROR = use_case_signal:new(nil, "error"):get_signal(),
}
