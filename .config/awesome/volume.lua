local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")

update_prog = function(volume)
	volume_bar.value = volume
end

awful.widget.watch([[sh -c "~/scripts/volume -v"]], .1, function(_, stdout)
	local volume = tonumber(stdout)
	update_prog(volume)
end)

timeout = gears.timer {
	timeout = 2,
	autostart = true,
	callback = function()
		volumepopup.visible = false
		volumepopup.screen = awful.screen.focused()
	end
}

function vis_toggle()
  volumepopup.visible = true
	if timeout.started then
		timeout:again()
	else
		timeout:start()
	end
end

volume_bar = wibox.widget {
	value = nil,
	max_value = 100,
	forced_height = dpi(10),
	forced_width = dpi(200),
	widget = wibox.widget.progressbar
}

volumepopup = awful.popup ({
	widget = {
		{
			volume_bar,
			layout = wibox.layout.fixed.vertical,
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	border_width = dpi(0),
	ontop = true,
	placement = function()
		awful.placement.bottom(volumepopup, { margins = dpi(20) })
	end,
	visible = false
})
