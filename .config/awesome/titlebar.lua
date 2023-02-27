local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

client.connect_signal("request::titlebars", function(c)
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)

	titlebar = awful.titlebar(c, {
		size = dpi(30),
		position = 'left',
		bg_normal = colors.gray,
		bg_focus = colors.pink
	}):setup {
		{
			{
				awful.titlebar.widget.closebutton(c),
				awful.titlebar.widget.maximizedbutton(c),
				spacing = dpi(10),
				layout = wibox.layout.fixed.vertical
			},
			top = dpi(10),
			bottom = dpi(4),
			left = dpi(4),
			right = dpi(4),
			widget = wibox.container.margin,
		},
		{
			buttons = buttons,
			layout  = wibox.layout.flex.vertical
		},
		layout = wibox.layout.align.vertical
	}
end)

-- show titlebar when client is floating
client.connect_signal("property::floating", function(c)
  if c.floating and not (c.requests_no_titlebar or c.fullscreen or c.maximized) then
    awful.titlebar.show(c, 'left')
		c.border_width = dpi(0)
  else
    awful.titlebar.hide(c, 'left')
  end
end)

-- toggle titlebar maximized
client.connect_signal("property::maximized", function(c)
  if c.maximized then
    awful.titlebar.hide(c, 'left')
	elseif c.floating then
		awful.titlebar.show(c, 'left')
	end
end)

-- toggle titlebar tiled
client.connect_signal("property::tiled", function(c)
  if c.tiled then
    awful.titlebar.hide(c, 'left')
	end
end)

-- toggle titlebar when client is fullscreen
--[[ client.connect_signal("property::fullscreen", function(c)
  if c.fullscreen then
    awful.titlebar.hide(c, 'left')
	elseif c.floating then
		awful.titlebar.show(c, 'left')
	end
end) ]]

-- show titlebars when layout is set to floating
awful.tag.attached_connect_signal(nil, "property::layout", function(t)
  local float = t.layout.name == "floating"
  for _,c in pairs(t:clients()) do
    c.floating = float
  end
end)

-- titlebars are always shown when layout is set to floating
awful.tag.attached_connect_signal(nil, "tagged", function(t, c)
  if t.layout.name == "floating" then
    awful.titlebar.show(c, 'left')
  end
end)

-- set border width to 0 for floating or maximized clients
screen.connect_signal("arrange", function(s)
	-- local max = s.selected_tag.layout.name == "max"
	-- local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
	for _, c in pairs(s.clients) do
		-- if (max or only_one) and not c.floating or c.maximized then
		if c.floating or c.maximized then
			c.border_width = dpi(0)
		else
			c.border_width = beautiful.border_width
		end
	end
end)
