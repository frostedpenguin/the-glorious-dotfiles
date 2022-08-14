local naughty = require("naughty")
local error_title = require("module.debug.types.titles").ERROR
local error_urgency = require("module.debug.types.urgency").ERROR
function throw_error(message)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = error_title,
		urgency = error_urgency,
		text = message,
	})
end
return throw_error
