local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("theme")

modkey = "Mod4"

-- Powermenu Widget
powerbutton = wibox.widget {
	{
		widget = wibox.container.margin,
		top = dpi(10),
		bottom = dpi(10),
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

tagsone = wibox.widget {
	{
		widget = wibox.container.margin,
		left = dpi(5),
		{
			widget = awful.widget.taglist({
				screen = 1,
				filter = awful.widget.taglist.filter.all,
				layout = {
					spacing = dpi(20),
					layout = wibox.layout.fixed.vertical
				},
				buttons = taglist_buttons
			})
		}
	},
	layout = wibox.layout.fixed.vertical
}

separator = wibox.widget {
	widget = wibox.widget.separator,
	orientation = "horizontal",
	thickness = dpi(2),
	span_ratio = .5,
}

tagstwo = wibox.widget {
	{
		widget = wibox.container.margin,
		left = dpi(5),
		{
			widget = awful.widget.taglist ({
				screen = 2,
				filter = awful.widget.taglist.filter.all,
				layout = {
					spacing = dpi(20),
					layout  = wibox.layout.fixed.vertical
				},
				buttons = taglist_buttons
			})
		},
	},
	layout = wibox.layout.fixed.vertical,
}

middle = wibox.widget {
	{
		tagsone,
		separator,
		tagstwo,
		layout = wibox.layout.align.vertical
	},
	forced_height = dpi(300),
	layout = wibox.container.place
}

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
		top = dpi(10),
		{
			widget = wibox.widget.textclock,
			format = "%H",
			valign = "center",
			align = "center"
		}
	},
	{
		widget = wibox.container.margin,
		bottom = dpi(10),
		{
			widget = wibox.widget.textclock,
			format = "%M",
			valign = "center",
			align = "center"
		}
	},
	layout = wibox.layout.fixed.vertical,
}

local styles = {}
local function rounded_shape(size, partial)
	if partial then
		return function(cr, width, height)
			gears.shape.partially_rounded_rect(cr, width, height,
				false, true, false, true, 5)
		end
	else
		return function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, size)
		end
	end
end
styles.month = {
	padding = 0,
	bg_color = colors.black,
	shape = rounded_shape(10)
}
styles.normal = { shape = rounded_shape(10) }
styles.focus = {
	fg_color = colors.black,
	bg_color = colors.pink,
	markup = function(t) return '<b>' .. t .. '</b>' end,
	shape = rounded_shape(10)
}
styles.header = {
	fg_color = colors.pink,
	markup = function(t) return '<b>' .. t .. '</b>' end,
	shape = rounded_shape(10)
}
styles.weekday = {
	fg_color = colors.blue,
	markup = function(t) return '<b>' .. t .. '</b>' end,
	shape = rounded_shape(10)
}
local function decorate_cell(widget, flag, date)
	if flag=='monthheader' and not styles.monthheader then
		flag = 'header'
	end
	local props = styles[flag] or {}
	if props.markup and widget.get_text and widget.set_markup then
		widget:set_markup(props.markup(widget:get_text()))
	end
	-- Change bg color for weekends
	local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
	local weekday = tonumber(os.date('%w', os.time(d)))
	local default_bg = (weekday==0 or weekday==6) and colors.black or colors.black
	local ret = wibox.widget {
		{
			widget,
			margins = (props.padding or 4) + (props.border_width or 0),
			widget = wibox.container.margin
		},
		shape = props.shape,
		shape_border_color = props.border_color or colors.pink,
		shape_border_width = props.border_width or 0,
		fg = props.fg_color or colors.pink,
		bg = props.bg_color or default_bg,
		widget = wibox.container.background
	}
	return ret
end

calendar = wibox.widget {
	date = os.date('*t'),
	fn_embed = decorate_cell,
  font = 'Monospace 14',
	start_sunday = true, 
  widget = wibox.widget.calendar.month
}

calendarpopup = awful.popup ({
	widget = {
		{
			calendar,
			layout = wibox.layout.fixed.vertical,
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	border_width = 0,
	ontop = true,
	x = dpi(70),
	y = dpi(757),
	visible = false
})

clock:connect_signal('mouse::enter', function()
	calendarpopup.visible = true
end)

clock:connect_signal('mouse::leave', function()
	calendarpopup.visible = false
end)

-- Create bar
bar = awful.popup({
	screen = 1,
	type = "dock",
	minimum_height = dpi(600),
	maximum_height = dpi(600),
	minimum_width = dpi(30),
	maximum_width = dpi(30),
	placement = function()
		awful.placement.left(bar, { margins = dpi(20) })
	end,
	widget = {
		{
			layout = wibox.layout.align.vertical,
			{-- Left widgets
				layout = wibox.layout.fixed.vertical,
				powerbutton
			},
			{-- Middle widgets
				layout = wibox.container.place,
				middle
			},
			{ -- Right widgets
				layout = wibox.layout.fixed.vertical,
				volume,
				clock
			}
		},
		widget = wibox.container.background
	}
})
bar:struts{ left = dpi(50) }
