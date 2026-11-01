local cCom = game.ReplicatedStorage.CombatCom or game.ReplicatedStorage:WaitForChild("CombatCom")

cCom.OnServerEvent:Connect(function(plr, combatStats)
	local char = plr.Character
	local plrhumanoid = char.Humanoid or char:WaitForChild("Humanoid")
	local hitbox = Instance.new("Part")
	local range = combatStats.Range
	local rs = game:GetService("RunService")
	
	hitbox.Size = Vector3.new(range, range, range)
	hitbox.Transparency = 0
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.Parent = game.Workspace

	local alrhit = {}
	
	local dur = 0.5
	local tmin = os.time()
	
	local yo 
	yo = rs.Heartbeat:Connect(function()
		if os.time() - tmin >= dur then
			yo:Disconnect()
			hitbox:Destroy()
		else
			hitbox.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
			local hit = game.Workspace:GetPartsInPart(hitbox)
			
			--local alrhit = {}
			
			
			for _, thing in ipairs(hit) do
				local character = thing:FindFirstAncestorOfClass("Model")
				local humanoid = character and character:FindFirstChild("Humanoid")
				alrhit[plrhumanoid] = true
				
				if humanoid and not alrhit[humanoid] then
					alrhit[humanoid] = true
					print(humanoid)
					print(alrhit[humanoid])
					humanoid:TakeDamage(combatStats.DMG)
				end
			end
		end
	end)
	
	
	
	--[[hitbox.Touched:Connect(function(hit)
		
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= char and not table.find(alrhit, hit.Parent) then
			
			print(hit)
			print(plr)
			table.insert(alrhit, hit.Parent)
			hit.Parent.Humanoid:TakeDamage(combatStats.DMG)
			
		end
	end)
	
	
	task.wait(1)
	hitbox:Destroy()]]
end)