--!strict
-- LocalScript bernama "Animate" di StarterCharacterScripts otomatis menggantikan
-- script Animate bawaan Roblox, jadi nggak perlu destroy script default.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local AnimationController = require(Shared:WaitForChild("AnimationController"))
local AnimationConfig = require(Shared:WaitForChild("AnimationConfig"))

local character = script.Parent
local humanoid = character:WaitForChild("Humanoid") :: Humanoid
local animator = humanoid:WaitForChild("Animator") :: Animator

local controller = AnimationController.new(animator, AnimationConfig.Locomotion)
local fade = AnimationConfig.FadeTime
local baseSpeed = AnimationConfig.BaseSpeed

local function isAirborne(): boolean
	local state = humanoid:GetState()
	return state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall
end

local function onRunning(speed: number)
	-- Running juga ke-trigger pas di udara, jangan timpa animasi jump/fall.
	if isAirborne() then
		return
	end

	if speed < AnimationConfig.IdleThreshold then
		controller:play("idle", fade)
	elseif speed < AnimationConfig.RunThreshold then
		controller:play("walk", fade, speed / baseSpeed.walk)
	else
		controller:play("run", fade, speed / baseSpeed.run)
	end
end

humanoid.Running:Connect(onRunning)

humanoid.Jumping:Connect(function(active: boolean)
	if active then
		controller:play("jump", 0.1)
	end
end)

humanoid.FreeFalling:Connect(function(active: boolean)
	if active then
		controller:play("fall", fade)
	end
end)

humanoid.Climbing:Connect(function(speed: number)
	controller:play("climb", 0.1, speed / baseSpeed.climb)
end)

humanoid.Died:Connect(function()
	controller:destroy()
end)

controller:play("idle", 0)
