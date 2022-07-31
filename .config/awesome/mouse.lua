local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

modkey = "Mod4"
terminal = "alacritty"

-- Right Click Menu
powermenu = {
	{ "Power Off",
		function()
			awful.spawn.with_shell("poweroff")
		end
	},
	{ "Reboot",
		function()
			awful.spawn.with_shell("reboot")
		end
	},
	{ "Logout",
		function()
			awesome.quit()
		end
	}
}
mymainmenu = awful.menu({
	items = {
		{ "Open Terminal", terminal },
		{ "Power Menu", powermenu }
	}
})

root.buttons(gears.table.join(
	awful.button({ }, 3,
		function ()
			mymainmenu:toggle()
		end
	)
	-- awful.button({ }, 4, awful.tag.viewnext),
	-- awful.button({ }, 5, awful.tag.viewprev)
))
clientbuttons = gears.table.join(
	awful.button({ }, 1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end
	),
	awful.button({ modkey }, 1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end
	),
	awful.button({ modkey }, 3,
		function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end
	)
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
