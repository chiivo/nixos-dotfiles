# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

###############################################################################

import os
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401

###############################################################################

#Colors

pink = "#f5d1c8"

black = "#262727"

darkblack = "#0e0e0e"

###############################################################################

mod = "mod4"

terminal = guess_terminal("kitty")

###############################################################################

keys = [
    # Switch between windows
    Key([mod], "j", lazy.layout.left(),
        desc="Move focus to left"),

    Key([mod], "l", lazy.layout.right(),
        desc='Move focus to right'),

    Key([mod], "k", lazy.layout.down(),
        desc="Move focus down"),

    Key([mod], "i", lazy.layout.up(),
        desc="Move focus up"),

    Key([mod], "Tab", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "j", lazy.layout.shuffle_left(),
        desc="Move window to the left"),

    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),

    Key([mod, "shift"], "k", lazy.layout.shuffle_down(),
        desc="Move window down"),

    Key([mod, "shift"], "i", lazy.layout.shuffle_up(),
        desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "j", lazy.layout.grow_left(),
        desc="Grow window to the left"),

    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),

    Key([mod, "control"], "k", lazy.layout.grow_down(),
        desc="Grow window down"),

    Key([mod, "control"], "i", lazy.layout.grow_up(),
        desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(),
        desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes

    # Key([mod], "Return", lazy.layout.toggle_split(),
            # desc="Toggle between split and unsplit sides of stack"),

    Key([mod, "shift"], "Return", lazy.spawn(terminal),
            desc="Launch terminal"),

    # Toggle between different layouts as defined below

    Key([mod], "space", lazy.next_layout(),
	    lazy.hide_show_bar(),
            desc="Toggle between layouts"),

    Key([mod, "shift"], "c", lazy.window.kill(),
            desc="Kill focused window"),

    Key([mod], "q", lazy.restart(),
            desc="Restart Qtile"),

    Key([mod, "shift"], "q", lazy.shutdown(),
            desc="Shutdown Qtile"),

    #Custom Keymaps

    Key([mod], "p", lazy.spawn("rofi -show drun -icon-theme Flatery-Blue-Dark")),

    Key([mod, "shift"], "p", lazy.spawn("scrot -s Images/Screenshots/scrot.png")),

    Key([mod], "Up", lazy.spawn("amixer -c 0 sset Master 10%+ unmute")),

    Key([mod], "Down", lazy.spawn("amixer -c 0 sset Master 10%- unmute")),

    Key([mod, "shift"], "Down", lazy.spawn("amixer set Master toggle")),

    # Key ([mod], "space", lazy.window.toggle_fullscreen()),
]

###############################################################################

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group

        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),

        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

###############################################################################

layouts = [
    # layout.Columns(
    #     border_focus=pink,
    #     border_normal=black,
    #     border_on_single="true",
    #     margin=8),

    layout.MonadTall(
        border_focus=pink,
        border_normal=black,
        margin=8),

    layout.Max(),

    # layout.Stack(
    #     border_width=2,
    #     border_focus=pink,
    #     border_normal=black,
    #     num_stacks=1),

    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

###############################################################################

#Layouts

widget_defaults = dict(
        font="scientifica",
        fontsize=18,
        padding=8,)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [   widget.Spacer(
                    length=8),

                widget.GroupBox(
                    foreground=black,
                    active=black,
                    inactive=black,
                    block_highlight_text_color=pink,
                    borderwidth=2,
                    margin=3,
                    padding=3,
                    highlight_method="block",
                    this_current_screen_border=black),

                widget.Spacer(),

                widget.Clock(
                    foreground=black,
                    format=" %H:%M"),

                widget.Sep(
                    foreground=black,
                    linewidth=2),

                widget.Clock(
                    foreground=black,
                    format=" %m/%d"),

                widget.Spacer(),

                widget.OpenWeather(
                    foreground=black,
                    location="westminster,US",
                    format="{main_temp} °{units_temperature}"),

                widget.Sep(
                    foreground=black,
                    linewidth=2),

                widget.TextBox(
                    foreground=black,
                    padding=0,
                    text=" "),

                widget.Volume(
                    foreground=black,),

                widget.Sep(
                    foreground=black,
                    linewidth=2),

                widget.Battery(
                    foreground=black,
                    update_interval=1,
                    format=" {percent:2.0%}"),

                widget.Sep(
                    foreground=black,
                    linewidth=2),

                widget.Systray(),

                widget.Spacer(
                    length=8),
            ],
            30,
            margin=[8,8,0,8],
            background=pink
        ),
    ),
]

###############################################################################

#Floating Windows

floating_layout = layout.Floating(float_rules=[

    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,

    Match(wm_class='confirmreset'),

    Match(wm_class='makebranch'),

    Match(wm_class='maketag'),

    Match(wm_class='ssh-askpass'),

    Match(title='branchdialog'),

    Match(title='pinentry'),

    Match(wm_class='Places'),

    Match("Confirm File Replacing"),
],

border_width=2,

border_focus=pink,

border_normal=black,
)

###############################################################################

# Drag floating layouts.

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),

    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),

    Click([mod], "Button2", lazy.window.bring_to_front()
)]

###############################################################################

dgroups_key_binder = None

dgroups_app_rules = []  # type: List

main = None  # WARNING: this is deprecated and will be removed soon

follow_mouse_focus = True

bring_front_click = False

cursor_warp = False

auto_fullscreen = True

focus_on_window_activation = "smart"
            
###############################################################################

#Hooks

@hook.subscribe.startup_once
def autostart():
        home = os.path.expanduser(".config/qtile/autostart.sh")
        subprocess.call([home])

###############################################################################

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.

wmname = "qtile"
