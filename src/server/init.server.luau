--!strict
-- Animasi NPC display. Cara pakai di Studio:
--   1. Kasih tag "AnimatedNPC" ke Model NPC (yang punya Humanoid).
--   2. Tambah attribute "AnimationId" (string) berisi ID animasinya, misal "140460858681908".
-- Animasi diputar looping di server, jadi kelihatan sama di semua client.

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimationController = require(ReplicatedStorage.Shared.AnimationController)

local TAG = "AnimatedNPC"
local ANIMATION_NAME = "showcase"

local controllers: { [Instance]: AnimationController.AnimationController } = {}

local function toAssetId(value: any): string?
	if typeof(value) == "number" then
		return `rbxassetid://{string.format("%.0f", value)}`
	elseif typeof(value) == "string" and value ~= "" then
		return if value:match("^%d+$") then `rbxassetid://{value}` else value
	end
	return nil
end

local function getAnimator(humanoid: Humanoid): Animator
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		return animator
	end

	local newAnimator = Instance.new("Animator")
	newAnimator.Parent = humanoid
	return newAnimator
end

local function setup(instance: Instance)
	if controllers[instance] or not instance:IsA("Model") then
		return
	end

	local animationId = toAssetId(instance:GetAttribute("AnimationId"))
	if not animationId then
		warn(`[AnimatedNPC] {instance:GetFullName()} belum punya attribute AnimationId`)
		return
	end

	local humanoid = instance:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		warn(`[AnimatedNPC] {instance:GetFullName()} tidak punya Humanoid`)
		return
	end

	local controller = AnimationController.new(getAnimator(humanoid), {
		[ANIMATION_NAME] = animationId,
	})
	local track = controller:track(ANIMATION_NAME)
	if track then
		track.Looped = true
	end
	controller:play(ANIMATION_NAME, 0)
	controllers[instance] = controller
end

local function cleanup(instance: Instance)
	local controller = controllers[instance]
	if controller then
		controller:destroy()
		controllers[instance] = nil
	end
end

CollectionService:GetInstanceAddedSignal(TAG):Connect(setup)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(cleanup)
for _, instance in CollectionService:GetTagged(TAG) do
	task.spawn(setup, instance)
end
