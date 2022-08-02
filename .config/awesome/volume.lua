local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
require("theme")

function getvol()
	os.execute("~/scripts/volume -v")
end

function value_change()
	volumepopup.value = 30
end

function vis_toggle()
  volumepopup.visible = true
  local hide = timer({ timeout = 5 })
  hide:connect_signal("timeout", function ()
		volumepopup.visible = false
		hide:stop()
	end)
	hide:start()
end

volumepopup = awful.popup ({
	widget = {
		{
			{
				max_value = 100,
				forced_height = 10,
				forced_width = 200,
				widget = wibox.widget.progressbar
			},
			layout = wibox.layout.fixed.vertical,
		},
		margins = 10,
		widget = wibox.container.margin
	},
	border_width = 0,
	ontop = true,
	x = 860,
	y = 1010,
	visible = false
})
