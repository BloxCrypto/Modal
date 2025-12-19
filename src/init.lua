-- Variables
local Self = (script);

-- Modules
local Window = require(Self.Components.Window);

-- Init
local Modal = ({});
Modal.__index = Modal

Modal.CreateWindow = function(self, Configuration)
	return Window(Configuration);
end

Modal.IsCorrectInput = function(self, Input: InputObject, Target: Enum.KeyCode | Enum.UserInputType)
	if (Input and Target) then
		local Name = Target.Name
		local KeyCode = Input.KeyCode.Name
		local InputType = Input.UserInputType.Name

		if (KeyCode == Name) or (InputType == Name) then
			return true
		else
			return false
		end
	else
		error("Missing input or target (Modal:IsCorrectInput())")
	end
end

return Modal