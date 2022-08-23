local widget_signal = require("widget.shared.widget_signal")
local display_signal = widget_signal:new("display")
return {
	PANEL = display_signal:new("panel"),
}
