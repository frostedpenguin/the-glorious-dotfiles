local wibox = require("wibox")
local list_networks = require("widget.network-manager.controller")
local clickable_container = require("widget.clickable-container")
local awful = require("awful")
local pl = require("pl.pretty")

local hello = require("widget.network-manager.test")
local gears = require("gears")
local naughty = require("naughty")
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "widget/network/icons/"
local dpi = require("beautiful").xresources.apply_dpi
ICONS = {
	SIGNAL_OFF = "wifi-strength-off.svg",
}

local widget = wibox.widget({
	{
		id = "icon",
		image = widget_icon_dir .. ICONS.SIGNAL_OFF,
		widget = wibox.widget.imagebox,
		resize = true,
	},
	layout = wibox.layout.align.horizontal,
})

local widget_button = wibox.widget({
	{
		widget,
		margins = dpi(7),
		widget = wibox.container.margin,
	},
	widget = clickable_container,
})
widget_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
	local networks_dto = list_networks()
	pl.dump(networks_dto)
end)))
return widget_button
