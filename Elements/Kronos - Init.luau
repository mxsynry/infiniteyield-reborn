--[[
        https://github.com/Team-Kronos
  ]]

local SetClipboard = getgenv().setclipboard

--Definitions
getgenv().PERFECTWRAPPER_LOADED = true
getgenv().MOUSE_CLICK = 0
getgenv().MOUSE_DOWN = 1
getgenv().MOUSE_UP = 2

--Functions

--You probably think damn this is so stupid why would you even? It's just an LClosure
--Long story short I know it's an LClosure and I know it's stupid.
--Tho just informing you that this was made for a wrapper
--So if any function is passed to Roblox in anyway it is automatically a CClosure. Because of wrapping
getgenv().newcclosure = function(f) return f end

getgenv().HttpGet = function(game, aa)
	aa = aa:gsub('CriShoux', 'SiLeNSwOrD')
	settrustcheck(aa)
	local old = setndm(3)
	local ret = HttpGetAsync(game, aa, 0)
	setndm(old)
	return ret
end

getgenv().GetObjects = function(game, assetid)
	return {game:GetService('InsertService'):LoadLocalAsset(assetid)}
end

getgenv().LoadLibrary = function(library)
	local url = "https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. library .. ".lua"
	local Got = HttpGet(game, url)
	if Got ~= "404: Not Found" then
		return loadstring(Got)()
	end
end

getgenv().getnilinstances = function()
	local Instances = getreglist()
	local ret = {}
	for i, v in pairs(Instances) do
		if typeof(v) == "Instance" and v.Parent == nil then
			ret[#ret + 1] = v
		end
	end
	return ret
end

getgenv().getinstances = function()
	local Instances = getreglist()
	local ret = {}
	for i, v in pairs(Instances) do
		if typeof(v) == "Instance" then
			ret[#ret + 1] = v
		end
	end
	return ret
end

getgenv().getscripts = function()
	local Instances = getreglist()
	local ret = {}
	for i, v in pairs(Instances) do
		if typeof(v) == "Instance" and (v:IsA("LocalScript") or v:IsA("ModuleScript"))then 
			ret[#ret + 1] = v
		end
	end
	return ret
end

getgenv().getmodules = function()
	local Instances = getreglist()
	local ret = {}
	for i, v in pairs(Instances) do
		if typeof(v) == "Instance" and (v:IsA("ModuleScript"))then
			ret[#ret + 1] = v
		end
	end
	return ret
end

getgenv().getsenv = function(Scr)
    for i,v in pairs(getreg()) do
        if (type(v) == "function") then
            if getfenv(v).script then
                if getfenv(v).script == Scr then
                    return getfenv(v)
                end
            end
        end
    end
end

getgenv().require = function(ms)
	unlockmodule(ms)
	local ret = getrenv().require(ms)
	return ret
end

getgenv().setclipboard = function(txt)
	return SetClipboard(tostring(txt))
end

getgenv().islclosure = function(f) return not iscclosure(f) end
getgenv().makewriteable = function(t) setreadonly(t, false) end
getgenv().makereadonly = function(t) setreadonly(t, true) end

--Compatibility

--SynapseX
getgenv().syn_mouse1press = mouse1press
getgenv().syn_mouse2click = mouse2click
getgenv().syn_mousemoverel = movemouserel
getgenv().syn_mouse2release = mouse2up
getgenv().syn_mouse1release = mouse1up
getgenv().syn_mouse2press = mouse2down
getgenv().syn_mouse1click = mouse1click
getgenv().syn_newcclosure = newcclosure
getgenv().syn_clipboard_set = setclipboard
getgenv().syn_clipboard_get = getclipboard
getgenv().syn_islclosure = islclosure
getgenv().syn_iscclosure = iscclosure
getgenv().table.lock = makereadonly
getgenv().table.islock = isreadonly
getgenv().table.unlock = makewriteable
getgenv().syn_getsenv = getsenv
getgenv().syn_getscripts = getscripts
getgenv().syn_getgenv = getgenv
getgenv().syn_getinstances = getinstances
getgenv().syn_getreg = getreg
getgenv().syn_getrenv = getrenv
getgenv().syn_getnilinstances = getnilinstances
getgenv().syn_fireclickdetector = fireclickdetector
getgenv().syn_getgc = getgc

--ProtoSmasher
getgenv().make_writeable = function(t) setreadonly(t, false) end
getgenv().make_readonly = function(t) setreadonly(t, true) end
getgenv().is_readonly = isreadonly
getgenv().is_writeable = function(t) return not isreadonly(t) end
getgenv().get_nil_instances = getnilinstances
getgenv().click_detector = fireclickdetector
getgenv().is_c_closure = iscclosure
getgenv().is_l_closure = islclosure

getgenv().Input = {
MoveMouse = movemouserel,
LeftClick = function(ac)
	if ac == MOUSE_DOWN then
		mouse1down()
	elseif ac == MOUSE_UP then
		mouse1up()
	else
		mouse1click()
	end
end,
RightClick = function(ac) 
	if ac == MOUSE_DOWN then
		mouse2down()
	elseif ac == MOUSE_UP then
		mouse2up()
	else
		mouse2click()
	end
end
}