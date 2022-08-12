local naughty = require('naughty')
local warning_title = require('debug.types.titles').WARNING
function throw_warning(message)
    naughty.notify({ preset = naughty.config.presets.normal,
                     title = warning_title,
                     text = message })
end
return throw_warning
