local naughty = require("naughty")
local warning_title = require("debug.types.titles").WARNING
local warning_urgency = require("debug.types.urgency").WARNING
function throw_warning(message)
	naughty.notify({
		preset = naughty.config.presets.normal,
		title = warning_title,
		urgency = warning_urgency,
		text = message,
	})
end
return throw_warning
