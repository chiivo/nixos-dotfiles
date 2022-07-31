local awful = require("awful")

-- Tags for each screen
awful.screen.connect_for_each_screen(
	function(s)
		awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])
	end
)
