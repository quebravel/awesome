--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"
--theme.wallpaper                                 = theme.dir .. "/wall.png"
-- theme.font                                      = "monospace 9"
theme.font                                      = "Terminus 9"
theme.fg_normal                                 = "#999999"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#363636"
theme.bg_focus                                  = "#1E2320"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#00CCFF"
theme.tasklist_bg_focus                         = "#222222"
theme.tasklist_fg_focus                         = "#00CCFF"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#00CCFF"
theme.border_marked                             = "#CC9393"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
--theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
--theme.widget_battery                            = theme.dir .. "/icons/battery.png"
--theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
--theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
--theme.widget_brightness                         = theme.dir .. "/icons/brightness.png"
--theme.widget_mem                                = theme.dir .. "/icons/mem.png"
--theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
--theme.widget_net                                = theme.dir .. "/icons/net.png"
--theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
--theme.widget_music                              = theme.dir .. "/icons/note.png"
--theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
--theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
--theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
--theme.widget_mail                               = theme.dir .. "/icons/mail.png"
--theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
--theme.widget_task                               = theme.dir .. "/icons/task.png"
--theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
-- local clockicon = wibox.widget.imagebox(theme.widget_clock)
-- local clock = awful.widget.watch(
--     "date +'%a %d %b %R'", 60,
--     function(widget, stdout)
--         widget:set_markup(" " .. markup.font(theme.font, stdout))
--     end
-- )


-- ALSA volume
--theme.volume = lain.widget.alsabar({
--    --togglechannel = "IEC958,3",
--    notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
--})

-- ALSA volume
-- local volicon = wibox.widget.imagebox(theme.widget_vol)
-- theme.volume = lain.widget.alsa({
--     settings = function()
--         if volume_now.status == "off" then
--             volicon:set_image(theme.widget_vol_mute)
--         elseif tonumber(volume_now.level) == 0 then
--             volicon:set_image(theme.widget_vol_no)
--         elseif tonumber(volume_now.level) <= 50 then
--             volicon:set_image(theme.widget_vol_low)
--         else
--             volicon:set_image(theme.widget_vol)
--         end
-- 
--         widget:set_markup(markup.font(theme.font, "" .. volume_now.level .. "% "))
--     end
-- })
-- theme.volume.widget:buttons(awful.util.table.join(
--                                awful.button({}, 4, function ()
--                                      awful.util.spawn("amixer set Master 1%+")
--                                      theme.volume.update()
--                                end),
--                                awful.button({}, 5, function ()
--                                      awful.util.spawn("amixer set Master 1%-")
--                                      theme.volume.update()
--                                end)
-- ))

--[[ Coretemp (lain, average)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})
--]]
-- local tempicon = wibox.widget.imagebox(theme.widget_temp)

local temperatura = awful.widget.watch(
--      'cat /sys/class/thermal/thermal_zone0/temp', 30,
      'vcgencmd measure_temp', 30,
      function(widget, stdout)
--        local temp = string.match(stdout, "(%d%d)%d%d%d")
        local temp = string.match(stdout, "%d%d")
        widget:set_text(temp .. "°C")
        return
      end)
temperatura.font = theme.font

-- ALSA volume bar copland
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar {
    width = dpi(59), border_width = 0, ticks = true, ticks_size = dpi(6),
    notification_preset = { font = theme.font },
    --togglechannel = "IEC958,3",
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(theme.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(theme.vol_low)
        else
            volicon:set_image(theme.vol)
        end
    end,
    colors = {
        background   = theme.bg_normal,
        mute         = red,
        unmute       = theme.fg_normal
    }
}
theme.volume.tooltip.wibox.fg = theme.fg_focus
theme.volume.bar:buttons(my_table.join (
          awful.button({}, 1, function()
            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
          end),
          awful.button({}, 2, function()
            os.execute(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 3, function()
            os.execute(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 4, function()
            os.execute(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 5, function()
            os.execute(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end)
))
local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, dpi(2), dpi(4), dpi(4), dpi(4))


-- Textclock multcolor
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#00CCFF", "%A %d %B ") .. markup("#00afaf", ">") .. markup("#50fa7b", " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- / fs
-- local fsicon = wibox.widget.imagebox(theme.widget_hdd)
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
    settings = function()
        local fsp = string.format(" %3.2f %s ", fs_now["/"].free, fs_now["/"].units)
        widget:set_markup(markup.font(theme.font, fsp))
    end
})
--]]

-- Battery
--local baticon = wibox.widget.imagebox(theme.widget_battery)
--local bat = lain.widget.bat({
--    settings = function()
--        if bat_now.status and bat_now.status ~= "N/A" then
--            if bat_now.ac_status == 1 then
--                widget:set_markup(markup.font(theme.font, " AC "))
--                baticon:set_image(theme.widget_ac)
--                return
--            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
--                baticon:set_image(theme.widget_battery_empty)
--            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
--                baticon:set_image(theme.widget_battery_low)
--            else
--                baticon:set_image(theme.widget_battery)
--            end
--            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
--        else
--            widget:set_markup()
--            baticon:set_image(theme.widget_ac)
--        end
--    end
--})


-- Brigtness
-- local brighticon = wibox.widget.imagebox(theme.widget_brightness)
-- If you use xbacklight, comment the line with "light -G" and uncomment the line bellow
-- local brightwidget = awful.widget.watch('xbacklight -get', 0.1,
--local brightwidget = awful.widget.watch('light -G', 0.1,
--    function(widget, stdout, stderr, exitreason, exitcode)
--        local brightness_level = tonumber(string.format("%.0f", stdout))
--        widget:set_markup(markup.font(theme.font, " " .. brightness_level .. "%"))
--end)

-- Separators
-- local arrow = separators.arrow_left
-- 
-- function theme.powerline_rl(cr, width, height)
--     local arrow_depth, offset = height/2, 0
-- 
--     -- Avoid going out of the (potential) clip area
--     if arrow_depth < 0 then
--         width  =  width + 2*arrow_depth
--         offset = -arrow_depth
--     end
-- 
--     cr:move_to(offset + arrow_depth         , 0        )
--     cr:line_to(offset + width               , 0        )
--     cr:line_to(offset + width - arrow_depth , height/2 )
--     cr:line_to(offset + width               , height   )
--     cr:line_to(offset + arrow_depth         , height   )
--     cr:line_to(offset                       , height/2 )
-- 
--     cr:close_path()
-- end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, dpi(16), dpi(16)), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(16), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --wibox.container.background(wibox.container.margin(wibox.widget {tempicon, temperatura, layout = wibox.layout.align.horizontal }, dpi(4), dpi(4)), "#264d00"),
            --wibox.container.background(wibox.container.margin(volicon, dpi(0), dpi(0)), "#336600"),
            --wibox.container.background(wibox.container.margin(theme.volume.widget, dpi(0), dpi(0)), "#336600"),
            --wibox.container.background(wibox.container.margin(clock, dpi(4), dpi(8)), "#333399"),
            wibox.container.background(wibox.container.margin(temperatura, dpi(4), dpi(4)),"#264d00"),
            wibox.container.margin(volumewidget, dpi(4), dpi(4)),
            mytextclock,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
end

return theme
