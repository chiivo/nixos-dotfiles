local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir()
local naughty = require("naughty")

colors = {
	-- darkblack = '#141515',
	darkblack = '#191a1a',
	black = '#262727',
	red = '#ff8278',
	orange = '#ffc178',
	yellow = '#eadc84',
	green = '#bde077',
	blue = '#77bee0',
	magenta = '#dd91f3',
	pink = '#f5d1c8',
	gray = '#555657',
	white = '#dddddd'
}

local theme = {}

theme.font = "monospace Medium 16"

theme.bg_systray = colors.black

theme.bg_normal = colors.black
theme.bg_focus = colors.pink
theme.bg_urgent = colors.red
theme.bg_minimize = colors.gray

theme.fg_normal = colors.pink
theme.fg_focus = colors.black
theme.fg_urgent = colors.black
theme.fg_minimize = colors.black

theme.useless_gap = dpi(10)
theme.border_width = dpi(4)
theme.border_normal = colors.black
theme.border_focus = colors.pink
theme.border_marked = colors.red

theme.taglist_bg_focus = colors.black
theme.taglist_fg_focus = colors.pink
theme.taglist_bg_urgent = colors.black
theme.taglist_fg_urgent = colors.red
theme.taglist_bg_occupied = colors.black
theme.taglist_fg_occupied = colors.white
theme.taglist_bg_empty = colors.black
theme.taglist_fg_empty = colors.gray

-- Notification Config
theme.notification_font = "monospace 12"
theme.notification_bg = colors.black
theme.notification_fg = colors.pink
theme.notification_border_color = colors.pink
theme.notification_width = dpi(360)
theme.notification_max_height = dpi(400)
naughty.config.padding = dpi(20)
naughty.config.spacing = dpi(10)
theme.notification_icon_size = 48
naughty.config.icon_dirs = {
	"/home/chivo/.icons/Papirus-Dark"
}
naughty.config.icon_formats = {
	"png",
	"jpg",
	"svg"
}
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_width = dpi(0)
naughty.config.defaults.timeout = 10
naughty.config.defaults.screen = 1

-- Right-click Menu
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(30)
theme.menu_width = dpi(200)
theme.menu_border_color = colors.pink
theme.menu_border_width = dpi(0)

-- Define the image to load
theme.titlebar_maximized_button_normal_inactive = gears.color.recolor_image(themes_path.."circle.svg", colors.black)
theme.titlebar_maximized_button_focus_inactive = gears.color.recolor_image(themes_path.."circle.svg", colors.green)
theme.titlebar_maximized_button_normal_active = gears.color.recolor_image(themes_path.."circle.svg", colors.black)
theme.titlebar_maximized_button_focus_active = gears.color.recolor_image(themes_path.."circle.svg", colors.green)
theme.titlebar_close_button_normal = gears.color.recolor_image(themes_path.."circle.svg", colors.black)
theme.titlebar_close_button_focus = gears.color.recolor_image(themes_path.."circle.svg", colors.red)

-- theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus = themes_path.."default/titlebar/close_focus.png"
-- theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus = themes_path.."default/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path.."default/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path.."default/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path.."default/titlebar/floating_focus_active.png"
-- theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive = themes_path.."default/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active = themes_path.."default/titlebar/maximized_focus_active.png"

-- Wallpaper
theme.wallpaper = themes_path.."default/background.png"

-- Layout Icons
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
	theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- App icon theme
theme.icon_theme = "Flatery-Pink-Dark"

-- Volume Popup
theme.progressbar_fg = colors.pink
theme.progressbar_bg = colors.gray
theme.progressbar_shape = gears.shape.rounded_rect
theme.progressbar_bar_shape = gears.shape.rounded_rect

-- Window Swallowing
theme.parent_filter_list = { "vivaldi-stable", "Vivaldi-stable" } -- class names list of parents that should not be swallowed
theme.child_filter_list = { "discord", "vivaldi-stable", "Vivaldi-stable", "chatterino" } -- class names list that should not swallow their parents
theme.swallowing_filter = true -- whether the filters above should be active

return theme
