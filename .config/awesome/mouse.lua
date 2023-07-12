local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

modkey = "Mod4"
terminal = "alacritty" or "kitty"

-- Right Click Variables
local powermenu = {
	{ "Shut Down",
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

local screenshot = {
	{ "Copy",
		function()
			awful.spawn.with_shell("~/scripts/screenshot -c")
		end
	},
	{ "Save",
		function()
			awful.spawn.with_shell("~/scripts/screenshot -s")
		end
	}
}

-- Right Click Menu Setup
local menu = awful.menu({
	items = {
		{ "Power Menu", powermenu },
		{ "Emacs", "emacs" },
		{ "Terminal", terminal },
		{ "Screenshot", screenshot },
	}
})

-- Menu Mouse Buttons
root.buttons(gears.table.join(
	awful.button({ }, 3,
		function ()
			menu:show()
		end
	),
	awful.button({ }, 1,
		function ()
			menu:hide()
		end
	)
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

-- Mouse follows focus
local function move_mouse_onto_focused_client(c)
	if mouse.object_under_pointer() ~= c then
		local geometry = c:geometry()
		local x = geometry.x + geometry.width/2
		local y = geometry.y + geometry.height/2
		mouse.coords({x = x, y = y}, true)
	end
end
client.connect_signal("focus", move_mouse_onto_focused_client)
