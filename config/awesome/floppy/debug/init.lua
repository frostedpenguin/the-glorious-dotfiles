local error_notification = require("debug.notifications.Error")
local warning_notification = require("debug.notifications.Warning")
local info_notification = require("debug.notifications.Info")
local signals = require("debug.types.signals")
-- local ruled = require("ruled")
require("debug.presets")

-- ruled.notification.emit_signal("request::rules")

awesome.connect_signal(signals.ERROR, function(message)
	error_notification(message)
end)

awesome.connect_signal(signals.WARNING, function(message)
	warning_notification(message)
end)

awesome.connect_signal(signals.INFO, function(message)
	info_notification(message)
end)
