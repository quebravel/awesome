-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
-- local myExtraKeys = require "myExtraKeys"
pcall(require, "luarocks.loader")
local freedesktop = require("freedesktop")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local bling = require("bling")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

-- local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")

require("awful.hotkeys_popup.keys")
require("collision")()

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "mytheme.lua") -- zenburn sky
-- beautiful.init(gears.filesystem.get_themes_dir("config") .. "zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("nvim") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1" -- modifiquei aqui

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
	-- bling.layout.mstab,
	bling.layout.centered,
	bling.layout.vertical,
	bling.layout.horizontal,
	bling.layout.equalarea,
	bling.layout.deck,
}
-- }}}

-- {{{ Menu
--------------------------------------------------------------------------------
myawesomemenu = {
	{
		"hotkeys",
		function()
			return false, hotkeys_popup.show_help
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
	{
		"shutdown",
		function()
			os.execute(string.format("poweroff"))
		end,
	},
	{
		"reboot",
		function()
			os.execute(string.format("reboot"))
		end,
	},
}

-- data na linguagem local
-- os.setlocale(os.getenv("LANG")) 

mymainmenu = freedesktop.menu.build({
	before = {
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		-- other triads can be put here
	},
	after = {
		{ "Open terminal", terminal },
		-- other triads can be put here
	},
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
--------------------------------------------------------------------------------

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- or customized
local cw = calendar_widget({
	theme = "light",
	placement = "top_right",
	start_sunday = false,
	radius = 8,
	-- with customized next/previous (see table above)
	previous_month_button = 1,
	next_month_button = 3,
})
mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)
---
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		-- gears.wallpaper.centered(wallpaper, s)
    gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = 19 }) -- bottom

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			todo_widget(),
			fs_widget(), --default
			-- volume_widget({ -- modifiquei aqui
			-- 	widget_type = "arc",
			-- }),
			awful.widget.watch('curl wttr.in/ananindeua?format=+%c%t+%C&lang=pt', 600),
			mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(

	-- brilho de tela
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("xbacklight -inc 10", false)
	end),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("xbacklight -dec 10", false)
	end),

	-- Amplitude do audio teclas de atalho | alsa
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.util.spawn("amixer -q -D pulse sset Master 5%-", false)
	end),
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.util.spawn("amixer -q -D pulse sset Master 5%+", false)
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.util.spawn("amixer -D pulse set Master 1+ toggle", false)
	end),
	-- Media Keys
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false)
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false)
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false)
	end),

	awful.key({}, "Print", function()
		awful.spawn.with_shell("maim ~/Imagens/Screenshot_$(date +%Y%m%d)_$(date +%H%M%S).png", false)
	end, { description = "Print desktop", group = "Screenshot" }),

	awful.key({ modkey }, "Print", function()
		awful.spawn.with_shell(
			"maim -i $(xdotool getactivewindow) ~/Imagens/Screenshot_$(date +%Y%m%d)_$(date +%H%M%S).png",
			false
		)
	end, { description = "Print window", group = "Screenshot" }),

	awful.key({ "Shift" }, "Print", nil, function()
		awful.spawn.with_shell("maim -s ~/Imagens/Screenshot_$(date +%Y%m%d)_$(date +%H%M%S).png", false)
	end, { description = "Print area", group = "Screenshot" }),

	awful.key({ "Control" }, "Print", nil, function()
		awful.spawn.with_shell("maim -s | xclip -selection c -t image/png", false)
	end, { description = "Print area to clipboard", group = "Screenshot" }),

	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	--------------------------------------------------------------------------------
	-- modifiquei aqui
	-- awful.key({ modkey }, "j", function()
	-- 	awful.client.focus.byidx(1)
	-- end, { description = "focus next by index", group = "client" }),
	-- awful.key({ modkey }, "k", function()
	-- 	awful.client.focus.byidx(-1)
	-- end, { description = "focus previous by index", group = "client" }),

	----- By-direction client focus -----------------------------------------------
	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),
	--------------------------------------------------------------------------------

	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  -- Show/hide wibox
  awful.key({ modkey }, "b", function ()
          for s in screen do
              s.mywibox.visible = not s.mywibox.visible
              if s.mybottomwibox then
                  s.mybottomwibox.visible = not s.mybottomwibox.visible
              end
          end
      end,
      {description = "toggle wibox", group = "awesome"}),

	-- modifiquei aqui
	awful.key({ "Ctrl", altkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ "Ctrl", altkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ "Ctrl", altkey }, "j", function()
		awful.client.incwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ "Ctrl", altkey }, "k", function()
		awful.client.incwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	-------------------------------------------------------------------------
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ modkey, 'Control' }, 't',
		awful.titlebar.toggle,
		{description = 'toggle title bar', group = 'client'}),
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			size_hints_honor = false,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- Barra de titulos somente em janelas flutuantes 
--- Toggle titlebar on or off depending on s. Creates titlebar if it doesn't exist
-- @tparam client c Client to update titlebar state
function manage_titlebar(c)
    -- Fullscreen clients are considered floating. Return to prevent clients from shifting down in fullscreen mode
    if c.fullscreen then
        return
    end
    local show = c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating
    if show then
        if c.titlebar == nil then
            c:emit_signal("request::titlebars", "rules", {})
        end
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
    -- Prevents titlebar appearing off the screen
    awful.placement.no_offscreen(c)
end

client.connect_signal("property::floating", function(c)
    manage_titlebar(c)
end)

tag.connect_signal("property::layout", function(t)
    for _, c in pairs(t:clients()) do
          manage_titlebar(c)
    end
end)
-- Barra de titulos 

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c,{size=16}):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Auto iniciar programas
-- do
-- 	local cmds = {
-- 		"picom",
-- 		"nm-applet",
-- 		"pkill gammastep-indicator; gammastep-indicator",
-- 		"pkill pasystray; pasystray",
-- 	}
-- 	for _, i in pairs(cmds) do
-- 		awful.util.spawn(i)
-- 	end
-- end

-- Auto iniciar programas e verifica se ja esta iniciado
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "picom", "pasystray", "nm-applet", "pkill gammastep; gammastep-indicator" }) -- comma-separated entries

-- Desabilita a borda quando existe somente uma janela.
screen.connect_signal("arrange", function(s)
	local max = s.selected_tag.layout.name == "max"
	local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
	-- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
	for _, c in pairs(s.clients) do
		if (max or only_one) and not c.floating or c.maximized then
			c.border_width = 0
		else
			c.border_width = beautiful.border_width
		end
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
-- 	c:emit_signal("request::activate", "mouse_enter", { raise = false })
-- end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}
