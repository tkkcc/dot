require("mp")
-- mp.observe_property("estimated-frame-number", nil, function(name)

mp.observe_property("time-pos", nil, function()
  local num = mp.get_property("estimated-frame-number")
  local count = mp.get_property("estimated-frame-count")
  num = tonumber(num) or 0
  count = tonumber(count) or 0
  mp.commandv("show-text", "half frame: " .. math.floor(num / 2) .. ' / ' ..
                math.floor(count / 2) .. "\n".."quarter frame: " .. math.floor(num / 4) .. ' / ' ..
                math.floor(count / 4), -1, 3)
end)
