pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  })
end
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    if in_error then return end
    in_error = true
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    })
    in_error = false
  end)
end

terminal = os.getenv("T")
editor = os.getenv("EDITOR")
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
awful.layout.layouts = {awful.layout.suit.tile, awful.layout.suit.floating}

tags = {
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'm', 'n', 'o', 'p', 'r', 's', 't',
  'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8',
  '9', "Escape",
}

awful.screen.connect_for_each_screen(function(s)
  awful.tag(tags, s, awful.layout.layouts[1])
end)

view_only_tag = function(idx)
  local screen = awful.screen.focused()
  local tag = screen.tags[idx]
  if tag then tag:view_only() end
end

move_to_tag = function(idx)
  if client.focus then
    local tag = client.focus.screen.tags[idx]
    if tag then client.focus:move_to_tag(tag) end
  end
end
globalkeys = {}
for k, v in ipairs(tags) do
  globalkeys = gears.table.join(globalkeys, awful.key({modkey}, v, function()
    view_only_tag(k)
  end), awful.key({modkey, 'Shift'}, v, function() move_to_tag(k) end))
end

globalkeys = gears.table.join(globalkeys, awful.key({modkey}, "h", function()
  awful.client.focus.bydirection("left")
  if client.focus then client.focus:raise() end
end), awful.key({modkey}, "j", function()
  awful.client.focus.bydirection("down")
  if client.focus then client.focus:raise() end
end), awful.key({modkey}, "k", function()
  awful.client.focus.bydirection("up")
  if client.focus then client.focus:raise() end
end), awful.key({modkey}, "l", function()
  awful.client.focus.bydirection("right")
  if client.focus then client.focus:raise() end
end), awful.key({modkey}, "Tab", awful.tag.history.restore,
                {description = "go back", group = "tag"}),
                              awful.key({modkey}, "Return",
                                        function() awful.spawn(terminal) end, {
  description = "open a terminal",
  group = "launcher",
}), awful.key({modkey, "Control"}, "r", awesome.restart),
                              awful.key({modkey, "Shift"}, "q", awesome.quit, {
  description = "quit awesome",
  group = "awesome",
}))

clientkeys = gears.table.join(
               awful.key({modkey}, "q", function(c) c:kill() end),
               awful.key({modkey}, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end))

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
  c:emit_signal("request::activate", "mouse_click", {raise = true})
end), awful.button({modkey}, 1, function(c)
  c:emit_signal("request::activate", "mouse_click", {raise = true})
  awful.mouse.client.move(c)
end), awful.button({modkey}, 3, function(c)
  c:emit_signal("request::activate", "mouse_click", {raise = true})
  awful.mouse.client.resize(c)
end))
browser = os.getenv("BROWSER")
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
      border_width = 0,
      border_color = 0,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  }, -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
        "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui", "veromix", "xtightvncviewer",
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "popup", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = {floating = true},
  }, -- Add titlebars to normal clients and dialogs
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and
    not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c)
  local scale = '1'
  if c.class == 'Chromium' then scale = '6' end
  scroll_scale_file = io.open('/tmp/libinput_discrete_deltay_multiplier', 'r+')
  -- scroll_scale_file:seek("set", 0)
  scroll_scale_file:write(scale)
end)
