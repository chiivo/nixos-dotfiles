local naughty = require("naughty")
local awful = require("awful")

-- Table to store all notifications
local notifications = {}

-- Function to add a new notification
local function add_notification(args)
	local notif = naughty.notify({
		text = args.text,
		title = args.title or "",
		timeout = args.timeout or 5,
		screen = args.screen or awful.screen.focused(),
		position = args.position or "top_right",
		margin = args.margin or 5,
		height = args.height or nil,
		width = args.width or nil,
		replaces_id = args.replaces_id or nil,
		preset = args.preset or nil,
		run = args.run or nil,
		destroy = function()
			-- Remove the notification from the table when it is destroyed
			for i, v in ipairs(notifications) do
				if v == notif then
					table.remove(notifications, i)
					break
				end
			end
		end
	})

	-- Add the notification to the table
	table.insert(notifications, notif)
end

-- Function to clear all notifications
local function clear_notifications()
	for _, notif in ipairs(notifications) do
		naughty.destroy(notif)
	end
	notifications = {}
end
