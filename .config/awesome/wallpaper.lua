local awful = require("awful")
local gears = require("gears")
-- local bling = require("bling")
require("theme")

-- Tile
--[[ awful.screen.connect_for_each_screen(function(s) -- that way the wallpaper is applied to every screen
	bling.module.tiled_wallpaper("", s, {       -- call the actual function ("x" is the string that will be tiled)
		fg = colors.pink, -- define the foreground color
		bg = colors.darkblack, -- define the background color
		offset_y = 30,  -- set a y offset
		offset_x = 10,  -- set a x offset
		font = "Symbols Nerd Font",  -- set the font (without the size)
		font_size = 16, -- set the font size
		padding = 100,  -- set padding (default is 100)
		zickzack = true -- rectangular pattern or criss cross
	})
end) ]]

-- Tiled Wallpaper
-- gears.wallpaper.tiled("/mnt/SSD/Images/Wallpapers/Tile-Pokemon/Gastly.png", s)

-- Solid Color
gears.wallpaper.set(colors.darkblack)
