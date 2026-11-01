local combatTool = script.Parent
local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character.Humanoid or character:WaitforChild("Humanoid")
local Animator = humanoid:WaitForChild("Animator")

-- Loads the animator ^ for playing animations

local uis = game:GetService("UserInputService") --this thing handles user input stuff

local combatOn = false --This variable is for if combat is equipped or ON


combatTool.Equipped:Connect(function()
	combatOn = true
end)
combatTool.Unequipped:Connect(function()
	combatOn = false
end)
--Sets the combaton variable in regards to if combat is off or on

local combatStats = {
	atker = player, 
	DMG = 10,
	Range = 3,
	Cooldown = 1,
	AttackSpeed = 1
}

local cEvent = game.ReplicatedStorage.CombatCom or game.ReplicatedStorage:WaitForChild("CombatCom")

local m1 = Instance.new("Animation")
m1.AnimationId = "rbxassetid://80170787516083"
--Loads the m1 animation

local CD = false --Variable for Cooldown

uis.InputBegan:Connect(function(button)

	if button.UserInputType == Enum.UserInputType.MouseButton1 and combatOn and not CD then --if combat on and m1 pressed
		local loadm1 = humanoid:LoadAnimation(m1)
		loadm1:Play()
		task.wait(0.5)
		cEvent:FireServer(combatStats) 
		CD = true
		
		task.wait(1)
		CD = false
	end
	
end)