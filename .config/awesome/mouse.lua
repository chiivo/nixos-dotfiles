local gears = require("gears")
local awful = require("awful")

modkey = "Mod4"

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
