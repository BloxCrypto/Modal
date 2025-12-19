-- Variables
local Modal = (script.Parent.Parent);

-- Modules
local Storage = require(Modal.Storage.Information);

-- Functions
local StorageScope = (Storage.Scope);

-- Init
local Animate = function(Goal: () -> (), Speed, Damping, NewScope)
	local Scope = (NewScope or StorageScope);
	local IsSpring = (typeof(Speed) == "number");
	local Computed = Scope:Computed(Goal);

	if (IsSpring) then
		return Scope:Spring(Computed, Speed, Damping);
	else
		return Scope:Tween(Computed, Speed);
	end
end

return Animate
