pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

require("rules")
require("layouts")
require("keybinds")
require("mouse")

-- Error handling
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error",
		function (err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true
			naughty.notify({ preset = naughty.config.presets.critical,
				title = "Oops, an error happened!",
				text = tostring(err)})
			in_error = false
		end
	)
end

-- Notification Config
naughty.config.padding = 20
naughty.config.spacing = 10
naughty.config.icon_dirs = {"/home/chivo/.icons/Flatery-Pink-Dark/"}
naughty.config.defaults.margin = 10
naughty.config.defaults.border_width = 4
naughty.config.defaults.timeout = 10
naughty.config.defaults.screen = 1

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("nvim") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt. If you do not like this or do not have such a key, I suggest you to remap Mod4 to another key using xmodmap or other tools. However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create Widgets
-- Powermenu Widget
powerbutton = wibox.widget {
	{
		widget = wibox.container.margin,
		top = 10,
		bottom = 10,
		{
			widget = wibox.widget.textbox,
			text = "",
			valign ="center",
			align = "center"
		}
	},
	layout = wibox.layout.fixed.vertical,
}
powerbutton:buttons(gears.table.join(
	awful.button({ }, 1,
		function ()
			awful.spawn.with_shell("poweroff")
		end
	)
))
-- Tags Widget
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
tags = wibox.widget {
	{
		widget = awful.widget.taglist ({
			screen = 1,
			filter = awful.widget.taglist.filter.all,
			style = {
				shape = gears.shape.circle,
			},
			layout = {
				spacing = 10,
				layout  = wibox.layout.fixed.vertical
			},
			widget_template = {
				{
					{
						{
							id = "text_role",
							widget = wibox.widget.textbox,
						},
						margins = 6,
						widget = wibox.container.margin
					},
					widget = wibox.container.background
				},
				id = "background_role",
				widget = wibox.container.background
			},
			buttons = taglist_buttons
		})
	},
	layout = wibox.layout.fixed.vertical,
}
tags:connect_signal('mouse::enter', function()
	awful.spawn.with_shell("notify-send 'make screen 2 taglist'")
end)
-- Volume Widget
volume = wibox.widget {
	{
		widget = awful.widget.watch('bash -c "~/scripts/volume -s"', .1, function(widget, stdout)
			widget:set_markup(stdout:gsub("\n", ""))
		end),
		valign = "center",
		align = "center"
	},
	layout = wibox.layout.fixed.vertical,
}
volume:buttons(gears.table.join(
	awful.button({ }, 1,
		function ()
			awful.spawn.with_shell("~/scripts/volume -m")
		end
	),
	awful.button({ }, 2,
		function ()
			awful.spawn.with_shell("amixer -D pulse sset Master 50%")
		end
	),
	awful.button({ }, 3,
		function ()
			awful.spawn.with_shell("pavucontrol")
		end
	)
))
-- Clock Widget
clock = wibox.widget {
	{
		widget = wibox.container.margin,
		top = 10,
		{
			widget = wibox.widget.textclock,
			format = "%H",
			valign = "center",
			align = "center"
		}
	},
	{
		widget = wibox.container.margin,
		bottom = 10,
		{
			widget = wibox.widget.textclock,
			format = "%M",
			valign = "center",
			align = "center"
		}
	},
	layout = wibox.layout.fixed.vertical,
}

-- Tags for each screen
awful.screen.connect_for_each_screen(
	function(s)
		awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])
	end
)

-- Create the wibox
bar = awful.wibar({
	position = "left",
	height = 1040,
	width = 30,
})
awful.placement.left(bar, { margins = 20 })
bar:struts{ left = 50 }

-- Add widgets to the wibox
bar:setup {
	layout = wibox.layout.align.vertical,
	{-- Left widgets
		layout = wibox.layout.fixed.vertical,
		powerbutton
	},
	{-- Middle widgets
		layout = wibox.container.place,
		tags,
	},
	{ -- Right widgets
		layout = wibox.layout.fixed.vertical,
		volume,
		clock
	}
}

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage",
	function (c)
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		if not awesome.startup then awful.client.setslave(c) end
		if awesome.startup
			and not c.size_hints.user_position
			and not c.size_hints.program_position then
			-- Prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen(c)
		end
	end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars",
	function(c)
		-- buttons for the titlebar
		local buttons = gears.table.join(
			awful.button({ }, 1,
				function()
					c:emit_signal("request::activate", "titlebar", {raise = true})
					awful.mouse.client.move(c)
				end
			),
			awful.button({ }, 3,
				function()
					c:emit_signal("request::activate", "titlebar", {raise = true})
					awful.mouse.client.resize(c)
				end
			)
		)
		awful.titlebar(c) : setup {
			{ -- Left
				awful.titlebar.widget.iconwidget(c),
				buttons = buttons,
				layout  = wibox.layout.fixed.vertical
			},
			{ -- Middle
				{ -- Title
					align  = "center",
					widget = awful.titlebar.widget.titlewidget(c)
				},
				buttons = buttons,
				layout  = wibox.layout.flex.vertical
			},
			{ -- Right
				awful.titlebar.widget.floatingbutton(c),
				awful.titlebar.widget.maximizedbutton(c),
				awful.titlebar.widget.stickybutton(c),
				awful.titlebar.widget.ontopbutton(c),
				awful.titlebar.widget.closebutton(c),
				layout = wibox.layout.fixed.vertical()
			},
			layout = wibox.layout.align.vertical
		}
	end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
	function(c)
		c:emit_signal("request::activate", "mouse_enter", {raise = false})
	end
)
client.connect_signal("focus",
	function(c)
		c.border_color = beautiful.border_focus
	end
)
client.connect_signal("unfocus",
	function(c)
		c.border_color = beautiful.border_normal
	end
)
-- local function move_mouse_onto_focused_client(c)
-- 	if mouse.object_under_pointer() ~= c then
-- 		local geometry = c:geometry()
-- 		local x = geometry.x + geometry.width/2
-- 		local y = geometry.y + geometry.height/2
-- 		mouse.coords({x = x, y = y}, true)
-- 	end
-- end
-- client.connect_signal("focus", move_mouse_onto_focused_client)

-- Collect Garbage
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})

-- Autostart
awful.spawn.with_shell("~/.config/awesome/autostart")
