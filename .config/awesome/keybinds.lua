local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
require("bar")
require("volume")
-- require("scratchpads")

modkey = "Mod4"

-- This is used later as the default terminal and editor to run.
terminal = "alacritty" or "kitty"
editor = "nvim" or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Global Keybindings
globalkeys = gears.table.join(
	
	-- Unminimize Window
	awful.key({ modkey, "Control" }, "n",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal(
					"request::activate", "key.unminimize", {raise = true}
				)
			end
		end,
		{description = "restore minimized", group = "client"}
	),
	-- Help Screen
	awful.key({ modkey, }, "s",
		hotkeys_popup.show_help,
		{description="show help", group="awesome"}),
	-- Switch Tags
	awful.key({ modkey, }, "Left",
		awful.tag.viewprev,
		{description = "view previous", group = "tag"}),
	awful.key({ modkey, }, "Right",
		awful.tag.viewnext,
		{description = "view next", group = "tag"}),
	-- Switch Window Focus
	awful.key({ modkey, }, "j",
		function ()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus next by index", group = "client"}
	),
	awful.key({ modkey, }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
	),
	awful.key({ modkey, }, "u",
		awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}
	),
	awful.key({ modkey, }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}
	),
	-- Change Window Order
	awful.key({ modkey, "Shift" }, "j",
		function ()
			awful.client.swap.byidx(  1)
		end,
		{description = "swap with next client by index", group = "client"}
	),
	awful.key({ modkey, "Shift" }, "k",
		function ()
			awful.client.swap.byidx( -1)
		end,
		{description = "swap with previous client by index", group = "client"}
	),
	-- Switch Screen Focus
	awful.key({ modkey, }, "h",
		function ()
			awful.screen.focus_relative( 1)
		end,
		{description = "focus the next screen", group = "screen"}
	),
	awful.key({ modkey, }, "l",
		function ()
			awful.screen.focus_relative(-1)
		end,
		{description = "focus the previous screen", group = "screen"}
	),
	-- Resize Windows
	awful.key({ modkey, "Shift" }, "l",
		function ()
			awful.tag.incmwfact( 0.051)
		end,
		{description = "increase master width factor", group = "layout"}
	),
	awful.key({ modkey, "Shift" }, "h",
		function ()
			awful.tag.incmwfact(-0.051)
		end,
		{description = "decrease master width factor", group = "layout"}
	),
	-- Open Terminal
	awful.key({ modkey, "Shift" }, "Return",
		function ()
			awful.spawn(terminal)
		end,
		{description = "open a terminal", group = "launcher"}
	),
	-- Reload Awesome
	awful.key({ modkey, }, "q",
		awesome.restart,
		{description = "reload awesome", group = "awesome"}
	),
	-- Quit Awesome
	awful.key({ modkey, "Shift" }, "q",
		awesome.quit,
		{description = "quit awesome", group = "awesome"}
	),
	-- Rofi
	awful.key({ modkey }, "p",
		function()
			awful.spawn("rofi -show")
		end,
		{description = "show rofi", group = "launcher"}
	),
	-- Screenshot
	awful.key({ }, "Print",
		function()
			awful.spawn.with_shell("~/scripts/screenshot -c")
		end,
		{description = "Copy Screenshot", group = "Screenshot"}
	),
	awful.key({ modkey }, "Print",
		function()
			awful.spawn.with_shell("~/scripts/screenshot -s")
		end,
		{description = "Save Clipboard", group = "Screenshot"}
	),
	-- Volume
	awful.key({ }, "XF86AudioRaiseVolume",
		function()
			awful.spawn.with_shell("~/scripts/volume -u")
			volsymupdate()
			volbarvalupdate()
			volbar_vis_toggle()
		end,
		{description = "Volume Up", group = "Volume"}
	),
	awful.key({ }, "XF86AudioLowerVolume",
		function()
			awful.spawn.with_shell("~/scripts/volume -d")
			volsymupdate()
			volbarvalupdate()
			volbar_vis_toggle()
		end,
		{description = "Volume Down", group = "Volume"}
	),
	awful.key({ }, "XF86AudioMute",
		function()
			awful.spawn.with_shell("~/scripts/volume -m")
			volsymupdate()
			volbarvalupdate()
			volbar_vis_toggle()
		end,
		{description = "Mute Volume", group = "Volume"}
	),
	-- Bottom
	awful.key({ modkey, "Shift" }, "Escape",
		function()
			btm_scratch:toggle()
		end,
		{description = "Spawn Bottom", group = "launcher"}
	),
	-- Scratchpad
	awful.key({ modkey, }, "Return",
		function()
			term_scratch:toggle()
		end,
		{description = "Spawn Scratchpad", group = "launcher"}
	),
	-- Toggle Bar
	awful.key({ modkey, }, "b",
		function()
			bartoggle()
		end,
		{description = "Toggle Bar", group = "screen"}
	)
)
-- Client Keybindings
clientkeys = gears.table.join(
	-- Set Fullscreen
	awful.key({ modkey, }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}
	),
	-- Close Window
	awful.key({ modkey, "Shift" }, "c",
		function (c)
			c:kill()
		end,
		{description = "close", group = "client"}
	),
	-- Toggle Floating
	awful.key({ modkey, "Control" }, "space",
		awful.client.floating.toggle,
		{description = "toggle floating", group = "client"}
	),
	-- Move to Master
	awful.key({ modkey, "Control" }, "Return",
		function (c)
			c:swap(awful.client.getmaster())
		end,
		{description = "move to master", group = "client"}
	),
	-- Move to Unfocused Screen
	awful.key({ modkey, }, "o",
		function (c)
			c:move_to_screen()
		end,
		{description = "move to screen", group = "client"}
	),
	-- Minimize Window
	awful.key({ modkey, }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be minimized, since minimized clients can't have the focus.
			c.minimized = true
		end,
		{description = "minimize", group = "client"}
	),
	-- Maximize Window
	awful.key({ modkey, }, "m",
		function (c)
			c.maximized = not c.maximized
			c:raise()
		end,
		{description = "(un)maximize", group = "client"}
	)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout. This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = "tag"}
		),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}
		)
	)
end

root.keys(globalkeys)
