import os
import subprocess
from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401

###############################################################################

#Colors
pink="#f5d1c8"
lightgray="#555657"
darkgray="#262727"
black="#0e0e0e"

###############################################################################

#Terminal
mod="mod4"
terminal=guess_terminal("kitty")

###############################################################################

#Keybinds
keys=[
    #Switch between windows
    Key([mod], "h", lazy.layout.left(),
        desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(),
        desc='Move focus to right'),
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up"),
    Key([mod], "Tab", lazy.layout.next(),
        desc="Move window focus to other window"),
    #Move windows between left/right columns or move up/down in current stack.
    #Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),
    #Grow windows. If current window is on the edge of screen and direction
    #will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(),
        desc="Reset all window sizes"),
    Key([mod], "space", lazy.next_layout(),
        desc="Next Layout"),
    #Toggle between split and unsplit sides of stack.
    #Split=all windows displayed
    #Unsplit=1 window displayed, like Max layout, but still with
    #multiple stack panes
    Key([mod], "Return", lazy.group["scratchpad"].dropdown_toggle(terminal),
        desc="Spawn Dropdown terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(terminal),
         desc="Launch terminal"),
    Key([mod, "shift"], "c", lazy.window.kill(),
        desc="Kill focused window"),
    Key([mod], "q", lazy.restart(),
        desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(),
        desc="Shutdown Qtile"),
    #Group Keymaps
    Key([mod], "KP_End", lazy.group["I"].toscreen(toggle=False)),
    Key([mod, "shift"], "KP_End", lazy.window.togroup("I")),
    Key([mod], "KP_Down", lazy.group["II"].toscreen(toggle=False)),
    Key([mod, "shift"], "KP_Down", lazy.window.togroup("II")),
    Key([mod], "KP_Next", lazy.group["III"].toscreen(toggle=False)),
    Key([mod, "shift"], "KP_Next", lazy.window.togroup("III")),
    Key([mod], "KP_Left", lazy.group["IV"].toscreen(toggle=False)),
    Key([mod, "shift"], "KP_Left", lazy.window.togroup("IV")),
    Key([mod], "KP_Begin", lazy.group["V"].toscreen(toggle=False)),
    Key([mod, "shift"], "KP_Begin", lazy.window.togroup("V")),
    Key([mod], "Left", lazy.screen.prev_group()),
    Key([mod], "Right", lazy.screen.next_group()),
    #Custom Keymaps
    Key([mod], "p", lazy.spawn("rofi -show drun -icon-theme Flatery-Blue-Dark")),
    Key([], "Print", lazy.spawn(["sh", "-c", "maim -usb 2 | xclip -selection clipboard -t image/png"])),
    Key([mod], "Print", lazy.spawn(["sh", "-c", "maim -u /mnt/HDD/Images/Screenshots/maim-$(date +%m-%d-%T).png"]),
        lazy.spawn("notify-send 'Screenshot Captured!'")),
    Key([mod], "Up", lazy.spawn("pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo +5%"),
        lazy.spawn("pactl set-sink-volume bluez_sink.5C_C6_E9_14_A8_15.a2dp_sink +5%")),
    Key([mod], "Down", lazy.spawn("pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo -5%"),
        lazy.spawn("pactl set-sink-volume bluez_sink.5C_C6_E9_14_A8_15.a2dp_sink -5%")),
    Key([mod, "shift"], "Down", lazy.spawn("pactl set-sink-mute alsa_output.pci-0000_00_1b.0.analog-stereo toggle"),
        lazy.spawn("pactl set-sink-mute bluez_sink.5C_C6_E9_14_A8_15.a2dp_sink toggle")),
]

###############################################################################

#Groups
groups=[ScratchPad("scratchpad",
    [DropDown(
        terminal,
        terminal,
        x=.2,
        y=.2,
        width=.6,
        height=.6,
        opacity=1)]),
    Group("I",
        label="●",
        matches=[Match(wm_class=["firefox", "qutebrowser"])]),
    Group("II",
        label="●",
        matches=[Match(wm_class=["discord"])]),
    Group("III",
        label="●",
        matches=[Match(wm_class=["Blender", "kdenlive", "gimp-2.10", "lutris", "Steam", "minecraft-launcher", "retroarch", "rpcs3"])]),
    Group("IV",
        label="●",
        matches=[Match(wm_class=["obs", "chatterino"])]),
    Group("V",
        label="●",
        matches=[Match(wm_class=["pcmanfm", "spotify", "blueman-manager", "pentablet", "piper", "Zathura", "vlc", "pavucontrol-qt", "via", "lxappearance", "qt5ct"])])
]

###############################################################################

#Layouts
layouts=[
    #layout.Columns(
        #border_width=2,
        #border_focus=pink,
        #border_normal=darkgray,
        #border_on_single="true",
        #margin=10
        #),
    layout.RatioTile(
        border_width=2,
        border_focus=pink,
        border_normal=darkgray,
        margin=10,
        )
]

###############################################################################

#Bars & Widgets
widget_defaults=dict(
    foreground=darkgray,
    font="Comfortaa",
    fontsize=16,
    padding=10,)
extension_defaults = widget_defaults.copy()
screens=[
    Screen(
        top=bar.Bar([
            widget.Spacer(
                length=10),
            widget.GroupBox(
                active=darkgray,
                block_highlight_text_color=pink,
                borderwidth=3,
                disable_drag=True,
                highlight_color=darkgray,
                highlight_method="block",
                inactive=lightgray,
                margin=3,
                other_current_screen_border=darkgray,
                other_screen_border=darkgray,
                padding=2,
                this_current_screen_border=darkgray,
                this_screen_border=darkgray,
                use_mouse_wheel=False,),
            widget.Spacer(),
            widget.WindowName(
                format='{name}'),
            widget.Spacer(),
            widget.Volume(
                get_volume_command='amixer -D pulse get Master'.split(),
                padding=0,
                theme_path='.icons/Flatery-Blue/'),
            widget.Volume(
                get_volume_command='amixer -D pulse get Master'.split()),
            widget.Clock(
                format="%m/%d"),
            widget.Clock(
                format="%H:%M"),
            widget.Spacer(
                length=10),
        ],
        26,
        margin=[10,20,10,20], #NESW
        background=pink),
        right=bar.Gap(10),
        bottom=bar.Gap(10),
        left=bar.Gap(10)
    ),
    Screen(
        top=bar.Bar([
            widget.Spacer(
                length=10),
            widget.GroupBox(
                active=darkgray,
                block_highlight_text_color=pink,
                borderwidth=3,
                disable_drag=True,
                highlight_color=darkgray,
                highlight_method="block",
                inactive=lightgray,
                margin=3,
                other_current_screen_border=darkgray,
                other_screen_border=darkgray,
                padding=2,
                this_current_screen_border=darkgray,
                this_screen_border=darkgray,
                use_mouse_wheel=False,),
            widget.Spacer(),
            widget.WindowName(
                format='{name}'),
            widget.Spacer(),
            widget.Volume(
                get_volume_command='amixer -D pulse get Master'.split(),
                padding=0,
                theme_path='.icons/Flatery-Blue/'),
            widget.Volume(
                get_volume_command='amixer -D pulse get Master'.split()),
            widget.Clock(
                format="%m/%d"),
            widget.Clock(
                format="%H:%M"),
            widget.TextBox(
                text="●",
                fontsize=70,
                width=12,
                padding=0),
            widget.Systray(
                background=darkgray,
                icon_size=16),
            widget.Spacer(
                length=10,
                background=darkgray),
        ],
        26,
        margin=[10,20,10,20], #NESW
        background=pink),
        right=bar.Gap(10),
        bottom=bar.Gap(10),
        left=bar.Gap(10)
    ),
]

###############################################################################

#Floating Windows
floating_layout = layout.Floating(float_rules=[
    #Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(title="Friends List"),
    Match(title="Steam - News"),
    Match(title="Steam - Self Updater"),
    Match(title='branchdialog'),
    Match(title='pinentry'),
    Match(wm_class='confirmreset'),
    Match(wm_class='makebranch'),
    Match(wm_class='maketag'),
    Match(wm_class='ssh-askpass'),
    Match(wm_class='Places'),
    Match(wm_class="Confirm File Replacing"),
],
border_width=2,
border_focus=pink,
border_normal=darkgray)

###############################################################################

#Mouse Controls
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

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

#XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
#string besides java UI toolkits; you can see several discussions on the
#mailing lists, GitHub issues, and other WM documentation that suggest setting
#this string if your java app doesn't work correctly. We may as well just lie
#and say that we're a working one by default.
#We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
#java that happens to be on java's whitelist.
wmname = "qtile"
