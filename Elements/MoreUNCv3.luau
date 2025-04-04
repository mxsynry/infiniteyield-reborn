-- some solara users said that v3 doesnt work, dm mxsynry (discord) and screenshot the error for me

for i, _ in next, getgenv() do 
    if i ~= "loadstring" and i ~= "getgenv" then
        getgenv()[i]=nil
    end
end

local B = 2147483647 -- 32bit integer limit

--^ Variables:

local string, table, task, Instance, game, debug = string, table, task, Instance, workspace.Parent, debug

local find, gsub, sub, rep, format, match, gmatch, split, byte, char = string.find, string.gsub, string.sub, string.rep, string.format, string.match, string.gmatch, string.split, string.byte, string.char
local tfind, tinsert, tconcat, tunpack, tclear = table.find, table.insert, table.concat, table.unpack, table.clear
local cwrap, cyield = coroutine.wrap, coroutine.yield
local DEBUG_INFO = debug.info

local Instance_new = Instance.new

local UDim2_fromOffset = UDim2.fromOffset
local deg, sqrt, atan2, random, clamp = math.deg, math.sqrt, math.atan2, math.random, math.clamp

--& Lua(u) Globals

local pcall, next, tostring, tonumber, assert, typeof, tick, setfenv, getfenv, setmetatable, error, newproxy = pcall, next, tostring, tonumber, assert, typeof, tick, setfenv, getfenv, setmetatable, error, newproxy
local wait, spawn, delay = task.wait, task.spawn, task.delay

--* Instances

local HttpService = game:GetService("HttpService")
local ScriptContext = game:GetService("ScriptContext")
local LinkingService = game:GetService("LinkingService")
local InsertService = game:GetService("InsertService")
local UserInputService = game:GetService("UserInputService")
local UGCValidationService = game:GetService("UGCValidationService")

local VirtualInputManager = Instance_new("VirtualInputManager")

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local RobloxActive = true

local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local HiddenUI = Instance_new("Folder")
HiddenUI.Name = "HiddenUI" .. rep("\0", random(2, 10))

local Keys = {
    [0x08] = Enum.KeyCode.Backspace,
    [0x09] = Enum.KeyCode.Tab,
    [0x0C] = Enum.KeyCode.Clear,
    [0x0D] = Enum.KeyCode.Return,
    [0x10] = Enum.KeyCode.LeftShift,
    [0x11] = Enum.KeyCode.LeftControl,
    [0x12] = Enum.KeyCode.LeftAlt,
    [0x13] = Enum.KeyCode.Pause,
    [0x14] = Enum.KeyCode.CapsLock,
    [0x1B] = Enum.KeyCode.Escape,
    [0x20] = Enum.KeyCode.Space,
    [0x21] = Enum.KeyCode.PageUp,
    [0x22] = Enum.KeyCode.PageDown,
    [0x23] = Enum.KeyCode.End,
    [0x24] = Enum.KeyCode.Home,
    [0x2D] = Enum.KeyCode.Insert,
    [0x2E] = Enum.KeyCode.Delete,
    [0x30] = Enum.KeyCode.Zero,
    [0x31] = Enum.KeyCode.One,
    [0x32] = Enum.KeyCode.Two,
    [0x33] = Enum.KeyCode.Three,
    [0x34] = Enum.KeyCode.Four,
    [0x35] = Enum.KeyCode.Five,
    [0x36] = Enum.KeyCode.Six,
    [0x37] = Enum.KeyCode.Seven,
    [0x38] = Enum.KeyCode.Eight,
    [0x39] = Enum.KeyCode.Nine,
    [0x41] = Enum.KeyCode.A,
    [0x42] = Enum.KeyCode.B,
    [0x43] = Enum.KeyCode.C,
    [0x44] = Enum.KeyCode.D,
    [0x45] = Enum.KeyCode.E,
    [0x46] = Enum.KeyCode.F,
    [0x47] = Enum.KeyCode.G,
    [0x48] = Enum.KeyCode.H,
    [0x49] = Enum.KeyCode.I,
    [0x4A] = Enum.KeyCode.J,
    [0x4B] = Enum.KeyCode.K,
    [0x4C] = Enum.KeyCode.L,
    [0x4D] = Enum.KeyCode.M,
    [0x4E] = Enum.KeyCode.N,
    [0x4F] = Enum.KeyCode.O,
    [0x50] = Enum.KeyCode.P,
    [0x51] = Enum.KeyCode.Q,
    [0x52] = Enum.KeyCode.R,
    [0x53] = Enum.KeyCode.S,
    [0x54] = Enum.KeyCode.T,
    [0x55] = Enum.KeyCode.U,
    [0x56] = Enum.KeyCode.V,
    [0x57] = Enum.KeyCode.W,
    [0x58] = Enum.KeyCode.X,
    [0x59] = Enum.KeyCode.Y,
    [0x5A] = Enum.KeyCode.Z,
    [0x5D] = Enum.KeyCode.Menu,
    [0x60] = Enum.KeyCode.KeypadZero,
    [0x61] = Enum.KeyCode.KeypadOne,
    [0x62] = Enum.KeyCode.KeypadTwo,
    [0x63] = Enum.KeyCode.KeypadThree,
    [0x64] = Enum.KeyCode.KeypadFour,
    [0x65] = Enum.KeyCode.KeypadFive,
    [0x66] = Enum.KeyCode.KeypadSix,
    [0x67] = Enum.KeyCode.KeypadSeven,
    [0x68] = Enum.KeyCode.KeypadEight,
    [0x69] = Enum.KeyCode.KeypadNine,
    [0x6A] = Enum.KeyCode.KeypadMultiply,
    [0x6B] = Enum.KeyCode.KeypadPlus,
    [0x6D] = Enum.KeyCode.KeypadMinus,
    [0x6E] = Enum.KeyCode.KeypadPeriod,
    [0x6F] = Enum.KeyCode.KeypadDivide,
    [0x70] = Enum.KeyCode.F1,
    [0x71] = Enum.KeyCode.F2,
    [0x72] = Enum.KeyCode.F3,
    [0x73] = Enum.KeyCode.F4,
    [0x74] = Enum.KeyCode.F5,
    [0x75] = Enum.KeyCode.F6,
    [0x76] = Enum.KeyCode.F7,
    [0x77] = Enum.KeyCode.F8,
    [0x78] = Enum.KeyCode.F9,
    [0x79] = Enum.KeyCode.F10,
    [0x7A] = Enum.KeyCode.F11,
    [0x7B] = Enum.KeyCode.F12,
    [0x90] = Enum.KeyCode.NumLock,
    [0x91] = Enum.KeyCode.ScrollLock,
    [0xBA] = Enum.KeyCode.Semicolon,
    [0xBB] = Enum.KeyCode.Equals,
    [0xBC] = Enum.KeyCode.Comma,
    [0xBD] = Enum.KeyCode.Minus,
    [0xBE] = Enum.KeyCode.Period,
    [0xBF] = Enum.KeyCode.Slash,
    [0xC0] = Enum.KeyCode.Backquote,
    [0xDB] = Enum.KeyCode.LeftBracket,
    [0xDD] = Enum.KeyCode.RightBracket,
    [0xDE] = Enum.KeyCode.Quote
}

UserInputService.WindowFocused:Connect(function()
    RobloxActive = true
end)

UserInputService.WindowFocusReleased:Connect(function()
    RobloxActive = false
end)

local function internal_read(file)
    local success, content = pcall(function()
        return InsertService:GetLocalFileContents(format("rbxasset://%s", file))
    end)

    return success and content or ""
end

local JSONDecode = function(Text)
    return HttpService:JSONDecode(Text)
end

local HTTP = {}

local cloneref = cloneref or function(p1)
    return p1
end

do
    if not pcall(function()
        HiddenUI.Parent = cloneref(CoreGui)
    end) then
        HiddenUI.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end
end

USER = match(ScriptContext:SaveScriptProfilingData("", "_"), "C:\\Users\\(.-)\\")

--^ Functions:

local function run_batch(batch)
    LinkingService:OpenUrl(ScriptContext:SaveScriptProfilingData(batch, "TEMP.bat"))
end

local function getthreadidentity() -- Taken from previous moreunc (MoreUNC v2.0.0)
    local function try(f)
        return function()
            return pcall(f);
        end
    end

	for i, v in next, ({
		try(function() return game.Name end),
		try(function() return game:GetService("CoreGui").Name end),
		try(function() return game.DataCost end),
		try(function() return Instance_new, "Player" end),
		try(function() return game:GetService("CorePackages").Name end),
		try(function() return Instance_new("SurfaceAppearance").TexturePack end),
		try(function() Instance_new("MeshPart").MeshId = "" end)
	}) do
        if not v() then
            return i - 1; -- Previous level because the current isnt available
        end
    end
	
    return 7;
end

local function request(Args) -- Args: {Url: string, Method: string, Headers: table | nil, Body: string | nil}
    Args = Args or {};
    local Url, Method, Headers, Body = Args.Url, Args.Method, Args.Headers, Args.Body

    --! Assertions
    assert(Url, "Missing request url.")
    assert(Method, "Missing request method.")

    --* Main Function

    local Content = {}

    HttpService:RequestInternal({
        Url = Url,
        Method = Method,
        Headers = Headers,
        Body = Body
    }):Start(function(Success, Returned)
        Content = Returned
        Content.Success = Success
    end)

    repeat
        wait()
    until
        Content.Success ~= nil

    return Content;
end

local function httpget(a, b, c) -- url, nocache
    if typeof(a) ~= "string" then -- instance?
        a = b
        b = c
    end

    if b then -- no cache
        return request({Url = a, Method = "GET"}).Body
    else
        local Saved = HTTP[a] or request({Url = a, Method = "GET"}).Body

        HTTP[a] = Saved
        return Saved
    end
end

local base64 = {
	encode = function(data)
		local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        local Part = gsub(data,
            ".",
            function(x)
                local r, b = "", byte(x)
                for i = 8, 1, -1 do
                    r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
                end
                return r
            end
        ) .. "0000"
        return gsub(
            Part,
            "%d%d%d?%d?%d?%d?",
            function(x)
                if (#x < 6) then
                    return ""
                end
                local c = 0
                for i = 1, 6 do
                    c = c + (sub(x, i, i) == "1" and 2 ^ (6 - i) or 0)
                end
                return sub(letters, c + 1, c + 1)
            end
        ) .. ({"", "==", "="})[#data % 3 + 1]
	end,
	decode = function(data)
		local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
		data = gsub(data, '[^'..b..'=]', '') -- [^base64_chars and =]

		return (gsub(data, '.', function(x)
			if x == '=' then return '' end
			local r, f = '', (find(b, x) - 1)
			for i = 6, 1, -1 do
				r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
			end
			return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if #x ~= 8 then return '' end
			local c = 0
			for i = 1, 8 do
				c = c + (sub(x, i, i) == '1' and 2^(8 - i) or 0)
			end
			return char(c)
		end))
	end
}

local HashLib = loadstring(game:HttpGet("https://pastebin.com/raw/iRDTgy7w" or "https://raw.githubusercontent.com/RyXeleron/infiniteyield-reborn/refs/heads/master/Elements/HashLib.lua" or "https://raw.githubusercontent.com/RyXeleron/ryxeleron.github.io/main/storage/iyrbackup/legacy/master/Elements/HashLib.lua", true))()
local Sandbox, ReverseGet = loadstring(game:HttpGet("https://raw.githubusercontent.com/bbbbbbbbbbbbbb121/sandbox/refs/heads/main/latest.lua", true))()

local NIL = {}
local DrawingCache = {}

game = Sandbox(game, {
    HttpGet = httpget,
    HttpGetAsync = httpget
})
workspace = Sandbox(workspace)
script = Sandbox(script)

Game = game
Workspace = workspace

game.DescendantRemoving:Connect(function(d)
	tinsert(NIL, d)
end)

--* Bridge:

local Bridge = {
    Url = "http://localhost:8000/",
    Connected = false,
    Responses = {}
};

function Bridge:Connect()
    if not Bridge.Connected then
        repeat
            local Response = request({
                Url = Bridge.Url,
                Method = "GET"
            }).Body

            wait(1) -- Polling because we dont have websockets :broken-heart:
        until
            Response == "Up"
        Bridge.Connected = true
    end
end

function Bridge:Send(Path, Data, NoEncode) -- /hi, {}
    Bridge:Connect();
    local Base64 = {};
    if Data then
        for i, v in next, Data do
            Base64[i] = typeof(v) == "string" and not NoEncode and base64.encode(v) or v
        end
    end

    local json = Data and HttpService:JSONEncode(Base64) or nil
    local Response = Bridge.Responses[Path .. (Data and json or "")]

    if Response then
        return Response
    end

    Response = request({
        Url = Bridge.Url .. Path,
        Method = Data and "POST" or "GET",
        Headers = Data and {
            ["Content-Type"] = "application/json"
        } or nil,
        Body = json
    }).Body

    if sub(Response, 1, 15) == "<!doctype html>" then
        error("Unable to send request to /" .. Path, 2)
    end

    Bridge.Responses[Path .. (Data and json or "")] = Response -- Cacheing
    return Response
end

--* Starting the bridge:
do
    local BRIDGE_PYTHON = format([[from concurrent.futures import thread
from flask import Flask, request, jsonify

import os
import json
import string
import random
from itsdangerous import base64_decode
import pyperclip

import psutil

UserHome = os.path.expanduser("~")
DownloadPath = os.path.join(UserHome, "Downloads")
ExecutorName = "MoreUNC"

def GenerateId(length=6):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def GetRobloxVersion():
    RobloxPath = f"{UserHome}/AppData/Local/Roblox/Versions"
    for Folder in os.listdir(RobloxPath):
        FolderPath = os.path.join(RobloxPath, Folder)
        if os.path.isdir(FolderPath) and "RobloxPlayerLauncher.exe" in os.listdir(FolderPath):
            return Folder
    return None

def FindRobloxProcess():
    for Process in psutil.process_iter(['name', 'exe']):
        try:
            if "roblox" in Process.info['name'].lower():
                return Process.info['exe']
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            continue
    return ""

Process = FindRobloxProcess()

#IsBloxstrap = "\\Local\\Bloxstrap" in Process
RobloxFolder = "".join(a + "\\" for a in Process.split("\\")[:-1])

Logs = f"{UserHome}/AppData/Local/Roblox/versions/{GetRobloxVersion()}/logs/"

def GetWorkspace(FileName=""):
    return os.path.join(DownloadPath, ExecutorName, "workspace", FileName)

app = Flask(__name__)

def Decrypt(Payload_ENCODED, Decode=False):
    Payload = {}
    
    for i in Payload_ENCODED:
        Value = Payload_ENCODED[i]
        Value2 = isinstance(Value, str) and base64_decode(Value) or Value
        Payload[i] = Decode and Value2 != Value and Value2.decode() or Value2
        
    return Payload

@app.route('/')
def Home():
    """Home endpoint."""
    return "Up"

@app.route('/files', methods=["POST"])
def ManageFiles():
    """Handle file-related operations."""
    Payload = Decrypt(request.get_json())
    
    FileName = Payload.get("file", "").decode()
    FilePath = GetWorkspace(FileName)
    IsFolder = Payload.get("folder", False)
    Method = Payload.get("method", "").decode().lower()

    try:
        if Method == "delete":
            if os.path.exists(FilePath):
                if IsFolder and os.path.isdir(FilePath):
                    os.rmdir(FilePath)
                else:
                    os.remove(FilePath)
                return "File/Folder deleted successfully."
            return "File/Folder does not exist."

        elif Method == "create":
            Content = Payload.get("content", "")
            if IsFolder:
                os.makedirs(FilePath, exist_ok=True)
            else:
                with open(FilePath, "wb") as File:
                    File.write(Content)
            return "File/Folder created successfully."

        elif Method == "read":
            if IsFolder:
                return "Cannot read a folder."
            if os.path.exists(FilePath):
                with open(FilePath, "rb") as File:
                    return File.read()
            return "File not found."

        elif Method == "list":
            if os.path.exists(FilePath):
                files = []
                for file in os.listdir(FilePath):
                    files.append(FilePath + file)
                return json.dumps(files)
            return "Directory not found."

        elif Method == "check":
            Exists = os.path.exists(FilePath)
            IsDir = os.path.isdir(FilePath)
            return "true" if (IsFolder and IsDir) or (not IsFolder and Exists and not IsDir) else "false"

    except Exception as Error:
        print("Error:",Error)
        return "An error occurred while processing the request."


@app.route('/functions', methods=["POST"])
async def Functions():
    Payload = Decrypt(request.get_json(), True)
    Func = Payload.get("func", "").lower()

    try:
        if Func == "getcustomasset":
            SourcePath = GetWorkspace(Payload["file"])
            GeneratedId = GenerateId() + os.path.splitext(SourcePath)[1]
            CustomPath = os.path.join(RobloxFolder, "content", "textures")
            CustomFilePath = os.path.join(CustomPath, GeneratedId)

            with open(SourcePath, "rb") as SourceFile:
                with open(CustomFilePath, "wb") as CustomFile:
                    CustomFile.write(SourceFile.read())

            return f"rbxasset://textures/{GeneratedId}"
        elif Func == "setclipboard":
            pyperclip.copy(Payload.get("text"))

        return "Invalid function."

    except Exception as Error:
        print("Error 2:", Error)
        return "An error occurred while processing the function."

if __name__ == "__main__":
    app.run(host='localhost', port=8000)]])

    -- hosting the server:
    run_batch(format([[@echo off
python --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed! Please install Python first.
    pause
)

python %s
]], ScriptContext:SaveScriptProfilingData(BRIDGE_PYTHON, "server.py")))
    Bridge:Connect()
    repeat wait() until Bridge.Connected
end

-- File System: Bridge

local function makefolder(FolderPath)
    assert(typeof(FolderPath) == "string", "Invalid argument #1 to 'makefolder', string expected, got " .. typeof(FolderPath))

    Bridge:Send("files", {
        folder = true,
        file = FolderPath,
        method = "create"
    })
end

local function writefile(Name, Content)
    assert(typeof(Name) == "string", "Invalid argument #1 to 'writefile', string expected, got " .. typeof(Name))
    assert(typeof(Content) == "string", "Invalid argument #2 to 'writefile', string expected, got " .. typeof(Content))

    Bridge:Send("files", {
        folder = false,
        content = Content,
        file = Name,
        method = "create"
    })
end

local function delfile(Path)
    return Bridge:Send("files", {
        folder = false,
        file = Path,
        method = "delete"
    })
end

local function delfolder(Path)
    return Bridge:Send("files", {
        folder = true,
        file = Path,
        method = "delete"
    })
end

local function readfile(Path)
    local f = Bridge:Send("files", {
        file = Path,
        method = "read"
    })

    if f == "File not found." then
        error("File doesn't exist.", 2)
    end

    return f
end

local function listfiles(Path)
    local files = HttpService:JSONDecode(Bridge:Send("files", {
        file = Path,
        method = "list"
    }))

    if files == "Failed to get files." then
        error("Invalid file path", 2)
    end

    return files
end

local function isfile(Path)
    return Bridge:Send("files", {
        file = Path,
        folder = false,
        method = "check"
    }) == "true"
end

local function isfolder(Path)
    return Bridge:Send("files", {
        file = Path,
        folder = true,
        method = "check"
    }) == "true"
end

local function getcustomasset(Path)
    return Bridge:Send("functions", {
        func = "getcustomasset",
        file = Path
    })
end

local function iscclosure(fn)
    return DEBUG_INFO(fn, "s") == "[C]"
end

local function islclosure(fn)
    return DEBUG_INFO(fn, "s") ~= "[C]"
end

local function clonefunction(fn)
    return function(...)
        return fn(...)
    end
end

local Debug = setmetatable({
    getinfo = function(fn)
        local i = {}
        local np, isvrg = DEBUG_INFO(fn, "a")
        i.what = islclosure(fn) and "Lua" or "C"
        i.short_src = DEBUG_INFO(fn, "s")
        i.source = DEBUG_INFO(fn, "s")
        i.name = DEBUG_INFO(fn, "n")
        i.func = typeof(fn) == "function" and fn or DEBUG_INFO(fn, "f")
        i.numparams = np
        i.is_vararg = isvrg and 1 or 0
        i.currentline = DEBUG_INFO(fn, "l")

        return i
    end
}, {
    __index = debug
})

local function isourclosure(fn)
    return islclosure(fn) and Debug.getinfo(fn).source == Debug.getinfo(function()end).source or (function()
        for _, v in next, getfenv(0) do
            if v == fn then
                return true
            end
        end
        return false
    end)()
end

local function newcclosure(fn)
	local shawarma = cwrap(function(...) -- haha get it because shawarma wrap
		local b = {cyield()}
		while true do
			b={cyield(fn(tunpack(b)))}
		end
	end)

    shawarma()
	return shawarma
end

local function hash(t, a)
    assert(typeof(t) == "string", "Invalid argument #1 to 'hash', string expected, got " .. typeof(t))
    assert(typeof(a) == "string", "Invalid argument #2 to 'hash', string expected, got " .. typeof(a))

    a = gsub(a, "-", "_")

    local f = HashLib[a]

    assert(f, "No algorithm found by the name '" .. a .. "'")

    return f(t)
end

local function decompile(LuaScriptContainer) --> requires getscriptbytecode
    assert(tfind({"ModuleScript", "LocalScript"}, LuaScriptContainer.ClassName), "Invalid argument #1 to 'decompile', LuaSourceContainer expected, got " .. LuaScriptContainer.ClassName)

    return request({
        Url = "http://api.plusgiant5.com/konstant/decompile",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "text/plain"
        },
        Body = getscriptbytecode(LuaScriptContainer)
    }).Body
end

local function setclipboard(text)
    assert(typeof(text) == "string", "Invalid argument #1 to 'setclipboard', string expected got " .. typeof(text))

    spawn(Bridge.Send, Bridge, "functions", {
        func = "setclipboard",
        text = text
    })
end

local Fonts = {
	[0] = Enum.Font.Arial,
	[1] = Enum.Font.BuilderSans,
	[2] = Enum.Font.Gotham,
	[3] = Enum.Font.RobotoMono
}

local function Create(Class, Properties)
    local Object = Instance_new(Class);

    for i, v in next, Properties do
        Object[i] = ReverseGet(v) or v
    end

    return Object
end

local function gethui()
    return Sandbox(HiddenUI)
end

local UI = Create("ScreenGui", {
    Parent = gethui(),
    Name = "Drawing | MoreUNC"
})

local Drawing = {
	Fonts = {
	    UI = 0,
	    System = 1,
	    Plex = 2,
	    Monospace = 3,
    },
	new = function(Type)
        local Object = Create("Frame", {
            Visible = true,
            Size = UDim2_fromOffset(0, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 1,
            Parent = UI
        });

        local self = {
            Visible = Object.Visible,
            Color = Object.BackgroundColor3,
            Transparency = 1,
            ZIndex = Object.ZIndex,
            Remove = function() Object:Destroy() end
        }

        self.Destroy = self.Remove

        local function Construct(Update, Defaults, Default, Readonly)
            Readonly = Readonly or {}
            local function inlined()
                if not Default then
                    Object.Visible = self.Visible
                    Object.BackgroundColor3 = self.Color
                    Object.BackgroundTransparency = 1 - self.Transparency
                    Object.ZIndex = clamp(self.ZIndex, -B, B)
                end

                Update()
            end

            for i, v in next, Defaults do
                self[i] = v
            end

            local proxy = newproxy(true)
            local mt = getmetatable(proxy)

            mt.__index = function(_, b)
                return self[b]
            end
            mt.__newindex = function(_, Key, Value)
                if tfind(Readonly, Key) then
                    return;
                end
                self[Key] = Value
                inlined()
            end
            mt.__metatable = "This metatable is protected."

            tinsert(DrawingCache, {proxy=proxy, instance = Object})

            return proxy
        end

        --* Line

		if Type == 'Line' then
			return Construct(function()
                local from, to = self.From, self.To
                local dX, dY = to.X - from.X, to.Y - from.Y

                Object.Size = UDim2_fromOffset(sqrt(dX ^ 2 + dY ^ 2), self.Thickness)
                Object.Position = UDim2_fromOffset(from.X, from.Y)
                Object.Rotation = deg(atan2(dY, dX))
            end, {
                Thickness = 1,
                From = Vector2.zero,
                To = Vector2.zero
            })
		elseif Type == 'Square' then
			local Stroke = Create("UIStroke", {
                Parent = Object,
                Color = self.Color,
                Enabled = true,
                Thickness = 1
            })

			return Construct(function()
				Object.Size = UDim2.new(0, self.Size.X, 0, self.Size.Y)
				Object.Position = UDim2.new(0, self.Position.X, 0, self.Position.Y)
    
				Stroke.Enabled = self.Filled
				Stroke.Color = self.Color
                Stroke.Thickness = self.Thickness
			end, {
                Size = Vector2.zero,
                Position = Vector2.zero,

                Filled = false,
                Thickness = 1,
                Transparency = 0
            })
		elseif Type == 'Circle' then
			local Stroke = Create("UIStroke", {
                Parent = Object,
                Color = self.Color,
                Enabled = true
            })
			Create("UICorner", {
                Parent = Object,
                CornerRadius = UDim.new(1, 0)
            })

			return Construct(function()
					Object.Size = UDim2.fromScale(self.Radius, self.Radius)
					Object.Position = UDim2.fromScale(self.Position.X, self.Position.Y)

					Stroke.Enabled = not self.Filled
    
					Stroke.Color = self.Color
                    Stroke.Thickness = self.Thickness
			end, {
                Thickness = 1,
                NumSides = 0,
                Radius = 1,

                Filled = false,

                Position = Vector2.zero
            })
		elseif Type == 'Text' then
            Object:Destroy()
			Object = Create("TextLabel", {
                Parent = UI,
                Visible = self.Visible,
                Size = UDim2.fromOffset(0, 0),
                BackgroundColor3 = self.Color,
                BackgroundTransparency = 1 - self.Transparency,
                BorderSizePixel = 0,
                TextStrokeColor3 = self.Color,
                TextStrokeTransparency = 1,
                TextSize = self.Size,
                TextWrapped = false
            })

			return Construct(function()
					Object.Size = UDim2.fromOffset(self.Size * 3, self.Size / 2)
					Object.Position = UDim2.fromOffset(self.Position.X, self.Position.Y)
					Object.Text = self.Text

					Object.Font = Fonts[self.Font]
					Object.TextColor3 = self.Color
					Object.BackgroundTransparency = 1 - self.Transparency

					if self.Center then
						Object.TextXAlignment = Enum.TextXAlignment.Center
						Object.TextYAlignment = Enum.TextYAlignment.Center
					else
						Object.TextXAlignment = Enum.TextXAlignment.Left
						Object.TextYAlignment = Enum.TextYAlignment.Top
					end

					Object.TextStrokeTransparency = self.Outline and 0 or 1
					Object.TextStrokeColor3 = self.OutlineColor
                    self.TextBounds = Object.TextBounds
			end, {
                Text = '',
                Size = 0,
                Center = false,
                Outline = false,
                OutlineColor = self.Color,
                Position = Vector2.zero,
                Font = 3
            }, true, {"TextBounds"})
		end
end}

local function isrenderobj(a)
    for _, object in next, DrawingCache do
		if object.proxy == a then
			return true
		end
	end
    return false
end

local function cleardrawcache()
    for _, Object in next, DrawingCache do
        Object.instance:Destroy()
    end
end

local function getrenderproperty(a, b)
    assert(isrenderobj(a), "Invalid argument #1 to 'getrenderproperty', render object expected, got " .. typeof(a))
    return a[b]
end

local function setrenderproperty(a, b, c)
    assert(isrenderobj(a), "Invalid argument #1 to 'setrenderproperty', render object expected, got " .. typeof(a))

    a[b] = c
end

local function getscripthash(LuaScriptContainer)
	assert(tfind({"ModuleScript", "LocalScript"}, LuaScriptContainer.ClassName), "Invalid argument #1 to 'decompile', LuaSourceContainer expected, got " .. LuaScriptContainer.ClassName)

	return LuaScriptContainer:GetHash()
end

--* Input Functions

local function iswindowactive()
    return RobloxActive
end

--kb

local function keypress(Key)
    VirtualInputManager:SendKeyEvent(true, Keys[Key], false, game)
end

local function keyrelease(Key)
    VirtualInputManager:SendKeyEvent(false, Keys[Key], false, game)
end

--mouse

local function mouse1press()
    VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 0)
end

local function mouse1release()
    VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 0)
end

local function mouse1click()
    mouse1press()
    mouse1release()
end

local function mouse2press()
    VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 1, true, game, 0)
end

local function mouse2release()
    VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 1, false, game, 0)
end

local function mouse2click()
    mouse2press()
    mouse2release()
end

local function mousemoveabs(x, y) -- x: int, y: int
    VirtualInputManager:SendMouseWheelEvent(x, y, false, game)
end

local function mousemoverel(x, y) -- x: float, y: float
    mousemoveabs(Camera.ViewportSize.X * x, Camera.ViewportSize.Y * y)
end

--other

local function getinstances()
    return game:GetDescendants()
end

local function getnilinstances()
    return NIL
end

local function getscripts()
    local list = {}
    for _, scr in next, getinstances() do
        if scr:IsA("LocalScript") or scr:IsA("ModuleScript") then
            tinsert(list, scr)
        end
    end

    return list
end

local function getexecutorname()
    return "MoreUNC", "3.0.0"
end

local function gethiddenproperty(a, b)
    local Success, Value = pcall(function()
        return UGCValidationService:GetPropertyValue(a, b)
    end)

    assert(Success, "Invalid argument #2 to 'gethiddenproperty', property is not a valid member of Instance")

    return Value
end

local function getfflag(fflag)
    local Success, Value = pcall(function()
        return game:GetFastFlag(gsub(fflag, "FFlag", ""))
    end)

    assert(Success, "FFlag doesn't exist.")
    return Value
end

local function SetEnvironment(Value)
    for i, v in next, Value do
        getgenv()[i] = v
    end
end

SetEnvironment({
    listfiles = listfiles,
    readfile = readfile,
    isfile = isfile,
    isfolder = isfolder,
    writefile = writefile,
    makefolder = makefolder,
    delfile = delfile,
    delfolder = delfolder,

    getsynasset = getcustomasset,
    getcustomasset = getcustomasset,

    clonefunction = clonefunction,
    clonefunc = clonefunction,

    iscclosure = iscclosure,
    islclosure = islclosure,
    isourclosure = isourclosure,
    iskrnlclosure = isourclosure,
    issynclosure = isourclosure,

    newcclosure = newcclosure,

    getthreadidentity = getthreadidentity,

    crypt = {
        hash = hash,
        custom = {
            hash = hash
        },
        base64 = base64,

        base64_encode = base64.encode,
        base64encode = base64.encode,
    
        base64_decode = base64.decode,
        base64decode = base64.decode,
    },
    
    base64 = base64,
    base64_encode = base64.encode,
    base64encode = base64.encode,
    
    base64_decode = base64.decode,
    base64decode = base64.decode,

    debug = Debug,

    request = request,
    http_request = request,
    http = {
        request = request
    },

    httpget = httpget,

    decompile = decompile,

    gethui = gethui,

    game = game,
    workspace = workspace,
    script = script,
    Game = Game,
    Workspace = Workspace,

    Drawing = Drawing,
    cleardrawcache = cleardrawcache,
    isrenderobj = isrenderobj,
    getrenderproperty = getrenderproperty,
    setrenderproperty = setrenderproperty,

    setclipboard = setclipboard,
    setrbxclipboard = setrbxclipboard,
    writeclipboard = setclipboard,

    mouse1press = mouse1press,
    mouse1release = mouse1release,
    mouse1click = mouse1click,

    mouse2press = mouse2press,
    mouse2release = mouse2release,
    mouse2click = mouse2click,

    mousemoveabs = mousemoveabs,
    mousemoverel = mousemoverel,

    keypress = keypress,
    keyrelease = keyrelease,

    isrbxactive = iswindowactive,
    isrobloxactive = iswindowactive,

    getinstances = getinstances,
    getnilinstances = getnilinstances,
    getscripts = getscripts,

    getscripthash = getscripthash,

    getexecutorname = getexecutorname,
    identifyexecutor = getexecutorname,

    gethiddenproperty = gethiddenproperty,
    getfflag = getfflag
})