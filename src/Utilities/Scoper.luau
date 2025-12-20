-- Variables
local Modal = (script.Parent.Parent);

-- Modules
local Fusion = require(Modal.Packages.Fusion);

-- Init
local Scoper = ({});

Scoper.IsPoisoned = function(Scope: Fusion.Scope)
	local Metatable = getmetatable(Scope);

	if (typeof(Metatable) ~= "table") then
		return false
	end

	return Metatable._FUSION_POISONED
end

Scoper.Insert = function(Scope: Fusion.Value, Objects: { any })
	for _, Object in next, Objects or {} do
		table.insert(Scope, Object)
	end
end

Scoper.IsFusionValue = function(Value: any)
	return (typeof(Value) == "table") and (typeof(Value.scope) == "table")
end

Scoper.Unwrap = function(Value: any)
	if Scoper.IsFusionValue(Value) then
		return Fusion.peek(Value)
	end

	return Value
end

Scoper.Add = function(Target: Fusion.Value, Value)	
	if Scoper.IsFusionValue(Target) then
		local New = Scoper.Unwrap(Target);
		table.insert(New, Value);
		Target:set(New);
	end
	
	return Target
end

return Scoper
