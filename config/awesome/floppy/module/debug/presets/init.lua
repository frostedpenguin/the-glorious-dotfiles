local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local ruled = require("ruled")
local naughty = require("naughty")
local menubar = require("menubar")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
-- naughty.config.defaults.implicit_timeout = 5
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, dpi(6))
end

-- Apply theme variables
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_dirs = {
	"/usr/share/icons/Tela",
	"/usr/share/icons/Tela-blue-dark",
	"/usr/share/icons/Papirus/",
	"/usr/share/icons/la-capitaine-icon-theme/",
	"/usr/share/icons/gnome/",
	"/usr/share/icons/hicolor/",
	"/usr/share/pixmaps/",
}
naughty.config.icon_formats = { "svg", "png", "jpg", "gif" }
local default_timeout = 5

-- Presets / rules
ruled.notification.append_rule({
	rule = { urgency = "critical" },
	properties = {
		font = "Inter Bold 10",
		bg = "red",
		fg = "white",
		margin = dpi(16),
		position = "top_right",
		icon = beautiful.awesome_icon,
		implicit_timeout = 0,
	},
})

-- Normal notifs
ruled.notification.append_rule({
	rule = { urgency = "normal" },
	properties = {
		font = "Inter Regular 10",
		bg = "#e2eb34",
		fg = "white",
		margin = dpi(16),
		position = "top_right",
		icon = beautiful.awesome_icon,
		implicit_timeout = default_timeout,
	},
})

-- Low notifs
ruled.notification.append_rule({
	rule = { urgency = "low" },
	properties = {
		font = "Inter Regular 10",
		bg = beautiful.transparent,
		fg = beautiful.fg_normal,
		margin = dpi(16),
		position = "top_right",
		implicit_timeout = default_timeout,
	},
})

ruled.notification.connect_signal("request::rules", function()
	-- Critical notifs
end)
