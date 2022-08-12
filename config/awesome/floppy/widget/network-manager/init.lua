local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local naughty = require('naughty')
local dpi = require('beautiful').xresources.apply_dpi
local apps = require('configuration.apps')
local clickable_container = require('widget.clickable-container')

local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'widget/network/icons/'
local config = require('configuration.config')

-- Configuration
local interfaces = {
  wlan_interface = config.widget.network.wireless_interface or 'wlan0',
  lan_interface = config.widget.network.wired_interface or 'enp0s25'
}

local network_mode = nil

local return_button = function()

  local update_notify_no_access = true
  local notify_no_access_quota = 0

  local startup = true
  local reconnect_startup = true
  local notify_new_wifi_conn = false
  ICONS = {
    SIGNAL_OFF = 'wifi-strength-off.svg',
  }

  local widget = wibox.widget {
    {
      id = 'icon',
      image = widget_icon_dir .. ICONS.SIGNAL_OFF,
      widget = wibox.widget.imagebox,
      resize = true
    },
    layout = wibox.layout.align.horizontal
  }

  local widget_button = wibox.widget {
    {
      widget,
      margins = dpi(7),
      widget = wibox.container.margin
    },
    widget = clickable_container
  }
  widget_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          -- awful.spawn(apps.default.network_manager, false)
        end
      )
    )
  )
  return widget_button
end

return widget_button
