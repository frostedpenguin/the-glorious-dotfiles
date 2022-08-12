local naughty = require('naughty')
local error_title = require('debug.types.titles').ERROR
function throw_error(message)
    naughty.notify({ preset = naughty.config.presets.critical,
                     title =  error_title,
                     text = message })
end
return throw_error
