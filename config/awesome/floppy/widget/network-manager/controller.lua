-- local widget = require("widget.network-manager.top-panel-button")
local file_reader = require("widget.utils.files")
local awful = require("awful")

local list_networks = function()
  local networks = {}
  file_reader('test')
  return networks
end
list_networks()
