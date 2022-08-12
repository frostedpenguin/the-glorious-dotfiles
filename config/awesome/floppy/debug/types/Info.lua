local naughty = require('naughty')
local info_title = require('debug.types.titles').INFO
function throw_info(message)
    naughty.notify({ preset = naughty.config.presets.low,
                     title = info_title,
                     text = message })
end
return throw_info
