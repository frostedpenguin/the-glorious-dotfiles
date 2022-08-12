local Error = require('debug.types.Errors')
local warning = require('debug.types.Warning')
local info =  require('debug.types.Info')

awesome.connect_signal('debug::error', function(message) Error(message) end)

awesome.connect_signal('debug::warning', function (message) warning(message) end)

awesome.connect_signal('debug::info', function (message) info(message) end)
