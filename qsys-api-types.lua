-- *********************************************************
--                    010-Controls-IO.lua
-- *********************************************************
---@class Control
---@field public Value number Floating point value of control.
---@field public Values number[] Table of floating point values of controls. Only used when connected to controls that create tables of values such as the 2D panner, RTA - Band-Pass or Responsalyzer, Meters.
---@field public Position number floating point position which goes from 0.0 -> 1.0
---@field public String string string representation of control value
---@field public Boolean boolean returns true if the position of the control is >0.5
---@field public RampTime number defaults to 0 seconds
---@field public Index number index of control.
---@field public Type string 'Boolean' | 'Float' | 'Virtual'
---@field public Direction string 'Read Only' | 'Read/Write' | 'Other'
---@field public MinValue number
---@field public MaxValue number
---@field public MinString string
---@field public MaxString string
---@field public Legend string string representing the Legend of a button or a fader.
---@field public IsInvisible boolean false = visible, true = hidden
---@field public IsDisabled boolean false = enabled, true = disabled
---@field public IsIndeterminate boolean false = value is valid, true = value is not valid
---@field public Color string String which can be translated to a color. ("#RGB", "#RRGGBB", "!HHSSVV" or any valid CSS Color Name)
---@field public Choices string[] List of choices for a control
local Control = {}

---Triggers the output
---@return void
function Control:Trigger() end

---callback for when input value changes
---@vararg any
---@return void
function Control:EventHandler(...) end

---@type table<string, Control>
Controls = {}

---@type Control[]
Controls.Inputs = {}

---@type Control[]
Controls.Outputs = {}

-- ************************************************************
--                     020-ChannelGroup.lua
-- ************************************************************
---Used when a Control Script is located inside a Channel Group.  The .Index property is used to determine which Channel Group is currently selected
---@field public Index number value, 1-n, indicates which channel of the Channel Group, 0 indicated not in Channel Group.  If multiple groups are selected, the index of the first group is returned.
ChannelGroup = {}

-- ******************************************
--               030-Crypto.lua
-- ******************************************
--- Use the Crypto commands to encode and decode ASCII text strings to and from Base64, as well as obtain CRC16, HMAC, and MD5 values for specified strings.
Crypto = {}

---Compute the Base64 of a specified string.
---@overload fun(value: string):string
---@param value string The value to encode to Base64
---@param pad boolean If true, output is padded with '=' signs. The default is true.
---@return string The Base64 encoded value
function Crypto.Base64Encode(value, pad)
end

---Convert the Base64 of a specified value to a string.
---@param value string A Base64 encoded string
---@return string The value, decoded from Base64
function Crypto.Base64Decode(value)
end

---Compute the CRC16 of a specified value.
---@param value string The value to compute the CRC16 for
---@return string The CRC16 bytes
function Crypto.CRC16Compute(value)
end

---Compute the message authentication code of specified data using a specified hashing algorithm and key.
---@param algorithm string Allowed values: md5 | sha1 | sha256 | sha512
---@param key string The secret key to use for computing the message authentication code
---@param data string The data for which to compute the message authentication code
---@return string The computed authentication code
function Crypto.HMAC(algorithm, key, data)
end

---Compute the MD5 hash of a specified value.
---@param value string The value for which to compute the MD5 hash.
---@return string The computed MD5 hash
function Crypto.HMAC(value)
end

-- ******************************************
--               040-Design.lua
-- ******************************************
---@class DesignStatus A status table containing design information
---@field public DesignName string The name of the design file.
---@field public Platform string "Emulator" or The model of the running core.
---@field public IsRedundant boolean
---@field public DesignCode string A unique code assigned to the design.
local DesignStatus = {}

---@class InventoryItemStatus A status table for a specific inventory item
---@field public Message string The text status of the inventory item.
---@field public Code string The numeric status of the inventory item.
local InventoryItemStatus = {}

---@class DesignInventoryItem
---@field public Type string The category of the inventory item.
---@field public Name string The name of the inventory item.
---@field public Location string The location of the inventory item, as specified in the design file.
---@field public Model string The model of the inventory item.
---@field public Status InventoryItemStatus The status of the inventory item.
local DesignInventoryItem = {}

---Use the Design functions to return design status and inventory information.
Design = {}

---@return DesignStatus
function Design.GetStatus() end

---@return DesignInventoryItem[]
function Design.GetInventory() end

-- *********************************************************************
--                        050-dir (Directory).lua
-- *********************************************************************
---Use the directory commands to list folders and files, create folders, and delete folders within the media/ or design/ locations on the file system. For security and stability reasons, these are the only locations accessible by the Lua libraries.
---
---The media/ folder is the location for all media files, while the design/ folder is the location where uncompressed design configuration files reside while a design is being emulated or running on a Q-SYS Core processor. (It is not intended for storage of user-created design files, and is not remotely accessible.)
dir = {}

---List directories and files in a media/ or design/ path
---@param path string Must begin with 'media/' or 'design/'
---@return string[] A list of directories and files.
function dir.get(path) end

---Create a new folder within a media/ or design/ path
---@param path string Must begin with 'media/' or 'design/'
function dir.create(path) end

---Remove an empty folder within a media/ or design/ path.
---
---If the folder you intend to delete contains files, you must remove them first using `os.remove()`.
---@param path string Must begin with 'media/' or 'design/'. Must be an empty folder.
function dir.remove(path) end

-- ***************************************
--              060-Email.lua
-- ***************************************
---@alias EmailSendHandler fun(table: EmailSendParameters, error: string)

---@class EmailSendParameters A table containing the details of the email to be sent.
---@field public From string
---@field public Subject string
---@field public Body string
---@field public To string[]
---@field public CC string[]
---@field public Server string
---@field public Password string
---@field public UseSsl string
---@field public EventHandler fun(table: EmailSendParameters, error: string)
local EmailParameters = {}

---@param params EmailSendParameters
function Email.Send(params) end

-- ******************************************************
--                   070-HttpClient.lua
-- ******************************************************
---@class HttpDownloadParams
---@field public Url string The URL to download from
---@field public Headers table<string, string> A table of headers
---@field public User string Username for authenticated sites
---@field public Password string Password for authenticated sites
---@field public Timeout number The timeout, in seconds, for the HttpClient call
---@field public EventHandler fun(params: HttpDownloadParams, code: number, data: string, error: string, headers: table<string, string>)
local HttpDownloadParams = {}

---@class HttpUploadParams: HttpDownloadParams
---@field Data string data to upload
---@field Method string 'POST' | 'PUT'
---@field public EventHandler fun(params: HttpUploadParams, code: number, data: string, error: string, headers: table<string, string>)
local HttpUploadParams = {}

---@class HttpCreateUrlParams
---@field public Host string
---@field public Port number
---@field public Path string
---@field public Query string
local UrlParams = {}

--- Http related utilities
HttpClient = {}

---@param params HttpDownloadParams
function HttpClient.Download(params) end

---@param params HttpUploadParams
function HttpClient.Upload(params) end

---@param params HttpCreateUrlParams
function HttpClient.CreateUrl(params) end

---@param params table<string, string>
---@return string
function HttpClient.EncodeParams(params) end

---@param str string
---@return string
function HttpClient.EncodeString(str) end

---@param str string
---@return string
function HttpClient.DecodeString(str) end

-- ************************************
--             080-JSON.lua
-- ************************************
json = {}

---Encodes the Lua object into a JSON string
---@param lua_obj any
---@return string
function json.encode(lua_obj) end

---Decodes the JSON string, and returns a Lua object.
---@param json_string string
---@return any
function json.decode(json_string) end

---A unique value that will be encoded as a `null` in the JSON encoding.
---@return fun()
function json.null() end

-- *********************************
--            090-Log.lua
-- *********************************
---The Log object is used to write messages to the Core's system log file.
Log = {}

---@param message string
function Log.Message(message) end

---@param error_description string
function Log.Error(error_description) end

-- ***************************************
--              100-Mixer.lua
-- ***************************************
---Mixer objects allow access to Mixer components that have been named in the design. To create a mixer object, call Mixer.New( mixerName ). The mixer object uses a string specification to determine which inputs and outputs to apply changes to. The syntax supports either space or comma separated numbers, ranges of numbers or all (*). It supports negation of selection with the '!' operator.
---
---Example In/Out Descriptions
---  * `"*"` All channels
---  * `"1 2 3"` channels 1, 2, and 3
---  * `"1-6"` channels 1 through 6
---  * `"1-6 9"` ch 1-6 and ch 9
---  * `"1-3 5-9"` ch 1-3 & 5-9
---  * `"1-8 !3"` ch 1-8, except 3
---  * `"* !3-5"` everything but 3-5
---@class Mixer
Mixer = {}

---Create a new Mixer instance to control a named mixer in the design.
---@param componentName string The named mixer component
---@return Mixer
function Mixer.New(componentName) end

---@overload fun(ins:string, outs:string, gain: number)
---@param ins string
---@param outs string
---@param gain number
---@param ramp number
function Mixer.SetCrossPointGain(ins, outs, gain, ramp) end

---@param ins string
---@param outs string
---@param mute boolean
function Mixer.SetCrossPointMute(ins, outs, mute) end

---@param ins string
---@param outs string
---@param solo boolean
function Mixer.SetCrossPointSolo(ins, outs, solo) end

---@overload fun(ins:string, outs:string, delay: number)
---@param ins string
---@param outs string
---@param delay number
---@param ramp number
function Mixer.SetCrossPointDelay(ins, outs, delay, ramp) end

---@overload fun(ins:string, gain: number)
---@param ins string
---@param gain number
---@param ramp number
function Mixer.SetInputGain(ins, gain, ramp) end

---@param ins string
---@param mute boolean
function Mixer.SetInputMute(ins, mute) end

---@param ins string
---@param solo boolean
function Mixer.SetInputSolo(ins, solo) end

---@overload fun(outs:string, gain: number)
---@param outs string
---@param gain number
---@param ramp number
function Mixer.SetOutputGain(outs, gain, ramp) end

---@param outs string
---@param mute boolean
function Mixer.SetOutputMute(outs, mute) end

---@param ins string
---@param cues string
---@param enable boolean
function Mixer.SetInputCueEnable(ins, cues, enable) end

---@param ins string
---@param afls string
---@param enable boolean
function Mixer.SetInputCueAfl(ins, afls, enable) end

---@overload fun(cues:string, gain: number)
---@param cues string
---@param gain number
---@param ramp number
function Mixer.SetCueGain(cues, gain, ramp) end

---@param cues string
---@param mute boolean
function Mixer.SetCueMute(cues, mute) end

---@class MixerCrossPoint
---@field Input number
---@field Output number
---@field Gain number
---@field Mute boolean
---@field Delay number
---@field Solo boolean
local MixerCrossPoint = {}

---@param ins string
---@param outs string
---@return MixerCrossPoint[]
function Mixer:GetMixerCrossPoints(ins, outs) end

-- ************************************************************
--                     110-NamedControl.lua
-- ************************************************************
---The methods in NamedControl are used to read or set the values of Named Controls.
---
---Create Named Controls by dragging specific controls (knobs, buttons, faders, etc) to
--- the `Named Controls` tab on the left of the design window.
NamedControl = {}

---Get the string value of a named control.
---@param control_name string The custom name given to the control in the design.
---@param string string The string value to set on the control.
function NamedControl.SetString(control_name, string) end

---Set the string value of a named control.
---@param control_name string The custom name given to the control in the design.
---@return string The string value of the control.
function NamedControl.GetString(control_name) end

---Set the position of a named control.
---@overload fun(control_name: string, position: number)
---@param control_name string The custom name given to the control in the design.
---@param position number The position value to set on the control.
---@param ramp_time number Optional time (in seconds) to ramp the change.
function NamedControl.SetPosition(control_name, position, ramp_time) end

---Get the position of a named control
---@param control_name string The custom name given to the control in the design.
---@return number The Position of the named control as a number between 0.0 and 1.0
function NamedControl.GetPosition(control_name) end

---Set the value of a named control.
---@overload fun(control_name: string, position: number)
---@param control_name string The custom name given to the control in the design.
---@param value number The position value to set on the control.
---@param ramp_time number Optional. Time (in seconds) to ramp the change.
function NamedControl.SetValue(control_name, value, ramp_time) end

---Get the value of a named control
---@param control_name string The custom name given to the control in the design.
---@return number The numeric value of the named control as a number.
function NamedControl.GetValue(control_name) end

---Triggers a named control
---@param control_name string The custom name given to the control in the design.
---@return number The numeric value of the named control as a number.
function NamedControl.Trigger(control_name) end

-- ***************************************************
--                  120-Component.lua
-- ***************************************************
---@see Control Similar to regular Control. Has an extra Name field.
---@class ControlWithName: Control
---@field public Name string
local ControlWithName = {}

---Component objects allow access to Named Components in the design. Create a Named Component by typing a unique, non-default name in any component block
Component = {}

---Create a Named Component reference in your script
---@param component_name string The name of the component in your design
---@return table<string, Control>
function Component.New(component_name) end

---Create a Named Component reference in your script
---@param component_name string The name of the component in your design
---@return ControlWithName[]
function Component.GetControls(component_name) end

-- *********************************************
--                130-Network.lua
-- *********************************************
---Use the Network commands to return the full host name and IP address of a specified host, or obtain a table of network interface names and their IP addresses.
Network = {}

---Find the name and addresses of a specified host.
---@param host string
---@return {name: string, addresses: string[]}
function Network.GetHostByName(host) end

---@class InterfaceInfo
---@field public Interface string The interface name (i.e. 'LAN A')
---@field public Address string The IPv4 network address of the interface
---@field public MAC string The MAC address of the interface
---@field public Gateway string The default gateway set on the interface
---@field public Netmask string The network mask set on the interface
local InterfaceInfo = {}

---Inspect the network interfaces available on the running design.
---@return InterfaceInfo[]
function Network.Interfaces() end

-- ***************************************************************
--                      140-Notifications.lua
-- ***************************************************************
--- Message pub/sub that works across the design
Notifications = {}

---Subscribe to a channel with a given name.
---@param name string The name of the channel to subscribe to.
---@param listener fun(name: string, data: any)
---@return number The noteId that identifies that particular subscription.
function Notifications.Subscribe(name, listener) end

---Publish a notification to all listeners.
---@param name string The name of the channel to notify.
---@param data any The data to publish.
function Notifications.Publish(name, data) end

---Unsubscribe a particular listener
---@param noteId number The noteId provided as a return value from `.Subscribe(...)`
function Notifications.Unsubscribe(noteId) end

-- ************************************
--             150-Ping.lua
-- ************************************
---**Note:** The Lua Ping library requires that you run Q-SYS Designer as administrator ("Run as administrator" option in Windows) when emulating your design. If you see a non-terminating "Socket failed to open" error message in the debug window, re-launch Designer as administrator.
---@class Ping
Ping = {}

---Create a new ping instance
---@param target_host string
---@return Ping
function Ping.New(target_host) end

---Begin the ping session
---@overload fun()
---@param single_shot boolean If `true` only a single ping attempt will be made.
function Ping:start(single_shot) end

---Stop the ping session
function Ping:stop() end

---Set the timeout for waiting for a ping response.
---@param timeout number The timeout duration, in seconds.
function Ping:setTimeoutInterval(timeout) end

---Set the interval for retrying after a ping request.
---@param interval number The interval, in seconds.
function Ping:setPingInterval(interval) end

---Assign a callback for successful ping events.
---@param response {HostName:string, ElapsedTime: number} The host and elapsed time in microseconds
function Ping.EventHandler(response) end

---Assign a callback for unsuccessful ping events.
---@param response {HostName:string, Error: number} The host and errormessage of the ping
function Ping.ErrorHandler(response) end

-- ***************************************************
--                  160-RapidJSON.lua
-- ***************************************************
---Use the RapidJSON module to encode and decode large documents quickly. It is similar to the standard JSON module, but can handle large amounts of data without risk of raising execution count errors.
---To use the RapidJSON module, add the following line to your script:
---```lua
---   rapidjson = require("rapidjson")
---```
---Note that you can assign any local variable name to the `require("rapidjson")` object
---@class RapidJSON
---@module rapidjson
rapidjson = {}

---@class RapidJsonEncodeOptions
---@field public pretty boolean Set `true` to make output string to be pretty formatted. Default is `false`.
---@field public sort_keys boolean Set `true` to make JSON object keys be sorted. Default is `false`.
---@field public empty_table_as_array boolean Set `true` to make empty table encode as JSON array. Default is `false`.
local RapidJsonEncodeOptions = {}

---When passed as a table:
---
---    1. It is encoded as JSON array if:
---         * meta field `__jsontype` set to `"array"`.
---         * table contains length > 0.
---    2. otherwise the table is encoded as JSON object and non string keys and its values are ignored.
---
---When passed a string, `true`, `false`, `number` and `rapidjson.null` it encodes as a simple JSON value.
---@overload fun(value: any): string
---@param value any
---@param options RapidJsonEncodeOptions
---@return string JSON encoded string
function rapidjson.encode(value, options) end

---Decode JSON to a Lua table
---@param json_string string A JSON encoded string
---@return any The decoded object. If `null` is declared anywhere in the JSON, it will be encoded as `rapidjson.null`
function rapidjson.decode(json_string) end

---Load JSON file into Lua table
---@param filename string The JSON file to be loaded
---@return any, string The decoded object, and an error object
function rapidjson.load(filename) end

---Dump a Lua value to a JSON file
---@overload fun(value: any, filename: string): any, string
---@param value any
---@param filename string Where to save the JSON output (must be subfolder of `media/` or `design/`).
---@param options RapidJsonEncodeOptions
---@return any, string Success value, and an error object
function rapidjson.dump(value, filename, options) end

---The placeholder value for `null` in rapidjson
---@return fun()
function rapidjson.null() end

---Create a new empty table that has the metatable field `__jsontype` set as `'object'`, which forces it to encode as a JSON object
---@overload fun():table<string, any>
---@param object table<string, any>
---@return table<string, any>
function rapidjson.object(object) end

---Create a new empty table that has the metatable field `__jsontype` set as `'array'`, which forces it to encode as a JSON array.
---@overload fun():any[]
---@param array any[]
---@return any[]
function rapidjson.array(array) end

return rapidjson;

-- *********************************************************
--                    170-SerialPorts.lua
-- *********************************************************
---@alias SerialPortEvent string A value from the SerialPorts.Events table
---@alias SerialPortEOL number 0 | 1 | 2 | 3 | 4 | 5
---@alias SerialPortCB fun(self:SerialPort)
---@alias SerialPortDataCB fun(self:SerialPort, data: string)
---@alias SerialPortErrorCB fun(self:SerialPort, error: string)

---@class SerialPort
---@field public IsOpen boolean `true` if port is connected
---@field public BufferLength number number of bytes of data in buffer
---@field public EventHandler fun(self: SerialPort, event:SerialPortEvent) Called on any serial event
---@field public Connected SerialPortCB Called when the serial port connects
---@field public Reconnect SerialPortCB Called when the serial port attempts to reconnect
---@field public Data SerialPortDataCB Called when there is new data available on the serial port
---@field public Closed SerialPortCB Called when the serial port is closed
---@field public Error SerialPortErrorCB
---@field public Timeout SerialPortErrorCB
local SerialPort = {}

---Attempts to open the serial port with the specified baud rate
---@overload fun(baudRate: number, dataBits: number)
---@overload fun(baudRate:number)
---@param baudRate number The desired baudrate. Up to 230400 bits per second
---@param dataBits number Can be 7 or 8. Default is 8
---@param parity string N(None), E(Even), O(Odd), M(Mark), S(Space)
function SerialPort:Open(baudRate, dataBits, parity) end

---Closes the serial port
function SerialPort:Close() end

---Writes the specified data to the serial port
---@param data string
function SerialPort:Write(data) end

---Attempts to read up the 'length' bytes from serial buffer. Data is removed from serial buffer.
---@param length number
---@return string
function SerialPort:Read(length) end

---Attempts to read up the 'length' bytes from serial buffer. Data is removed from serial buffer.
---@overload fun(EOL:SerialPortEOL)
---@param EOL SerialPortEOL
---@param custom string Custom end of line characters. Only for use with SerialPorts.EOL.Custom
---@return string
function SerialPort:ReadLine(EOL, custom) end

---Searches the serial buffer for string 'str' (starting at 'start_pos') and returns the index of where str is found.
---@overload fun(string: string)
---@param string string The string to search for
---@param start_pos number The index to start searching from. Defaults to 1
---@return number
function SerialPort:Search(string, start_pos) end

---@type SerialPort[]
SerialPorts = {}

---@class SerialPortsEventsTable
---@field public Connected SerialPortEvent Called when the serial port connects
---@field public Reconnect SerialPortEvent Called when the serial port attempts to reconnect
---@field public Data SerialPortEvent Called when there is new data available on the serial port
---@field public Closed SerialPortEvent Called when the serial port is closed
---@field public Error SerialPortEvent Called when socket is closed due to an error
---@field public Timeout SerialPortEvent A read or write timeout was triggered and the port was closed.
SerialPorts.Events = {}

---@class SerialPortsEOLTable
---@field public Any SerialPortEOL
---@field public CrLf SerialPortEOL
---@field public CrLfStrict SerialPortEOL
---@field public Lf SerialPortEOL
---@field public Null SerialPortEOL
---@field public Custom SerialPortEOL
SerialPorts.EOL = {}

-- ***************************************************************************
--                          180-SerialServerPorts.lua
-- ***************************************************************************
---@class SerialServerPort: SerialPort
---@field OnOpen fun(baudRate: number, dataBits: number, parity: string) Called when the wrapped serial port calls it's :Open method. parity: N(None), E(Even), O(Odd), M(Mark), S(Space)
---@field OnClose fun() Called when a :Close request from the attached serial client script is received.
---@field Data fun() Assign a function which is called when there is new data in the virtual serial port buffer.
local SerialServerPort = {}

---Trigger an EventHandler in the associated serial “client script’s” serial EventHandler logic
---@overload fun(SerialEvent:SerialPortEvent)
---@param SerialEvent SerialPortEvent One of the events referenced in the SerialPorts.Events table
---@param error string When using the Error event type, an optional explanation of the error condition
function SerialServerPort:Event(SerialEvent, error) end

---Writes specified data to the client's serial port buffer. Raises an error if the port is not open
---@param Data SerialPortEvent One of the events referenced in the SerialPorts.Events table
function SerialServerPort:Write(Data) end

---Attempts to read up the 'length' bytes from the serial buffer. Data is removed from the buffer. This buffer
---contains data bytes written by the serial client script.
---@param length number The number of bytes to read from the serial buffer.
---@return string The data read from the socket. Nil if the buffer is empty.
function SerialServerPort:Read(length) end

---Attempts to read a 'line' from the serial buffer. 'EOL' is defined in the table below. '<custom>' is an optional
---string used by EOL.Custom.
---
---    **NOTE:** Note: This method is typically never used to get data bytes from the virtual
---    serial buffer to be completely transparent between the serial client script and the remote serial port. Normally,
---    every byte received from the vitual serial port is read from the buffer by the :Read method using the .BufferLength
---    property and immediately sent to the TcpSocket connection using the :Write command. Likewise, on the TcpSocket's
---    DATA EventHandler, the :Read method would also immediate remove all bytes from the TcpSocket buffer and :Write them,
---    as a whole, to the virtual serial port.
---@param EOL SerialPortEOL
---@param custom string
---@return string The data rad from the socket. Nil if the read failed.
function SerialServerPort:ReadLine(EOL, custom) end

---Searches the serial buffer for string 'str' (starting at 'start_pos') and returns the index of where str is found.
---
---    Note: This method should rarely be used for the intended purpose of the SerialServerPorts library.
---    It is documented here for completeness.
---@overload fun(string: string)
---@param string string The string to search for
---@param start_pos number The index to start searching from. Defaults to 1. Nil if not found
---@return number
function SerialServerPort:Search(string, start_pos) end

---@type SerialServerPort[]
SerialServerPorts = {}

-- ************************************
--             190-SNMP.lua
-- ************************************
---@class SNMPSessionType
local SNMPSessionType = {}

---@class SNMPAuthType
local SNMPAuthType = {}

---@class SNMPAuthProtocol
local SNMPAuthProtocol = {}

---@class SNMPPrivProtocol
local SNMPPrivProtocol = {}

---@class SNMPDataType
local SNMPDataType = {}

---@class OIDResponse
---@field public RequestID number
---@field public OID string
---@field public Value string
---@field public HostName string
local OIDResponse = {}

---@class SNMPError
---@field public Error string
local SNMPError = {}

---Use the SNMP library in Lua to monitor OIDs obtained from an SNMP-enabled device's MIB file.
---    Note: In the SNMP model, Q-SYS acts as the SNMP Manager, while the device you intend to monitor runs an SNMP Agent that allows for monitoring.
---@class SNMP TODO
---@field public SessionType {V2c: SNMPSessionType, V3: SNMPSessionType}
---@field public AuthType {NoAuth: SNMPAuthType, AuthNoPriv: SNMPAuthType, AuthPriv: SNMPAuthType}
---@field public AuthProtocol {NoAuth: SNMPAuthProtocol, MD5: SNMPAuthProtocol, SHA: SNMPAuthProtocol}
---@field public PrivProtocol {NoPriv: SNMPPrivProtocol, AES: SNMPPrivProtocol, DES: SNMPPrivProtocol}
---@field public SNMPDataType {unknown:SNMPDataType, integer32:SNMPDataType, unsigned32:SNMPDataType, unsigned_integer32:SNMPDataType, timeticks:SNMPDataType, ip_address:SNMPDataType, object_id:SNMPDataType, octet_string:SNMPDataType, hex:SNMPDataType, decimal:SNMPDataType, bit_string:SNMPDataType, integer64:SNMPDataType, unsigned64:SNMPDataType, float32:SNMPDataType, double64:SNMPDataType}
---@field public EventHandler fun(OIDResponse)
---@field public ErrorHandler fun(SNMPError)
SNMP= {}

---@class SNMPSession
SNMPSession = {}

---Create a new SNMP session
---@param type SNMPSessionType
---@return SNMPSession
function SNMPSession.New(type) end

---@param hostname string
function SNMPSession:setHostName(hostname) end

---@param type SNMPAuthType
function SNMPSession:setAuthType(type) end

---@param type SNMPAuthProtocol
function SNMPSession:setAuthProt(type) end

---@param type SNMPPrivProtocol
function SNMPSession:setPrivProt(type) end

---@param username string
function SNMPSession:setUserName(username) end

---@param passphrase string
function SNMPSession:setPassPhrase(passphrase) end

---@param passphrase string
function SNMPSession:setPrivPassPhrase(passphrase) end

---@param community string
function SNMPSession:setCommunity(community) end

function SNMPSession:startSession() end

---@param oid string
---@param callback fun(data)
function SNMPSession:getRequest(oid, callback) end

---@param oid string
---@param newValue string
---@param type SNMPDataType
---@param callback fun(data)
function SNMPSession:setRequest(oid, newValue, type, callback) end

-- ************************************************
--                 200-SNMPTrap.lua
-- ************************************************
---@class SNMPTrap
---@field public EventHandler fun(OIDResponse)
---@field public ErrorHandler fun(SNMPError)
SNMPTrap = {}

---@param trapName string
function SNMPTrap.New(trapName) end

function SNMPTrap:startSession() end

-- *********************************
--            210-Ssh.lua
-- *********************************
---@alias SshEvent SerialPortEvent
---@alias SshEOL SerialPortEOL
---@alias SshCB fun(self:Ssh)
---@alias SshDataCB fun(self:Ssh, data: string)
---@alias SshErrorCB fun(self:Ssh, error: string)

---@class Ssh
---@field public LoginFailed SshCB Called upon a failed login
---@field public Connected SshCB Called when the Ssh socket connects
---@field public Reconnect SshCB Called when the Ssh socket attempts to reconnect
---@field public Data SshDataCB Called when there is new data available on the socket
---@field public Closed SshCB Called when the Ssh is closed
---@field public Error SshErrorCB
---@field public Timeout SshErrorCB
---@field public ReadTimeout number Time, in seconds, to wait for data to be available on socket before raising an Error through the EventHandler. Default is 0 (disabled)
---@field public WriteTimeout number Time, in seconds, to wait for data write to complete before raising an Error through the EventHandler. Default is 0 (disabled)
---@field public ReconnectTimeout number Time in seconds to wait before attempting to reconnect. 5 seconds is default. 0 disables automatic reconnect.
---@field public IsConnected boolean Read-Only. `true` if socket is connected.
---@field public BufferLength boolean Read-Only. Amount of data in buffer, in bytes
Ssh = {}

---Creates a new Ssh instance.
---@return Ssh
function Ssh:New() end

---Attempts to connect to the specified ip/host name and port, with the specified credentials
---@param host string ip/host
---@param port number
---@param user string
---@param password string
function Ssh:Connect(host, port, user, password) end

---Disconnects.
function Ssh:Disconnect() end

---Writes specified data to the socket. Raises error if socket is not connected.
---@param data string
function Ssh:Write(data) end

---Attempts to read up to 'length' bytes from socket. These bytes are removed from the buffer, leaving any remaining bytes beyond the 'length' specified. 'length' is positive integer.
---@param length number
function Ssh:Read(length) end

---Attempts to read a 'line' from the socket buffer. 'EOL' is defined in the table below. '<custom>' is an optional string only used by EOL.Custom.
---@param EOL SshEOL
---@param custom string
function Ssh:ReadLine(EOL, custom) end

---@class SshEventsTable
---@field public Connected SshEvent Called when the serial port connects
---@field public Reconnect SshEvent Called when the serial port attempts to reconnect
---@field public Data SshEvent Called when there is new data available on the serial port
---@field public Closed SshEvent Called when the serial port is closed
---@field public Error SshEvent Called when socket is closed due to an error
---@field public Timeout SshEvent A read or write timeout was triggered and the port was closed.
Ssh.Events = {}

---@class SshEOLTable
---@field public Any SshEOL
---@field public CrLf SshEOL
---@field public CrLfStrict SshEOL
---@field public Lf SshEOL
---@field public Null SshEOL
---@field public Custom SshEOL
Ssh.EOL = {}

-- ******************************************
--               220-System.lua
-- ******************************************
---@class System
---@field BuildVersion number The least significant number of the version triplet. (The `1` in `8.3.1`)
---@field MinorVersion number The middle significant number of the version triplet. (The `3` in `8.3.1`)
---@field MajorVersion number The most significant number of the version triplet. (The `8` in `8.3.`)
---@field LockingId string The Q-SYS Core's Locking ID, which is used for Q-SYS feature license activation.
---@field System.IsEmulating boolean Indicates whether the design is running in an emulator or on a Core.
---@field System.Version string The entire version triplet string (i.e. All of `8.3.1`)
System={}

-- ***************************************************
--                  230-TcpSocket.lua
-- ***************************************************
---@alias SocketEvent SerialPortEvent
---@alias SocketEOL SerialPortEOL
---@alias SocketCB fun(self:TcpSocket)
---@alias SocketDataCB fun(self:TcpSocket, data: string)
---@alias SocketErrorCB fun(self:TcpSocket, error: string)

---@class TcpSocket
---@field public EventHandler fun(socket: TcpSocket, event: SocketEvent, err: string | nil)
---@field public Connected SocketCB Called when the TcpSocket connects
---@field public Reconnect SocketCB Called when the TcpSocket attempts to reconnect
---@field public Data SocketDataCB Called when there is new data available on the TcpSocket
---@field public Closed SocketCB Called when the TcpSocket is closed
---@field public Error SocketErrorCB
---@field public Timeout SocketErrorCB
---@field public ReadTimeout number Time, in seconds, to wait for data to be available on socket before raising an Error through the EventHandler. Default is 0 (disabled)
---@field public WriteTimeout number Time, in seconds, to wait for data write to complete before raising an Error through the EventHandler. Default is 0 (disabled)
---@field public ReconnectTimeout number Time in seconds to wait before attempting to reconnect. 5 seconds is default. 0 disables automatic reconnect.
---@field public IsConnected boolean Read-Only. `true` if socket is connected.
---@field public BufferLength boolean Read-Only. Amount of data in buffer, in bytes
TcpSocket = {}

---Creates a new TcpSocket instance.
---@return TcpSocket
function TcpSocket:New() end

---Attempts to connect to the specified ip/host name and port
---@param host string ip/host
---@param port number
function TcpSocket:Connect(host, port) end

---Disconnects the socket.
function TcpSocket:Disconnect() end

---Writes specified data to the socket. Raises error if socket is not connected.
---@param data string
function TcpSocket:Write(data) end

---Attempts to read up to 'length' bytes from socket. These bytes are removed from the buffer, leaving any remaining bytes beyond the 'length' specified. 'length' is positive integer.
---@param length number
function TcpSocket:Read(length) end

---Attempts to read a 'line' from the socket buffer. 'EOL' is defined in the table below. '<custom>' is an optional string only used by EOL.Custom.
---@param EOL SocketEOL
---@param custom string
function TcpSocket:ReadLine(EOL, custom) end

---@class SocketEventsTable
---@field public Connected SocketEvent Called when the serial port connects
---@field public Reconnect SocketEvent Called when the serial port attempts to reconnect
---@field public Data SocketEvent Called when there is new data available on the serial port
---@field public Closed SocketEvent Called when the serial port is closed
---@field public Error SocketEvent Called when socket is closed due to an error
---@field public Timeout SocketEvent A read or write timeout was triggered and the port was closed.
TcpSocket.Events = {}

---@class SocketEOLTable
---@field public Any SocketEOL
---@field public CrLf SocketEOL
---@field public CrLfStrict SocketEOL
---@field public Lf SocketEOL
---@field public Null SocketEOL
---@field public Custom SocketEOL
TcpSocket.EOL = {}

-- *********************************************************************
--                        240-TcpSocketServer.lua
-- *********************************************************************
---@class TcpSocketServer
---@field EventHandler fun(socket: TcpSocket) Function called on any incoming socket event.
TcpSocketServer = {}

---Creates a new TcpServer instance
---@return TcpSocketServer
function TcpSocketServer:New() end

---Attempts to connect to specified port
---@param port number
function TcpSocketServer:Listen(port) end

---Stops listening
function TcpSocketServer:Close() end

-- ***************************************
--              250-Timer.lua
-- ***************************************
---@class Timer
---@field EventHandler fun(self: Timer)
Timer = {}

---Creates a new Timer instance
---@return Timer
function Timer.New() end

---Starts the timer
---@param period number in seconds
function Timer:Start(period) end

---Stops the timer
function Timer:Stop() end

---Calls the function `fun` once after `delay` seconds.
---@param fun fun() The callback to be called.
---@param delay number The delay in seconds.
function Timer.CallAfter(fun, delay) end

-- *********************************
--            260-Uci.lua
-- *********************************
---@class UciDialogParams
---@field Title string
---@field Message string
---@field Buttons string[] A list of Legends for the available response buttons.
---@field Handler fun(choiceIndex: number) A **zero** based index of the chosen response button (Not the normal 1 based of Lua tables).
Uci = {}

---Display a dialog in a UCI that contains a title, message, and button selection list.
---@param UCI_Name string The name of the target UCI for which to display the dialog
---@param params UciDialogParams
function Uci.ShowDialog(UCI_Name, params) end

---Set the screen status of a TSC touchscreen controller or UCI Viewer.
---@param TSC_Name string The name of the TSC touchscreen controller or UCI Viewer
---@param State string "On" | "Off" | "Dim"
function Uci.SetScreen(TSC_Name, State ) end

---Set which UCI to display on a TSC touchscreen controller or UCI Viewer.
---@param TSC_Name string The name of the TSC touchscreen controller or UCI Viewer
---@param UCI_Name string The name of the UCI to display
function Uci.SetUCI(TSC_Name, UCI_Name ) end

---Set which UCI page to display on a TSC touchscreen controller or UCI Viewer.
---@param TSC_Name string The name of the TSC touchscreen controller or UCI Viewer.
---@param Page_in_UCI string The UCI page to show.
function Uci.SetPage( TSC_Name, Page_in_UCI ) end

---Set the Channel Group to display on a TSC touchscreen controller or UCI Viewer.
---@param TSC_Name string The name of the TSC touchscreen controller or UCI Viewer.
---@param ChannelGroupId number The channel group number
function Uci.SetChannelGroup( TSC_Name , ChannelGroupId ) end

---Set whether and how a layer is made visible within a specified UCI name and page.
---@param uciName string The name of the UCI.
---@param pageName string The name of the UCI page.
---@param layerName string The name of the UCI layer.
---@param visibility boolean
---@param transition string "none" | "fade" | "left" | "right" | "bottom" | "top"
function  Uci.SetLayerVisibility(uciName, pageName, layerName, visibility, transition) end

---Set whether and how a layer is made visible within a specified UCI name and page.
---
---**Note:** Uci.SetSharedLayerVisibility is similar to UciSetLayerVisibility, but because Shared Layers can exist on multiple UCI pages, there is no argument for pageName.
---@param uciName string The name of the UCI.
---@param layerName string The name of the UCI layer.
---@param visibility boolean
---@param transition string "none" | "fade" | "left" | "right" | "bottom" | "top"
function  Uci.SetSharedLayerVisibility(uciName, layerName, visibility, transition) end

---Log off from a specified TSC touchscreen controller or UCI Viewer.
---@param tscName string The name of the TSC touchscreen controller or UCI Viewer.
function Uci.LogOff(tscName) end

-- ***************************************************
--                  270-UdpSocket.lua
-- ***************************************************
---@class UdpPacket
---@field public Address string
---@field public Port number
---@field public Data string
local UdpPacket = {}

---@class UdpSocket
---@field public EventHandler fun(data: UdpPacket)
UdpSocket = {}

---Creates a UDP Socket instance.
---@return UdpSocket
function UdpSocket.New() end

---Opens the UDP listener. Optionally bind to local IP and Port.
---@overload fun()
---@overload fun(IP: string)
---@param ip string
---@param port number
function UdpSocket:Open(ip, port) end

---Closes the UDP socket
function UdpSocket:Close() end

---Sends data to ip_address:port.
---@param ip string
---@param port number
---@param data string
function UdpSocket:Send(ip, port, data) end

---Joins a specific multicast 'address', optionally binding to a local 'ip'.
---@overload func(address)
---@param address string
---@param ip string
function UdpSocket:JoinMulticast(address, ip) end

-- *********************************************************************
--                        280-PluginFunctions.lua
-- *********************************************************************
---@class PluginInfo
---@field public Name string 
---@field public Version string
---@field public Id string
---@field public Description string
---@field public ShowDebug boolean
---@field public Author string
local PluginInfo = {}

---Return the default block colour in Designer
---@param props table Designer properties
---@return table colour {r,g,b}
function GetColor(props) end

---Plugin Pretty Name, shown in the properties panel and on the block
---@param props table Desiner properties
---@return string name -- name to show
function GetPrettyName(props) end

---Set properties available in designer
---@return table props
function GetProperties() end

---Rectify Properties
---@param props table Designer properties
---@return table props modified properties table
function RectifyProperties(props) return props end

--- Return a list of controls for the plugin.
---@param props table Designer properties
---@return table ctls
function GetControls(props) end

-- Returns the pages, comment out if only using a single page.
---@return table pages 
function GetPages() end

---Layout controls and graphics in the plugin
---@param props table Designer properties
---@return table layout layout of all controlls
---@return table graphics layout of all graphics
function GetControlLayout(props) end

---Construct Input and Outpins and their labels
---@param props table Designer properties
---@return table pins Table of pins
function GetPins(props) end

---Construct Internal components
---@param props table Designer properties
---@return table comps Components
function GetComponents(props) end

--0Map I/O pins to Internal component wiring
---@param props table Designer properties
---@return table wiring Internal wiring
function GetWiring(props) end