
local CurrentPage = PageNames[props["page_index"].Value]


if CurrentPage == "Control" then

--------  Graphic Elements  -------

table.insert(graphics,{
  Type = "Text",
  Text = "Build Info",
  FontSize = 12,
  HTextAlign = "Left",
  Position = {0, 300},
  Size = {62, 20}
})
table.insert(graphics,{
  Type = "Text",
  Text = "v" .. PluginInfo.BuildVersion,
  FontSize = 12,
  HTextAlign = "Left",
  Position = {0, 320},
  Size = {62, 20}
})
table.insert(graphics,{
  Type="Image",
  Image=sig,
  Position={0,280},
  Size={20,23}
})

table.insert(graphics,{
  Type="Image",
  Image=electrosoniclogo,
  Position={550,320},
  Size={175,20}
})

table.insert(graphics,{
  Type="Image",
  Image=extronlogo,
  Position={550,0},
  Size={200,60}
})

-- Connection Controls   -------------

table.insert(graphics, {
  Type = "Text",
  Text = "IP Address:",
  Position = {5, 5},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Right"
})
layout["IPAddress"] = {
  PrettyName = "IP Address",
  Style = "Text",
  Position = {100, 5},
  Size = {100, 16}
}
table.insert(graphics, {
  Type = "Text",
  Text = "Port:",
  Position = {5, 25},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Right"
})
layout["Port"] = {
  PrettyName = "Port",
  Style = "Text",
  Position = {100, 25},
  Size = {100, 16}
}
layout["Status"] = {
  PrettyName = "Connection Status", 
  Position = {100, 50}, 
  Size = {100, 20}
}

--------   Switcher Functions   --------

table.insert(graphics, {
  Type = "Text",
  Text = "Switcher Input",
  Position = {220, 5},
  Size = {100, 16},
  FontSize = 12
})
layout["SwitcherIn"] = {
  PrettyName = "Switcher In",
  Style = "Text",
  TextBoxStyle = "Normal",
  Position = {320, 5},
  Size = {75, 16}
}
table.insert(graphics, {
  Type = "Text",
  Text = "Switcher Output",
  Position = {220, 25},
  Size = {100, 16},
  FontSize = 12
})
layout["SwitcherOut"] = {
  PrettyName = "Switcher Out",
  Style = "Text",
  TextBoxStyle = "Normal",
  Position = {320, 25},
  Size = {75, 16}
}
layout["SwitcherGo"] = {
  PrettyName = "Take",
  Legend = "Take",
  Color = {0,255,0},
  FontSize = 12,
  Style = "Button",
  Position = {320, 45},
  Size = {75, 24}
} 
layout["AutoSwitch"] = {
  PrettyName = "ToggleAuto",
  Color = {255, 0, 0},
  Legend = "Auto",
  OffColor = {0, 0, 0},
  UnlinkOffColor = true,
  FontSize = 12,
  Style = "Toggle",
  ButtonVisualStyle = "Flat",
  Position = {400, 13},
  Size = {75, 24}
}

--------  Switch Matrix  ----------
    
for x = 1, 16 do
layout["in".. string.format("%d",x)] = {
  PrettyName = "n "..string.format("%d",x),
  Legend = ""..string.format("%d",x),
  Color = {0,255,127},
  FontSize = 12,
  Style = "Button",
  ButtonStyle = "Toggle",
  Position = {10 + 32 * x, 100},
  Size = {32, 32}
}
layout["out".. string.format("%d",x)] = {
  PrettyName = "o "..string.format("%d",x),
  Legend = ""..string.format("%d",x),
  Color = {178,34,34},
  FontSize = 12,
  Style = "Button",
  ButtonStyle = "Toggle",
  Position = {10 + 32 * x, 150},
  Size = {32, 32}
}
end







elseif CurrentPage == "Direct Routes" then

  table.insert(graphics,{
    Type="Image",
    Image=electrosoniclogo,
    Position={550,300},
    Size={175,40}
  })
  
  table.insert(graphics,{
    Type="Image",
    Image=extronlogo,
    Position={600,0},
    Size={50,70}
  })

  for a = 1, 9 do
    layout["dircrt "..a] = {
      Legend = "Direct Route "..a,
      Color = {0,255,0},
      FontSize = 10,
      Style = "Button",
      Position = {-80 + 75 * a , 100},
      Size = {75, 24}
    } 
    table.insert(graphics, {
      Type = "Text",
      Text = "IN",
      Position = {-70 + 75 * a , 140},
      Size = {40, 16},
      FontSize = 12
    })
    layout["dirin "..a] = {
      PrettyName = "dr "..a,
      Style = "Text",
      TextBoxStyle = "Normal",
      Position = {-60 + 75 * a , 170},
      Size = {40, 16}
    }
  end

    layout["dirouts"] = {
      PrettyName = "drouts",
      Style = "Text",
      TextBoxStyle = "Normal",
      Position = {250 , 220},
      Size = {100, 16}
    }








elseif CurrentPage == "I/O Names" then

  --------  Graphic Elements  -------
  
  table.insert(graphics,{
    Type="Image",
    Image=electrosoniclogo,
    Position={550,300},
    Size={175,40}
  })
  
  table.insert(graphics,{
    Type="Image",
    Image=extronlogo,
    Position={600,0},
    Size={50,70}
  })

table.insert(graphics, {
  Type = "Text",
  Text = "Input Names",
  Position = {250 , 60},
  Size = {200, 25},
  FontSize = 20
})
table.insert(graphics, {
  Type = "Text",
  Text = "Output Names",
  Position = {250 , 160},
  Size = {200, 25},
  FontSize = 20
})
      
for d = 1, 8 do
layout["inputname "..d] = {
  PrettyName = "In Name "..d,
  Style = "Text",
  TextBoxStyle = "Normal",
  FontSize = 12,
  Position = {-80 + 85 * d , 100},
  Size = {80, 16}
}  
layout["outputname "..d] = {
  PrettyName = "Out Name "..d,
  Style = "Text",
  TextBoxStyle = "Normal",
  FontSize = 12,
  Position = {-80 + 85 * d , 200},
  Size = {80, 16}
}
end  

for e = 9, 16 do
layout["inputname "..e] = {
  PrettyName = "In Name "..e,
  Style = "Text",
  TextBoxStyle = "Normal",
  FontSize = 12,
  Position = {-760 + 85 * e , 130},
  Size = {80, 16}
}  
layout["outputname "..e] = {
  PrettyName = "Out Name "..e,
  Style = "Text",
  TextBoxStyle = "Normal",
  FontSize = 12,
  Position = {-760 + 85 * e , 230},
  Size = {80, 16}
}
end

layout["btn1"] = {
  Legend = "btn1",
  Color = {0,255,0},
  FontSize = 10,
  Style = "Button",
  Position = {0 , 250},
  Size = {30, 15}
}
layout["btn2"] = {
  Legend = "btn2",
  Color = {0,255,0},
  FontSize = 10,
  Style = "Button",
  Position = {35 , 250},
  Size = {30, 15}
}
layout["btn3"] = {
  Legend = "btn3",
  Color = {0,255,0},
  FontSize = 10,
  Style = "Button",
  Position = {65 , 250},
  Size = {30, 15}
}
end