
-- Aliases
address = Controls.IPAddress
port = Controls.Port
SwitcherIn = Controls.SwitcherIn
SwitcherOut = Controls.SwitcherOut
SwitcherGo = Controls.SwitcherGo
AutoSwitch = Controls.AutoSwitch
dircrt = Controls.dircrt
dirin = Controls.dirin
dirouts = Controls.dirouts
innames = Controls.inputname
outnames = Controls.outputname

-- Timers
--PollTimer = Timer.New()  -- Timer for polling commands


----  Sockets   ---
sock = TcpSocket.New()
sock.ReadTimeout = 5
sock.WriteTimeout = 5
sock.ReconnectTimeout = 5

-- Constants
EOL = "\x3D"                       
EOLCharacter = TcpSocket.EOL.Lf  
Controls.AutoSwitch.Boolean = true
StringPushTimer = Timer.New()
PushTime = 0.5
--PollTime = 3

-- Debugging level
DebugTx,DebugRx,DebugFunction = false, false, false
DebugPrint = Properties["Debug Print"].Value
if DebugPrint == "Tx/Rx" then
  DebugTx, DebugRx = true, true
elseif DebugPrint == "Tx" then
  DebugTx = true
elseif DebugPrint == "Rx" then
  DebugRx = true
elseif DebugPrint == "Function Calls" then
  DebugFunction = true
elseif DebugPrint == "All" then
  DebugTx, DebugRx, DebugFunction = true, true, true
end


sock.EventHandler = function(sock, evt, err)
    if evt == TcpSocket.Events.Connected then
      print( "socket connected" )
    elseif evt == TcpSocket.Events.Reconnect then
      print( "socket reconnecting..." )
    elseif evt == TcpSocket.Events.Data then
      print( "socket has data" )
      message = sock:ReadLine(TcpSocket.EOL.Any)
      print('rx=',message)
      while (message ~= nil) do
        print( "reading until CrLf got "..message )
        message = sock:ReadLine(TcpSocket.EOL.Any)
        ParseAll(message)
      end
    elseif evt == TcpSocket.Events.Closed then
      print( "socket closed by remote" )
    elseif evt == TcpSocket.Events.Error then
      print( "socket closed due to error", err )
    elseif evt == TcpSocket.Events.Timeout then
      print( "socket closed due to timeout" )
    else
      print( "unknown socket event", evt ) --should never happen
    end
  end

  ----------   Parsing Functions   -------------

function ParseAll()
        print("msg=",message)
        --local fulllen = #msg
        print("fullen=",fulllen)
      local msglen = string.find(message, "\x20")
        print("len1=",msglen)
        outstr = string.sub(message, 1, 5)
        print("outstr"..outstr)
        out = string.sub(message, 4, 5)
        print("out"..outstr)
        output = tonumber(out)
        print(out)
        msglen = string.find(message, "IN")
        print("len2=",msglen)
        instr = string.sub(message, msglen + 2, fullen)
        print("instr"..instr)
        input = tonumber(instr)
        swndx[output] = input
      for a = 1, 16 do
        print(swindex.Index,swndx[a])
    end  
end  


swcmds = {}

--------  DO NOT CHANGE!!!!!!!  ----------------------------------          
                                                          --------
function send(cmd)                                        --------
  --if DebugFunction then print("send: ") end  --------
    table.insert(swcmds, cmd) 
  --if DebugFunction then print("#swcmds: ",#swcmds) end
    StringPushTimer:Start(PushTime)                       --------
  --if DebugFunction then print("startpushtimer") end
end                                                        --------
                                                           -------- 
function push(pushcmd)                                              --------
  --if DebugFunction then print("startpush") end                 ---------       
    sendcommand = table.remove(swcmds,getn)               -------- 
    tablelen = #swcmds 
    checklen()                                             --------
  --if DebugFunction then print("tablelen: ",tablelen) end --------
    tcpgo(sendcommand) 
  if DebugFunction then print("tcpgo") end
end                                                         --------    
                                                            --------    
function tcpgo(cmd) 
  if DebugFunction then print("tcpgo:cmd: ",cmd) end     
  --if DebugFunction then print("tablelen: ",tablelen) end     
     --print("sock:Write:",cmd..EOL) 
     sock:Write(cmd..EOL)
     print("wrote")
  --if DebugFunction then print("tablelen: ",tablelen) end
end     

function checklen()
  if tablelen <= 1 then                                   --------   
  StringPushTimer:Stop()
  --print("checklen:stop")
  end
end   
                                                            ---------       
-------  DO NOT CHANGE!!!!!!!  --------------------------------------


function ClearButtonStates()
        Timer.CallAfter (function()
      for loop = 1,16 do 
        Controls["in"..loop].Boolean = false
        Controls["out"..loop].Boolean = false
      end end, 1)
end

---------   Switcher Functions    ------------

swary    = {}
inieary  = {}
outieary = {}
idxlen   = 16

for idx,ctl in ipairs(Controls.inputname) do
  ctl.EventHandler = function() 
   inieary[idx] = Controls.inputname [idx].String 
  end
end 

for idx,ctl in ipairs(Controls.outputname) do
  ctl.EventHandler = function() 
   outieary[idx] = Controls.outputname [idx].String 
  end
end

function inittbls()
  for io = 1, 16 do
  inieary[io] = Controls.inputname [io].String
  outieary[io] = Controls.outputname [io].String
  end
end    

function btninputactive(btn)
  for x = 1, 16 do   
  Controls["in"..x].Boolean = false
  Controls["in"..btn].Boolean = true 
  swary[btn] = btn
  end    
end 

Controls.AutoSwitch.EventHandler = function()
    if Controls.AutoSwitch.Boolean == true then
       Controls.AutoSwitch.Legend = "Auto"
    else
       Controls.AutoSwitch.Legend = "Manual"
    end
end   

for insel = 1, 16 do
    Controls["in"..insel].EventHandler = function()
    SwitcherIn.String = insel
    swin = insel
    btninputactive(swin)
  end 
end


for outsel = 1, 16 do
Controls["out"..outsel].EventHandler = function()
    if Controls.AutoSwitch.Boolean == true then
      SwitcherOut.String = outsel
      swout = outsel
      sStr = string.format('SET OUT%s VS IN%s',SwitcherOut.String, SwitcherIn.String)
      print(sStr)
      ClearButtonStates()
      send(sStr)
    else
      SwitcherOut.String = sel
    end
  end
end

SwitcherGo.EventHandler = function()
  sStr = string.format('SET OUT%s VS IN%s',SwitcherOut.String,SwitcherIn.String)
  ClearButtonStates()
  send(sStr)
end


--------------  Direct Routes   ---------------------------------

drstr = dirouts.String
diroutary = {}
dirvalues = {}

for value in drstr:gmatch("[^,]+") do
    table.insert(dirvalues, value)
end

function initouts()
     for i = 1, #drstr do
      -- Convert the character to a number and insert into the table
      diroutary[i] = tonumber(drstr:sub(i, i))
  end
end


--Controls.dircrt[1].EventHandler = function ()
for idx,ctl in ipairs(Controls.dircrt) do
  ctl.EventHandler = function()
  for swt = #dirvalues, 1, -1 do  
  --for swt = 1, #dirvalues do
    sndstr = "SET OUT"..string.format(dirvalues[swt]).." VS IN"..dirin[idx].String
    send(sndstr)
    end
  end 
end   

-------------------------- test  ---------------------------------

Controls.btn1.EventHandler = function()

end      

Controls.btn2.EventHandler = function()

end 

---------------------  Initialization  -------------------------

StringPushTimer.EventHandler = push

inittbls()
initouts()


sock:Connect(address.String, port.Value)