local naughty = require("naughty")
local info_title = require("debug.types.titles").INFO
local info_urgency = require("debug.types.urgency").INFO
function throw_info(message)
	naughty.notify({
		preset = naughty.config.presets.low,
		title = info_title,
		urgency = info_urgency,
		text = message,
	})
end
return throw_info
