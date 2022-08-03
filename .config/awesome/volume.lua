local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

update_prog = function(volume)
	volume_bar.value = volume
end

awful.widget.watch([[sh -c "~/scripts/volume -v"]], .1, function(_, stdout)
	local volume = tonumber(stdout)
	update_prog(volume)
end)

function vis_toggle()
  volumepopup.visible = true
  local hide = timer({ timeout = 5 })
  hide:connect_signal("timeout", function ()
		volumepopup.visible = false
		hide:stop()
	end)
	hide:start()
end

volume_bar = wibox.widget {
	value = nil,
	max_value = 100,
	forced_height = 10,
	forced_width = 200,
	widget = wibox.widget.progressbar
}

volumepopup = awful.popup ({
	widget = {
		{
			volume_bar,
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
