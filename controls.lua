
table.insert(ctrls, {
  Name = "Status",
  ControlType = "Indicator",
  IndicatorType = "Status",
  Count = 1
})
table.insert(ctrls, {
  Name = "IPAddress",
  ControlType = "Text",
  DefaultValue = "192.168.232.12",
  Count = 1
})
table.insert(ctrls, {
  Name = "Port",
  ControlType = "Knob",
  ControlUnit = "Integer",
  Min = 1,
  Max = 65535,
  DefaultValue = 23,
  Count = 1
})
table.insert(ctrls, {
  Name = "SwitcherIn",
  ControlType = "Text",
  DefaultValue = "1",
  UserPin = true,
  PinStyle = "Input",
  Count = 1
})
table.insert(ctrls, {
  Name = "SwitcherOut",
  ControlType = "Text",
  DefaultValue = "1",
  UserPin = true,
  PinStyle = "Input",
  Count = 1
})
table.insert(ctrls, {
  Name = "SwitcherGo",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})
table.insert(ctrls, {
  Name = "AutoSwitch",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

--------  Switch Matrix  ----------

for x = 1, 16 do
table.insert(ctrls, {
  Name = "in" .. string.format("%d",x),
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
})
table.insert(ctrls, {
  Name = "out" .. string.format("%d",x),
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
})
end

--------   Direct Routes  -------

for a = 1, 9 do
table.insert(ctrls, {
  Name = "dircrt",
  ControlType = "Button",
  ButtonType = "Trigger",
  UserPin = true,
  PinStyle = "Input",
  Count = 9
})

table.insert(ctrls, {
  Name = "dirin",
  ControlType = "Text",
  DefaultValue = "1",
  Count = 9
})

table.insert(ctrls, {
  Name = "dirouts",
  ControlType = "Text",
  DefaultValue = "1,3,6,12,14",
  Count = 1
})
end

---------  I/O Names -------------

for d = 1, 16 do
table.insert(ctrls, {
  Name = "inputname",
  ControlType = "Text",
  DefaultValue = "In Name",
  Count = 16
})
table.insert(ctrls, {
  Name = "outputname",
  ControlType = "Text",
  DefaultValue = "Out Name",
  Count = 16
})
end

-------------  test  -------------

table.insert(ctrls, {
  Name = "btn1",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
})
table.insert(ctrls, {
  Name = "btn2",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
})
table.insert(ctrls, {
  Name = "btn3",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
})
