local widget_signal = require("widget.shared.widget_signal")
local display_signal = widget_signal .. "::display"
return {
	PANEL = display_signal .. "::panel",
}
