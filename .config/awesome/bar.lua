local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

modkey = "Mod4"

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
			layout = {
				spacing = 10,
				layout  = wibox.layout.fixed.vertical
			},
			buttons = taglist_buttons
		})
	},
	layout = wibox.layout.fixed.vertical,
}

tags2 = awful.popup ({
	widget = {
		{
			widget = awful.widget.taglist ({
				screen = 2,
				filter = awful.widget.taglist.filter.all,
				layout = {
					spacing = 10,
					layout  = wibox.layout.fixed.vertical
				},
				buttons = taglist_buttons
			})
		},
		margins = 5,
		widget = wibox.container.margin,
	},
	ontop = true,
	x = 70,
	y = 460,
	height = 30,
	visible = false,
	layout = wibox.layout.fixed.vertical
})

tags:connect_signal('mouse::enter', function()
	tags2.visible = true
end)

tags2:connect_signal('mouse::leave', function()
	tags2.visible = false
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
