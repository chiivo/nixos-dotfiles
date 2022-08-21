local bling = require("bling")

term_scratch = bling.module.scratchpad {
	command = "alacritty --class scratchpad", -- How to spawn the scratchpad
	rule = { instance = "scratchpad" }, -- The rule that the scratchpad will be searched by
	sticky = true, -- Whether the scratchpad should be sticky
	autoclose = true, -- Whether it should hide itself when losing focus
	floating = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
	geometry = { -- The geometry in a floating state
		x=360,
		y=90,
		height=900,
		width=1200
	},
	reapply = true,  -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
	dont_focus_before_close  = false,  -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
}

btm_scratch = bling.module.scratchpad {
	command = "alacritty --class btm -e btm", -- How to spawn the scratchpad
	rule = { instance = "btm" }, -- The rule that the scratchpad will be searched by
	sticky = true, -- Whether the scratchpad should be sticky
	autoclose = true, -- Whether it should hide itself when losing focus
	floating = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
	geometry = { -- The geometry in a floating state
		x=360,
		y=90,
		height=900,
		width=1200
	},
	reapply = true,  -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
	dont_focus_before_close  = false,  -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
}

-- term_scratch:toggle()   -- toggles the scratchpads visibility
-- term_scratch:turn_on()  -- turns the scratchpads visibility on
-- term_scratch:turn_off() -- turns the scratchpads visibility off
