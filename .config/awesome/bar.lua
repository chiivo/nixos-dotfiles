local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local screen = screen.primary
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("theme")

modkey = "Mod4"

-- Symbol Widget
local symbol = wibox.widget {
	{
		{
			widget = wibox.widget.textbox,
			text = "",
			valign ="center",
			align = "center"
		},
		widget = wibox.container.margin,
		top = dpi(10),
		bottom = dpi(10)
	},
	layout = wibox.layout.fixed.vertical,
}

symbol:buttons(gears.table.join(
	awful.button({}, 1,
		function ()
			awful.spawn.with_shell("rofi -show")
		end
	)
))

-- Tags Widget
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end)
)

local tagsone = wibox.widget {
	{
		left = dpi(10),
		right = dpi(10),
		widget = wibox.container.margin,
		{
			widget = awful.widget.taglist({
				screen = 1,
				filter = awful.widget.taglist.filter.all,
				layout = {
					spacing = dpi(20),
					layout = wibox.layout.fixed.vertical
				},
				widget_template = {
					{
						markup = '',
						widget = wibox.widget.textbox
					},
					shape = gears.shape.rounded_bar,
					widget = wibox.container.background,
					create_callback = function(self, c3, index, objects, _)
						self.update = function()
							if c3.selected then
								self.bg = colors.pink
								self.forced_height = dpi(30)
							elseif #c3:clients() == 0 then
								self.bg = colors.gray
								self.forced_height = dpi(10)
							else
								self.bg = colors.white
								self.forced_height = dpi(10)
							end
						end
						self:connect_signal("mouse::enter", function()
							if self.bg ~= colors.white then
								self.backup = self.bg
								self.has_backup = true
							end
							self.bg = colors.white
						end)
						self:connect_signal("mouse::leave", function()
							if self.has_backup and not c3.selected then
								self.bg = self.backup
							elseif c3.selected then
								self.bg = colors.pink
							end
						end)
						self.update()
					end,
					update_callback = function(self, c3, index, objects, _)
						self.update()
					end,
				},
				buttons = taglist_buttons
			})
		}
	},
	layout = wibox.layout.fixed.vertical
}

local separator = wibox.widget {
	widget = wibox.widget.separator,
	orientation = "horizontal",
	thickness = dpi(2),
	span_ratio = .5,
}

local tagstwo = wibox.widget {
	{
		left = dpi(10),
		right = dpi(10),
		widget = wibox.container.margin,
		{
			widget = awful.widget.taglist({
				screen = 2,
				filter = awful.widget.taglist.filter.all,
				layout = {
					spacing = dpi(20),
					layout = wibox.layout.fixed.vertical
				},
				widget_template = {
					{
						markup = '',
						widget = wibox.widget.textbox
					},
					shape = gears.shape.rounded_bar,
					widget = wibox.container.background,
					create_callback = function(self, c3, index, objects, _)
						self.update = function()
							if c3.selected then
								self.bg = colors.pink
								self.forced_height = dpi(30)
							elseif #c3:clients() == 0 then
								self.bg = colors.gray
								self.forced_height = dpi(10)
							else
								self.bg = colors.white
								self.forced_height = dpi(10)
							end
						end
						self:connect_signal("mouse::enter", function()
							if self.bg ~= colors.white then
								self.backup = self.bg
								self.has_backup = true
							end
							self.bg = colors.white
						end)
						self:connect_signal("mouse::leave", function()
							if self.has_backup and not c3.selected then
								self.bg = self.backup
							elseif c3.selected then
								self.bg = colors.pink
							end
						end)
						self.update()
					end,
					update_callback = function(self, c3, index, objects, _)
						self.update()
					end,
				},
				buttons = taglist_buttons
			})
		}
	},
	layout = wibox.layout.fixed.vertical
}

local middle = wibox.widget {
	{
		tagsone,
		separator,
		tagstwo,
		layout = wibox.layout.align.vertical
	},
	forced_height = dpi(250),
	layout = wibox.container.place
}

-- Volume Widget
local volume = wibox.widget {
	widget = wibox.widget.textbox,
	valign = "center",
	align = "center"
}

function volsymupdate()
	awful.spawn.easy_async_with_shell("~/scripts/volume -s", function(stdout)
  	volume:set_markup(stdout:gsub("\n", ""))
	end)
end

local volume_widget = wibox.widget {
	volume,
	layout = wibox.layout.fixed.vertical
}

volume_widget:buttons(gears.table.join(
	awful.button({}, 1,
		function ()
			awful.spawn.with_shell("~/scripts/volume -m")
			volsymupdate()
			volbarvalupdate()
			volbar_vis_toggle()
		end
	),
	awful.button({}, 2,
		function ()
			awful.spawn.with_shell("amixer -D pulse sset Master 50%")
			volsymupdate()
			volbarvalupdate()
			volbar_vis_toggle()
		end
	),
	awful.button({}, 3,
		function ()
			awful.spawn.with_shell("pavucontrol")
		end
	)
))

-- Clock Widget
local clock = wibox.widget {
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
	padding = dpi(0),
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

local calendar = wibox.widget {
	date = os.date('*t'),
	fn_embed = decorate_cell,
  font = 'monospace 14',
	start_sunday = true, 
  widget = wibox.widget.calendar.month
}

local calendarpopup = awful.popup ({
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
	y = dpi(802),
	visible = false
})

clock:connect_signal('mouse::enter', function()
	calendarpopup.visible = true
end)

clock:connect_signal('mouse::leave', function()
	calendarpopup.visible = false
end)

-- Create bar
local bar = wibox ({
	x = dpi(20),
	y = (screen.geometry.height - (screen.geometry.height - dpi(40))) / 2,
	screen = 1,
	height = screen.geometry.height - dpi(40),
	width = dpi(30),
	visible = true,
	ontop = true
})
bar:setup {
	{
		layout = wibox.layout.align.vertical,
		{-- Left widgets
			layout = wibox.layout.fixed.vertical,
			symbol
		},
		{-- Middle widgets
			layout = wibox.container.place,
			middle
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.vertical,
			volume_widget,
			clock,
			systraytoggle
		}
	},
	widget = wibox.container.background
}
bar:struts{ left = dpi(50) }

client.connect_signal("property::fullscreen", function(c)
  if c.fullscreen then
		bar.ontop = false
	else
		bar.ontop = true
	end
end)

function bartoggle()
	if bar.visible == true then
		bar.visible = false
	else
		bar.visible = true
	end 
end

-- Run volsymupdate() every second
local t = timer({ timeout = 1 })
t:connect_signal("timeout", function()
  volsymupdate()
end)
t:start()
