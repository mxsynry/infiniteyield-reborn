--// init
type userdata = {}
type _function = (...any) -> (...any)

local Metatable = {
	--[[
		A list of metamethod emulators used to call individual
		metamethods efficiently.
	]]
	metamethods = {
		__index = function(self, key)
			return self[key]
		end,
		__newindex = function(self, key, value)
			self[key] = value
		end,
		__call = function(self, ...)
			return self(...)
		end,
		__concat = function(self, b)
			return self..b
		end,
		__add = function(self, b)
			return self + b
		end,
		__sub = function(self, b)
			return self - b
		end,
		__mul = function(self, b)
			return self * b
		end,
		__div = function(self, b)
			return self / b
		end,
		__idiv = function(self, b)
			return self // b
		end,
		__mod = function(self, b)
			return self % b
		end,
		__pow = function(self, b)
			return self ^ b
		end,
		__tostring = function(self)
			return tostring(self)
		end,
		__eq = function(self, b)
			return self == b
		end,
		__lt = function(self, b)
			return self < b
		end,
		__le = function(self, b)
			return self <= b
		end,
		__len = function(self)
			return #self
		end,
		__iter = function(self)
			return next, self
		end,
		__namecall = function(self, ...)
			return self:_(...)
		end,
		__metatable = function(self)
			return getmetatable(self)
		end,
	}
}

--// methods

--[[
	Interceptive hook.

	Hooks `obj`'s metamethod `metamethod`
]]
function Metatable.get_L_closure(metamethod: string, obj: {any} | userdata)
	local hooked
	local metamethod_emulator = Metatable.metamethods[metamethod]
	
	xpcall(function()
		metamethod_emulator(obj)
	end, function()
		hooked = debug.info(2, "f")
	end)
	
	return hooked
end

--[[
	Interceptive hook.

	Attempts to scan for all available metamethods
]]
function Metatable.get_all_L_closures(obj: {any} | userdata)
	local metamethods = {}
	local innacurate = {}

	for method, _ in Metatable.metamethods do
		local metamethod, accurate = Metatable.get_L_closure(method, obj)
		metamethods[method] = metamethod
	end

	return metamethods
end

--[[
	Non-recursive hook.

	Calls `f` when a metamethod of `t` gets fired
]]
function Metatable.metahook(t: any, f: _function)
	local metahook = {
		__metatable = getmetatable(t) or "The metatable is locked"
	}

	for metamethod, value in Metatable.metamethods do
		metahook[metamethod] = function(self, ...)
			f()
			
			return Metatable.metahook({}, f) 
		end
	end

	return setmetatable({}, metahook)
end

--// Localization

local setmetatable = setmetatable
local pcall = pcall
local table = table.clone(table)
local debug = debug
local string = string
local setfenv = setfenv
local getfenv = getfenv

table.rawlength = function(t)
    local r = 0
    for _, _ in next, t do
        r = r + 1
    end
    return r
end

table.concat = function(t, sep)
    sep = sep or ''
    local result = ''
    local count = 1
    local length = table.rawlength(t)
    
    for _, v in next, t do
        result = result .. tostring(v)
        if count ~= length then
            result = result .. sep
        end
        count = count + 1
    end
    
    return result
end

--// Init

local function get_param_num(f)
	return debug.info(f, "a")
end

local function merge_t(a, b)
	local r = {}
	
	for i, v in a do r[i] = v end
	for i, v in b do r[i] = v end
	
	return r
end

local function Sandbox(f: (...any) -> (...any), upvalues: {any}?, constants: {string}?, protos: {(...any) -> (...any)}?, i: number?, params)
	upvalues = upvalues or {}
	constants = constants or {}
	protos = protos or {}
	params = params or {}
	i = i or 1
	
	local root = {
		root = true,
		children = {},
		stack = {},
		params = {},
		constants = constants,
		upvalues = upvalues,
		protos = protos,
		pc = 0,
		function_info = {debug.info(f, "na")},
		f = f,
		i = i
	}
	
	local id_i = 0
	local last_func
	
	local function wrap(parent: {pc: number?, children: {any}, arguments: {any?}?})
		local hooks = {}
		local t = {}
		
		for metamethod in Metatable.metamethods do
			hooks[metamethod] = function(_, ...)
				root.pc += 1
				
				local pc = root.pc
				local stack = root.stack
				local self = {pc = pc, children = {}, parent = parent, arguments = {...}, metamethod = metamethod}
				parent.children[pc] = self
				
				if metamethod == "__len" then
					return -1
				end
				
				return wrap(self)
			end
		end
		
		if root.pc ~= 0 then
			root.stack[t] = root.pc
		else
			root.stack[t] = id_i
			root.params[t] = id_i
			
			id_i += 1
		end
		
		return setmetatable(t, hooks)
	end
	
	local env = wrap(root)
	
	local param_num, vararg = get_param_num(f)
	
	for i = 1, param_num do
		local arg = wrap(root)
		
		table.insert(params, arg)
		root.params[arg] = root.i
		
		root.i += 1
	end
	
	if vararg then
		local vararg = wrap(root)
		
		table.insert(params, vararg)
		root.params[vararg] = "..."
	end
	
	local original_env = getfenv(f)
	local return_value = {pcall(setfenv(f, env), unpack(params))}
	setfenv(f, original_env)
	
	root.return_value = table.move(return_value, 2, #return_value, 1, {})
	root.success = return_value[1]
	
	return root
end