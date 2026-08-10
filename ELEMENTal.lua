-- dumped at https://discord.gg/Sps39CydcZ
local v106 = game:GetService("Players")
local v30 = {}
			function v277()
				local v157 = game:GetService("HttpService")
				local v205 = isfolder(v189)
					makefolder(v189)
				writefile(v189 .. "/" .. v196)
local v205 = v143()
local v30 = v205
				warn("v30 Saved!")
			function v143()
				local v313, v318 = pcall(function()
					local v304 = game:GetService("HttpService")
					local v307 = isfolder(v189)
						makefolder(v189)
					return v304:JSONDecode()
					return v304:JSONDecode
				if not v313 then
					do return v318 end
				v277()
				return v143()
				return v143
			local v58 = v143()
local v30 = v58
			function v107()
				local v305 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/library/main/FluentLibrary.lua"))
local v305 = v305()
				local v73 = v305:CreateWindow(460)
				local v63 = v305:CreateWindow(v305, {
local v181 = "Janina Hub | Elemental Dungeons ",
local v165 = v189,
local v169 = 160,
local v31 = v73,
local v1 = true,
local v34 = "Dark",
local v126 = Enum.KeyCode.LeftControl,
				local v79 = v63:AddTab({ v181 = "Dungeon", Icon = "swords" })
local v79 = v63:AddTab({ v181 = "Mastery", Icon = "star" })
local v79 = v63:AddTab({ v181 = "Lobby", Icon = "users" })
local v79 = v63:AddTab({ v181 = "Auto Sell", Icon = "dollar-sign" })
local v79 = v63:AddTab({ v181 = "Misc", Icon = "chevron-right" })
local v79 = v63:AddTab({ v181 = "Credits", Icon = "info" })
local v79 = v63:AddTab({ v181 = "UI v30", Icon = "settings" })
				print("Loading Script (2)")
local v79 = game:GetService("RunService")
				v73:AddParagraph({ v181 = "Enable 'Auto Load' in Misc Tab for automatic loading!" })
				if v30.AutoNextDungeon then
				local v320 = v73:AddToggle("AutoNextDungeon", { v181 = "Auto Next Difficulty", v63 = false })
				v320:OnChanged(function()
					v30.AutoNextDungeon = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if v30.AutoRetry ~= false then
								if v30.AutoRetry == nil then
							v228()
				coroutine.resume(coroutine.create(function()
							if not v30.AutoNextDungeon then
							if not v30.AutoRetry then
							v228()
				function v228()
					wait(5)
					if v30.AutoRetry ~= false then
						if v30.AutoRetry == nil then
						else
							local v107 = game:GetService("Players")
							if v107.LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
								wait(2)
								local v111 = game:GetService("Players")
local v111 = game:GetService("ReplicatedStorage")
								v111.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(v111.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby)
						local v126 = game:GetService("Players")
						local v132 = tonumber(string.match(v126.LocalPlayer.PlayerGui.Main.PlayerBar.LevelLabel.Text, "%d+"))
						if not v132 then
							if 0 <= v132 then
								if v132 <= 4 then
									local v136 = game:GetService("ReplicatedStorage")
									v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
								else
								else
									if 5 <= v132 then
										if v132 <= 14 then
local v136 = game:GetService("ReplicatedStorage")
											v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
										else
										else
											if 15 <= v132 then
												if v132 <= 34 then
local v136 = game:GetService("ReplicatedStorage")
													v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
												else
												else
													if 35 <= v132 then
														if v132 <= 44 then
local v136 = game:GetService("ReplicatedStorage")
															v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
														else
														else
															if 45 <= v132 then
																if v132 <= 54 then
local v136 = game:GetService("ReplicatedStorage")
																	v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																else
																else
																	if 55 <= v132 then
																		if v132 <= 74 then
local v136 = game:GetService("ReplicatedStorage")
																			v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																		else
																		else
																			if 75 <= v132 then
																				if v132 <= 84 then
local v136 = game:GetService("ReplicatedStorage")
																					v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																				else
																				else
																					if 85 <= v132 then
																						if v132 <= 94 then
local v136 = game:GetService("ReplicatedStorage")
																							v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																						else
																						else
																							if 95 <= v132 then
																								if v132 <= 104 then
local v136 = game:GetService("ReplicatedStorage")
																									v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																								else
																								else
																									if 105 <= v132 then
																										if v132 <= 119 then
local v136 = game:GetService("ReplicatedStorage")
																											v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																										else
																										else
																											if 120 <= v132 then
																												if v132 <= 129 then
local v136 = game:GetService("ReplicatedStorage")
																													v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																												else
																												else
																													if 130 <= v132 then
																														if v132 <= 139 then
local v136 = game:GetService("ReplicatedStorage")
																															v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																														else
																														else
																															if 140 <= v132 then
																																if v132 <= 149 then
local v136 = game:GetService("ReplicatedStorage")
																																	v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																																else
																																else
																																	if 150 <= v132 then
																																		if v132 <= 169 then
local v136 = game:GetService("ReplicatedStorage")
																																			v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																																		else
																																		else
																																			if 170 <= v132 then
																																				if v132 <= 184 then
local v136 = game:GetService("ReplicatedStorage")
																																					v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																																				else
																																				else
																																					if 185 <= v132 then
																																						if v132 <= 199 then
local v136 = game:GetService("ReplicatedStorage")
																																							v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																																						else
																																						else
																																							if 200 <= v132 then
local v136 = game:GetService("ReplicatedStorage")
																																								v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v136.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
																																							else
																																								print("Unknown level")
						wait()
						local v127 = game:GetService("Players")
						if not v127.LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start then
local v136 = getconnections(v127.LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start.Activated)
							local v143, v146, v152 = pairs(v136)
							else
								warn("Button not found")
				if v30.DungeonName then
				local v169 = v73:AddDropdown("DungeonName", { v181 = "Choose Dungeon", v36 = v165, Multi = false, v63 = "" })
				v169:OnChanged(function(v41)
					v30.DungeonName = v41
					v277()
				if v30.DungeonDifficulty then
				local v324 = v73:AddDropdown("DungeonDifficulty", { v181 = "Choose Difficulty", v36 = v34, Multi = false, v63 = "" })
				v324:OnChanged(function(v41)
					v30.DungeonDifficulty = v41
					v277()
				if v30.AutoStart then
				local v181 = v73:AddToggle("AutoStart", { v181 = "Auto Farm Selected Dungeon", v63 = false })
				v181:OnChanged(function()
					v30.AutoStart = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if v30.AutoRetry ~= false then
								if v30.AutoRetry == nil then
							if not v30.AutoStart then
							v46()
				function v46()
					wait(5)
					if v30.AutoRetry ~= false then
						if v30.AutoRetry == nil then
						else
							local v189 = game:GetService("Players")
							if v189.LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
								wait(2)
								local v196 = game:GetService("Players")
local v196 = game:GetService("ReplicatedStorage")
								v196.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(v196.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby)
						wait()
						local v206 = game:GetService("ReplicatedStorage")
						v206.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(v206.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty)
						wait()
local v206 = game:GetService("Players")
						if not v206.LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start then
							local v218 = getconnections(v206.LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start.Activated)
							local v222, v228, v233 = pairs(v218)
							else
								warn("Button not found")
				coroutine.resume(coroutine.create(function()
							if not v30.AutoRetry then
							if not v30.AutoStart then
							if v30.AutoNextDungeon then
							v46()
				if v30.AutoRetry then
				local v251 = v73:AddToggle("AutoRetry", { v181 = "Auto Retry", v63 = false })
				v251:OnChanged(function()
					v30.AutoRetry = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if game.PlaceId ~= 10515146389 then
local v257 = game:GetService("Players")
							if v257.LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
							wait(2)
							local v265 = game:GetService("ReplicatedStorage")
							v265.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.VoteOn:InvokeServer(v265.ReplicatedStorage.Packages.Knit.Services.PartyService.RF.VoteOn)
				if v30.AutoChallenge then
				local v165 = v73:AddToggle("AutoChallenge", { v181 = "Auto Challenge", v63 = false })
				v165:OnChanged(function()
					v30.AutoChallenge = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if game.PlaceId == 10515146389 then
local v277 = game:GetService("Players")
								local v286, v293, v294 = pairs(v54)
										for v66, v67 in v286, v293, v294 do
local v277 = game:GetService({ "BeginnersDungeon", "JungleDungeon", "ArcticBastionDungeon", "UnderwaterDungeon", "FireDungeon" })
								if v277.LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
								wait(2)
								local v305 = game:GetService("Players")
local v305 = game:GetService("ReplicatedStorage")
								v305.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(v305.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby)
				if v30.Nearest then
				local v306 = v34:AddToggle("AutoFarmMobNearest", { v181 = "Auto Dungeon Mobs (Teleport)", v63 = false })
				v306:OnChanged(function()
					v30.Nearest = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if game.PlaceId ~= 10515146389 then
							v307()
				if v30.FarmMethod then
				if v30.Tween then
				if v30.FarmStyle then
				function v307()
						if v30.AutoHide == true then
							v5()
						if not v30.v205 then
							v205()
						if not v30.AutoPickUp then
							v304()
						v157()
						v106()
						local v314 = function()
							if not v189 then
								local v308 = v189:FindFirstChild("HumanoidRootPart")
								if not v308 then
									if 0 < v189.Humanoid.Health then
										do return v189 end
							if game.Players.LocalPlayer.Character then
								do return nil end
								do return nil end
							local v309 = game:GetService("Workspace")
							local v311, v310, v312 = pairs(v309.Mobs:GetChildren())
								for v80, v78 in v311, v310, v312 do
								return v189
						end()
							local v315 = game:GetService("TweenService")
local v315 = v315:Create(v189, v84, { CFrame = v41 })
							v315:Play()
							v315.Completed:Connect(function() v189:Destroy() end)
						if not v314 then
							if not v82 then
								local v316 = v314:FindFirstChild("HumanoidRootPart")
								if not v316 then
									local v317 = v314:IsA("Model")
									if not v317 then
local v317 = v314:FindFirstChild("HumanoidRootPart")
										if not v317 then
											if 0 < v314.Humanoid.Health then
												if v39 == "Tween [Safer]" then
													if v206 == "Behind" then
														game.Players.LocalPlayer.Character(v314.HumanoidRootPart.CFrame * v317)
													else
														if v206 == "Above" then
															game.Players.LocalPlayer.Character(v314.HumanoidRootPart.CFrame * v317)
														else
															if v206 == "Under" then
																game.Players.LocalPlayer.Character(v314.HumanoidRootPart.CFrame * v317)
												if v39 == "Teleport" then
													if v206 == "Behind" then
														v82.CFrame = v314.HumanoidRootPart.CFrame * v317
														v82.CFrame = v88 * v89
													else
														if v206 == "Above" then
															v82.CFrame = v314.HumanoidRootPart.CFrame * v317
															v82.CFrame = v88 * v89
														else
															if v206 == "Under" then
																v82.CFrame = v314.HumanoidRootPart.CFrame * v317
																v82.CFrame = v88 * v89
				if v30.HitMobs then
				local v319 = v34:AddToggle("mouseclick", { v181 = "⚔️  Hit Mobs", v63 = false })
				v319:OnChanged(function()
					v30.HitMobs = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							v257()
				function v257()
						local v321 = game:GetService("Players")
						local v322 = workspace:FindFirstChild("Mobs")
						local v324, v323, v325 = pairs(v94:GetChildren())
							for v101, v99 in v324, v323, v325 do
local v324 = game:GetService("VirtualUser")
							v324:CaptureController()
							v324:ClickButton1(v324)
				local v60 = v34:AddDropdown("FarmStyleDropdown", { v181 = "Farm Style", v36 = v59, Multi = false, v63 = "Tween [Safer]" })
				v60:OnChanged(function(v41)
					v30.FarmStyle = v41
local v189 = v30.FarmStyle
					v277()
				local v320 = v34:AddDropdown("FarmMethodDropdown", { v181 = "Farm Method", v36 = v104, Multi = false, v63 = "Behind" })
				v320:OnChanged(function(v41)
					v30.FarmMethod = v41
					if v30.FarmMethod == "Behind [Best]" then
						v30.FarmMethod = "Behind"
local v189 = v30.FarmMethod
					v277()
				if v30.FarmDistance then
				local v61 = v34:AddSlider({ "Behind [Best]", "Above", "Under" }, {
local v181 = "Auto Farm Distance",
local v63 = 5,
local v22 = 0,
local v111 = 60,
local v146 = 0,
local v318 = function(v41)
					v30.FarmDistance = v41
					v277()
local v189 = v41
				end,
				local v59 = v34:AddSlider("FarmSpeedSlider", {
local v181 = "Farm Speed",
local v63 = 35,
local v22 = 10,
local v111 = 40,
local v146 = 0,
local v318 = function(v41)
					v30.Tween = v41
					v277()
local v189 = v30.Tween
				end,

				-- ============================================
				-- ADDED: AUTO HOLD R FEATURE
				-- ============================================
				if v30.AutoHoldR == nil then
					v30.AutoHoldR = false
				end
				if v30.HoldDuration == nil then
					v30.HoldDuration = 3
				end
				if v30.HoldCooldown == nil then
					v30.HoldCooldown = 5
				end

				local vHoldR = v34:AddToggle("AutoHoldR", { v181 = "✈️ Auto Hold R (Flight Damage)", v63 = false })
				vHoldR:OnChanged(function()
					v30.AutoHoldR = v189.Value
					v277()
					if v30.AutoHoldR then
						StartHoldRLoop()
					else
						HoldingR = false
					end
				end)

				local vHoldDur = v34:AddSlider("HoldDuration", {
					v181 = "Hold Duration (seconds)",
					v63 = 3,
					v22 = 1,
					v111 = 10,
					v146 = 0,
					v318 = function(v41)
						v30.HoldDuration = v41
						v277()
					end
				})

				local vHoldCD = v34:AddSlider("HoldCooldown", {
					v181 = "Cooldown Between Holds (seconds)",
					v63 = 5,
					v22 = 1,
					v111 = 30,
					v146 = 0,
					v318 = function(v41)
						v30.HoldCooldown = v41
						v277()
					end
				})

				-- Hold R Function
				function HoldKeyR(Duration)
					local VirtualInput = game:GetService("VirtualInputManager")
					local KeyCode = Enum.KeyCode.R
					
					VirtualInput:SendKeyEvent(true, KeyCode, false, game)
					
					local StartTime = tick()
					while tick() - StartTime < Duration do
						task.wait(0.05)
						VirtualInput:SendKeyEvent(true, KeyCode, false, game)
					end
					
					VirtualInput:SendKeyEvent(false, KeyCode, false, game)
				end

				-- Auto Hold R Loop
				local HoldingR = false

				function StartHoldRLoop()
					HoldingR = true
					coroutine.resume(coroutine.create(function()
						while HoldingR and v30.AutoHoldR do
							task.wait(0.5)
							
							if game.PlaceId == 10515146389 then
								task.wait(1)
							else
								local Character = game.Players.LocalPlayer.Character
								if Character then
									local Humanoid = Character:FindFirstChild("Humanoid")
									if Humanoid and Humanoid.Health > 0 then
										local Mobs = workspace:FindFirstChild("Mobs")
										local HasTarget = false
										
										if Mobs then
											local PlayerHRP = Character:FindFirstChild("HumanoidRootPart")
											if PlayerHRP then
												for _, Mob in pairs(Mobs:GetChildren()) do
													if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
														local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
														if MobHRP then
															local Distance = (PlayerHRP.Position - MobHRP.Position).Magnitude
															if Distance < 150 then
																HasTarget = true
																break
															end
														end
													end
												end
											end
										end
										
										if HasTarget then
											HoldKeyR(v30.HoldDuration)
											task.wait(v30.HoldCooldown)
										else
											task.wait(1)
										end
									else
										task.wait(2)
									end
								else
									task.wait(1)
								end
							end
						end
					end))
				end

				-- Add Hold R to the farm loop (modify v307 function)
				-- Find the existing v307 function and add this inside the loop after moving to mob:
				-- 
				-- if v30.AutoHoldR and HasTarget then
				--     HoldKeyR(v30.HoldDuration)
				--     task.wait(v30.HoldCooldown)
				-- end

				-- ============================================
				-- END OF ADDED FEATURE
				-- ============================================

				if v30.AutoPickUp then
				local v62 = v104:AddToggle("AutoPickUpLootToggle", { v181 = "⭐  Auto Pick Up Loot", v63 = false })
				v62:OnChanged(function()
					v30.AutoPickUp = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if v30.Nearest ~= false then
								if v30.Nearest == nil then
							v189.RenderStepped:wait()
							v304()
				if v30.IgnoreWhite then
				v109:OnChanged(function()
					v30.IgnoreWhite = v189.Value
					v277()
				if v30.IgnoreGreen then
				v108:OnChanged(function()
					v30.IgnoreGreen = v189.Value
					v277()
				if v30.IgnoreBlue then
				v110:OnChanged(function()
					v30.IgnoreBlue = v189.Value
					v277()
				function v304()
						if not game.Players.LocalPlayer.Character then
							if not v111 then
								local v64 = game:GetService("Players")
								local v65 = game:GetService("Workspace")
								local v66, v65, v67 = pairs(v65.Camera.Drops:GetChildren())
																						else
																							if v118 == 111 then
																								if v119 == 241 then
																									if v120 == 255 then
																										if v30.IgnoreBlue ~= nil then
																											if v30.IgnoreBlue == false then
																											else
																												print("pick up blue")
																												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v116.Center.CFrame
local v306 = tick()
																													else
																													else
																													else
																												else
																													if v118 == 255 then
																														if v119 == 240 then
																															if v120 == 246 then
																																if v30.IgnoreWhite ~= nil then
																																	if v30.IgnoreWhite == false then
																																	else
																																		print("pick up white")
																																		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v116.Center.CFrame
local v306 = tick()
																																		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v116.Center.CFrame
																																		v189.RenderStepped:wait()
																																		fireproximityprompt(v116.Center.ProximityPrompt)
local v70 = tick()
																																		if 5 > v70 - v306 then
																																			if not v116.Center.ProximityPrompt.Enabled then
																																			else
																																			else
																																			else
																																		else
																																			if v118 == 110 then
																																				if v119 == 255 then
																																					if v120 ~= 108 then
																																					else
																																					else
																																						if v118 == 111 then
																																							if v119 == 241 then
																																								if v120 ~= 255 then
																																								else
																																								else
																																									if v118 == 255 then
																																										if v119 == 240 then
																																											if v120 ~= 246 then
																																											else
																																											else
																																												if v118 == 255 then
																																													if v119 == 0 then
																																														if v120 ~= 0 then
																																														else
																																														else
																																															print("pick up other")
																																															game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v116.Center.CFrame
local v306 = tick()
												for v123, v116 in v66, v65, v67 do
				if v30.Healer then
				if v30.v205 then
				local v71 = v124:AddToggle("AutoHealToggle", { v181 = "❤️ Auto Heal (Pickup Potions & Use)", v63 = false })
				v71:OnChanged(function()
					v30.v205 = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if v30.Nearest ~= false then
								if v30.Nearest == nil then
							v205()
				function v205()
						local v308 = game:GetService("Players")
						if not game.Players.LocalPlayer.Character then
							if not v129 then
								local v309 = game:GetService("Players")
								local v310 = game:GetService("Workspace")
								local v311, v310, v312 = pairs(v310.Camera.Drops:GetChildren())
										for v137, v134 in v311, v310, v312 do
						if v138.Health / v138.MaxHealth < v189 * 0.01 then
							local v78 = game:GetService("Players")
							if not v78.LocalPlayer.PlayerGui.Main.PlayerBar.Main.PotionBar.Visible then
local v78 = game:GetService("ReplicatedStorage")
								v78.ReplicatedStorage.Packages.Knit.Services.HealingService.RF.UseHeal:InvokeServer()
				local v80 = v124:AddSlider("HealAtSlider", {
local v181 = "Heal When Hp Is Under (%)",
local v63 = 40,
local v22 = 10,
local v111 = 100,
local v146 = 0,
local v318 = function(v41)
					v30.Healer = v41
					v277()
local v189 = v41
				end,
				if v30.AutoElementalizeBlade then
				local v314 = v127:AddToggle("AutoElementalizeBladeToggle", { v181 = "Auto Elementalize Blade (Need to buy it first)", v63 = false })
				v314:OnChanged(function()
					v30.AutoElementalizeBlade = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
								local v82 = game:GetService("Players")
								local v83, v82, v84 = pairs(v82.LocalPlayer.Character:GetChildren())
									for v148, v146 in v83, v82, v84 do
				if v30.AutoUseSwordSkill then
				local v315 = v127:AddToggle("AutoUseSwordSkillToggle", { v181 = "Auto Use Sword Skill", v63 = false })
				v315:OnChanged(function()
					v30.AutoUseSwordSkill = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
								local v316 = game:GetService("Players")
								local v317 = workspace:FindFirstChild("Mobs")
								local v89, v88, v319 = pairs(v317:GetChildren())
													if not v316.LocalPlayer then
local v91 = game:GetService("ReplicatedStorage")
local v91 = game:GetService("ReplicatedStorage")
														v91:FireServer(v91)
local v321 = game:GetService("ReplicatedStorage")
local v321 = game:GetService("ReplicatedStorage")
														v321:FireServer(v321)
									for v163, v157 in v89, v88, v319 do
							task.wait(0.5)
				if v30.AutoDodgeSkill then
				local v94 = v149:AddToggle("AutoDodge1", { v181 = "Auto Dodge Boss Skill", v63 = false })
				v94:OnChanged(function()
					v30.AutoDodgeSkill = v189.Value
					v277()
				function v157()
								if not v165 then
									v165.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
									break
				coroutine.resume(coroutine.create(function()
						task.wait()
				if v30.AutoDodgeSkillRage then
				local v322 = v149:AddToggle("AutoDodge2", { v181 = "Auto Dodge Boss Rage", v63 = false })
				v322:OnChanged(function()
					v30.AutoDodgeSkillRage = v189.Value
					v277()
				function v106()
								if not v172 then
									v172.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
									break
				coroutine.resume(coroutine.create(function()
						task.wait()
				if v30.AutoHide then
				local v323 = v170:AddToggle("AutoHideToggle", { v181 = "Anti-Die (Only Use on Hardcore/Infinite Dungeons)", v63 = false })
				v323:OnChanged(function()
					v30.AutoHide = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
							if v30.Nearest ~= false then
								if v30.Nearest == nil then
							v5()
				if v30.HideLow then
				if v30.ShowUP then
				function v5()
						if not v30.AutoHide then
							if v180.Health / v180.MaxHealth < v189 * 0.01 then
								if v196 * 0.01 < v180.Health / v180.MaxHealth then
									if not true then
										v181.CFrame = v181.CFrame
				local v325 = v170:AddSlider("HideSlider", {
local v181 = "Hide At HP Lower Then (%)",
local v63 = 25,
local v22 = 1,
local v111 = 99,
local v146 = 0,
local v318 = function(v41)
					v30.HideLow = v41
					v277()
local v189 = v41
				end,
				local v99 = v170:AddSlider("HideShowSlider", {
local v181 = "Return to Auto Farm at (%)",
local v63 = 75,
local v22 = 1,
local v111 = 99,
local v146 = 0,
local v318 = function(v41)
					v30.ShowUP = v41
					v277()
local v189 = v41
				end,
				local v100 = v186:AddInput("Input", {
local v181 = "Reset At 'X' Wave",
local v63 = v30.Leaveatxwave,
local v136 = "Enter Wave Number",
local v132 = true,
local v320 = true,
local v318 = function(v41)
					v30.Leaveatxwave = v41
					v277()
				end,
				if v30.leaveatwave then
				local v101 = v186:AddToggle("autoleaveatxwavetoggle", { v181 = "Toggle Reset At 'X' Wave", v63 = false })
				v101:OnChanged(function()
					v30.leaveatwave = v189.Value
					v277()
				coroutine.resume(coroutine.create(function()
				v193:AddParagraph({ v181 = "Collect chests only work after dungeon is completed!" })
				v193:AddButton({
local v181 = "Collect Dungeon Chests",
local v318 = function()
						game.Workspace.CurrentCamera.CFrame = v196
						game.Workspace.CurrentCamera.FieldOfView = 80
						local v103 = game:GetService("Workspace")
						local v104, v103, v105 = pairs(v103:GetChildren())
							for v202, v200 in v104, v103, v105 do
				end,
				v193:AddButton({
local v181 = "Teleport to Chance Altar (If Available)",
local v318 = function()
						local v108 = game:GetService("Workspace")
						local v109, v108, v110 = pairs(v108:GetChildren())
									do return end
							for v209, v207 in v109, v108, v110 do
							v189:Notify({ v181 = "Chance Altar Is Not Available!", v58 = "", v73 = 4 })
				end,
				v193:AddButton({
local v181 = "Teleport to Inf Boss Altar (If Available)",
local v318 = function()
						local v112 = game:GetService("Workspace")
						local v113, v112, v114 = pairs(v112:GetChildren())
									do return end
							for v216, v214 in v113, v112, v114 do
							v189:Notify({ v181 = "Inf Boss Altar Is Not Available!", v58 = "", v73 = 4 })
				end,
				print("Loading Script (1)")
				local v115 = game:GetService("ReplicatedStorage")
local v115 = v115:WaitForChild("ReplicatedStorage")
local v115 = v115:WaitForChild("Packages")
				local v102 = require(v115:WaitForChild("Knit"))
local v102 = v102:GetReplica()
				local v116, v117, v118 = pairs(v102.Data.Main.EquippedItems.Elements)
					for v120, v119 in v116, v117, v118 do
					if v119 == nil then
						v15.mastery:AddParagraph({ v181 = "You don't have an element!" })
						v15.mastery:AddParagraph({ v181 = "Get an Element First and Rejoin/Re-execute" })
					if v119 ~= nil then
						if v30.Mastery then
						v116:OnChanged(function()
							v30.Mastery = v189.Value
							v277()
						coroutine.resume(coroutine.create(function()
									v313()
									task.wait(1)
						function v313()
								local v121 = game:GetService("Players")
								local v122 = workspace:FindFirstChild("Mobs")
								local v124, v123, v125 = pairs(v122:GetChildren())
											for v243, v229 in v124, v123, v125 do
local v118 = game:GetService("ReplicatedStorage")
						if not v118[1] then
							if not v119 then
								if v30["Skill" .. v118[1].Name] then
								v128:OnChanged(function()
									v30["Skill" .. v189] = v196.Value
									v277()
								coroutine.resume(coroutine.create(function()
												local v129 = game:GetService("Players")
												local v130 = workspace:FindFirstChild("Mobs")
												if not v129.LocalPlayer then
													if game.PlaceId ~= 10515146389 then
														local v133, v131, v134 = pairs(v130:GetChildren())
local v135 = game:GetService("ReplicatedStorage")
																				v135:FireServer(v135)
																for v260, v252 in v133, v131, v134 do
											task.wait(1)
						if not v118[2] then
							if not v119 then
								if v30["Skill" .. v118[2].Name] then
								v128:OnChanged(function()
									v30["Skill" .. v189] = v196.Value
									v277()
								coroutine.resume(coroutine.create(function()
												local v138 = game:GetService("Players")
												local v139 = workspace:FindFirstChild("Mobs")
												if not v138.LocalPlayer then
													if game.PlaceId ~= 10515146389 then
														local v141, v140, v142 = pairs(v139:GetChildren())
local v144 = game:GetService("ReplicatedStorage")
																				v144:FireServer(v144)
																for v277, v269 in v141, v140, v142 do
											task.wait(1)
						if not v118[3] then
							if not v119 then
								if v30["Skill" .. v118[3].Name] then
								v128:OnChanged(function()
									v30["Skill" .. v189] = v196.Value
									v277()
								coroutine.resume(coroutine.create(function()
												local v145 = game:GetService("Players")
												local v147 = workspace:FindFirstChild("Mobs")
												if not v145.LocalPlayer then
													if game.PlaceId ~= 10515146389 then
														local v149, v148, v150 = pairs(v147:GetChildren())
local v151 = game:GetService("ReplicatedStorage")
																				v151:FireServer(v151)
																for v293, v285 in v149, v148, v150 do
											task.wait(1)
						if not v118[4] then
							if not v119 then
								if v30["Skill" .. v118[4].Name] then
								v128:OnChanged(function()
									v30["Skill" .. v189] = v196.Value
									v277()
								coroutine.resume(coroutine.create(function()
												local v153 = game:GetService("Players")
												local v154 = workspace:FindFirstChild("Mobs")
												if not v153.LocalPlayer then
													if game.PlaceId ~= 10515146389 then
														local v156, v155, v158 = pairs(v154:GetChildren())
local v159 = game:GetService("ReplicatedStorage")
																				v159:FireServer(v159)
																for v309, v301 in v156, v155, v158 do
											task.wait(1)
						if not v118[5] then
							if not v119 then
								if v30["Skill" .. v118[5].Name] then
								v128:OnChanged(function()
									v30["Skill" .. v189] = v196.Value
									v277()
								coroutine.resume(coroutine.create(function()
												local v160 = game:GetService("Players")
												local v161 = workspace:FindFirstChild("Mobs")
												if not v160.LocalPlayer then
													if game.PlaceId ~= 10515146389 then
														local v163, v162, v164 = pairs(v161:GetChildren())
local v166 = game:GetService("ReplicatedStorage")
																				v166:FireServer(v166)
																for v325, v317 in v163, v162, v164 do
											task.wait(1)
						if not v118[6] then
							if not v119 then
								if v30["Skill" .. v118[6].Name] then
								v128:OnChanged(function()
									v30["Skill" .. v189] = v196.Value
									v277()
								coroutine.resume(coroutine.create(function()
												local v167 = game:GetService("Players")
												local v168 = workspace:FindFirstChild("Mobs")
												if not v167.LocalPlayer then
													if game.PlaceId ~= 10515146389 then
														local v171, v170, v172 = pairs(v168:GetChildren())
local v173 = game:GetService("ReplicatedStorage")
																				v173:FireServer(v173)
																for v341, v333 in v171, v170, v172 do
											task.wait(1)
					v116:AddButton({
local v181 = "Open Merchant UI",
local v318 = function()
							local v174 = game:GetService("Players")
							if game.PlaceId == 10515146389 then
								local v175 = game:GetService("Workspace")
local v175 = v175:FindFirstChild("NPCs")
local v175 = v175:FindFirstChild("MerchantNPC")
								if not v175 then
									v174.LocalPlayer.PlayerGui.Merchant.Main.Visible = true
								else
									v189:Notify({
local v181 = "Merchant NPC Not Found!",
local v58 = "Merchant not found, check back later!",
local v73 = 4,
								else
									v189:Notify({ v181 = "Only Works in Lobby!", v58 = "Wrong", v73 = 4 })
					end,
					v116:AddButton({
local v181 = "Open Scientist UI [Index]",
local v318 = function()
							local v176 = game:GetService("Players")
							if game.PlaceId == 10515146389 then
								local v177 = game:GetService("Workspace")
								if not v177 then
									v176.LocalPlayer.PlayerGui.Index.Main.Visible = true
					end,
					v116:AddButton({
local v181 = "Open Scientist UI [Advanced Tech Crafting]",
local v318 = function()
							local v178 = game:GetService("Players")
							if game.PlaceId == 10515146389 then
								local v179 = game:GetService("Workspace")
								if not v179 then
									v178.LocalPlayer.PlayerGui.ScientistCraftingUI.Main.Visible = true
					end,
					if v30.susvamp then
local v117 = v116:AddToggle("snipsustoggle", { v181 = "⛰️  Auto Buy/Store Orb From Sus Vampire", v63 = false })
					v117:OnChanged(function()
						v30.susvamp = v189.Value
						v277()
					function v54()
							local v180 = game:GetService("Players")
							local v182 = game:GetService("ReplicatedStorage")
local v182 = v182:WaitForChild("ReplicatedStorage")
local v182 = v182:WaitForChild("Packages")
local v182 = v182:WaitForChild("Knit")
local v182 = v182:WaitForChild("Services")
local v182 = v182:WaitForChild("MiscContentService")
local v182 = v182:WaitForChild("RF")
local v182 = v182:WaitForChild("BuyElementForGold")
							v182:InvokeServer(LocalPlayer)
							task.wait()
							local v182, v183, v184 = pairs(v349:GetChildren())
								for v356, v353 in v182, v183, v184 do
					coroutine.resume(coroutine.create(function()
								if game.PlaceId == 10515146389 then
								v54()
					if v30["USP"] then
local v120 = v118:AddToggle("UpgradeSwordPower", { v181 = "Auto Upgrade Sword Power", v63 = false })
					v120:OnChanged(function()
						v30.USP = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								wait()
								local v185 = game:GetService("ReplicatedStorage")
								v185.ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(v185.ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill)
					if v30["UEP"] then
local v119 = v118:AddToggle("UpgradeElementPower", { v181 = "Auto Upgrade Element Power", v63 = false })
					v119:OnChanged(function()
						v30.UEP = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								wait()
								local v186 = game:GetService("ReplicatedStorage")
								v186.ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(v186.ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill)
					if v30["UD"] then
local v128 = v118:AddToggle("UpgradeElementPower", { v181 = "Auto Upgrade Defense", v63 = false })
					v128:OnChanged(function()
						v30.UD = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								wait()
								local v187 = game:GetService("ReplicatedStorage")
								v187.ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(v187.ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill)
					if v30["Summon1"] then
					local v137 = v364:AddToggle("SummonElement1", { v181 = "Auto Summon Element (1)", v63 = false })
					v137:OnChanged(function()
						v30.Summon1 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
local v188 = game:GetService("ReplicatedStorage")
								v188.ReplicatedStorage.Packages.Knit.Services.SummoningService.RF.SummonOnce:InvokeServer()
					if v30["Summon2"] then
					local v190 = v364:AddToggle("SummonElement2", { v181 = "Auto Summon Element (3)", v63 = false })
					v190:OnChanged(function()
						v30.Summon2 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
local v191 = game:GetService("ReplicatedStorage")
								v191.ReplicatedStorage.Packages.Knit.Services.SummoningService.RF.SummonThree:InvokeServer()
					v369:AddButton({
local v181 = "Redeem All Codes",
local v318 = function()
						local v193, v194, v195 = pairs(v373)
					end,
					if v30["AFC"] then
					local v192 = v369:AddToggle("AutoFarmChest", { v181 = "Auto Farm Chest", v63 = false })
					v192:OnChanged(function()
						v30.AFC = v189.Value
						v277()
						_G.qweewe = false
					coroutine.resume(coroutine.create(function()
								if not v30.AFC then
									local v197 = v382:GetChildren()
									if #v197 ~= 0 then
										game.Workspace.CurrentCamera.CFrame = v385
										game.Workspace.CurrentCamera.FieldOfView = 80
										local v199, v198, v200 = pairs(v382:GetChildren())
											for v390, v389 in v199, v198, v200 do
								if not v30.AFC then
local v197 = v382:GetChildren()
								if _G.qweewe ~= false then
									if _G.qweewe == nil then
								_G.qweewe = true
								v189:Notify({ v181 = "No Chest Found!", v58 = "You have already collected all of them!", v73 = 4 })
					if v30["AFEC"] then
					local v201 = v369:AddToggle("AutoFarmEvilChest", { v181 = "Auto Farm Evil Chest", v63 = false })
					v201:OnChanged(function()
						v30.AFEC = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								if not v30.AFEC then
								if v189 then
								local v202 = game:GetService("Workspace")
								local v203, v202, v204 = pairs(v202.Map:GetChildren())
									if true then
local v189 = true
									v196:Notify({
local v181 = "No Evil Chest Found!",
local v58 = "You have already collected all of them!",
local v73 = 4,
					v369:AddParagraph({ v181 = "You can collect each chest just once per account!" })
					v15.autoselltab:AddParagraph({ v181 = "Only works in lobby! (Does not sell equipped/locked items)" })
					if v30["TpLobbySellItem"] then
					v402:OnChanged(function()
						v30.TpLobbySellItem = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								if game.PlaceId ~= 10515146389 then
local v208 = game:GetService("Players")
								if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "75 / 75 Items Stored" then
									if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "80 / 80 Items Stored" then
										if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "85 / 85 Items Stored" then
											if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "90 / 90 Items Stored" then
												if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "95 / 95 Items Stored" then
													if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "100 / 100 Items Stored" then
														if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "105 / 105 Items Stored" then
															if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "110 / 110 Items Stored" then
																if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "115 / 115 Items Stored" then
																	if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "120 / 120 Items Stored" then
																		if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "125 / 125 Items Stored" then
																			if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "130 / 130 Items Stored" then
																				if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "135 / 135 Items Stored" then
																					if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "140 / 140 Items Stored" then
																						if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text ~= "145 / 145 Items Stored" then
																							if v208.LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text == "150 / 150 Items Stored" then
								local v209 = game:GetService("Players")
local v209 = game:GetService("ReplicatedStorage")
								v209.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(v209.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby)
					local v210 = game:GetService("ReplicatedStorage")
local v210 = v210:WaitForChild("ReplicatedStorage")
local v210 = v210:WaitForChild("Packages")
					local v207 = require(v210:WaitForChild("Knit"))
local v207 = v207:GetReplica()
					function v17(v41, v47)
						local v211 = game:GetService("ReplicatedStorage")
						local v212 = require(v211.ReplicatedStorage.SharedModules.ArmorsModule)
						local v211, v213, v214 = pairs(v212)
									for v417, v418 in v217, v415, v416 do
								for v215, v216 in v211, v213, v214 do
local v213 = game:GetService("ReplicatedStorage")
local v211 = require(v213.ReplicatedStorage.SharedModules.WeaponsModule)
								local v213, v214, v215 = pairs(v211)
											for v418, v419 in v415, v416, v417 do
										for v216, v217 in v213, v214, v215 do
local v214 = game:GetService("ReplicatedStorage")
local v213 = require(v214.ReplicatedStorage.SharedModules.RelicsModule)
										local v214, v215, v216 = pairs(v213)
													for v419, v420 in v416, v417, v418 do
												for v217, v415 in v214, v215, v216 do
local v215 = game:GetService("ReplicatedStorage")
local v214 = require(v215.ReplicatedStorage.SharedModules.ElementsModule)
												local v215, v216, v217 = pairs(v214)
															for v420, v421 in v417, v418, v419 do
														for v415, v416 in v215, v216, v217 do
														return false
					function v152(v41, v47)
						if game.PlaceId == 10515146389 then
							local v219, v220, v221 = pairs(v189.Data.Main.Items[v41])
								for v425, v426 in v219, v220, v221 do
					if v30["SellWeapon1"] then
					local v223 = v210:AddToggle("SellWeapon1Toggle", { v181 = "⚔️  Sell Common Weapons", v63 = false })
					v223:OnChanged(function()
						v30.SellWeapon1 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Weapons", "Common")
					if v30["SellWeapon2"] then
					local v225 = v210:AddToggle("SellWeapon1Toggle", { v181 = "⚔️  Sell Uncommon Weapons", v63 = false })
					v225:OnChanged(function()
						v30.SellWeapon2 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Weapons", "Uncommon")
					if v30["SellWeapon3"] then
					local v224 = v210:AddToggle("SellWeapon3Toggle", { v181 = "⚔️  Sell Rare Weapons", v63 = false })
					v224:OnChanged(function()
						v30.SellWeapon3 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Weapons", "Rare")
					if v30["SellWeapon4"] then
					local v226 = v210:AddToggle("SellWeapon4Toggle", { v181 = "⚔️  Sell Epic Weapons ⚠️", v63 = false })
					v226:OnChanged(function()
						v30.SellWeapon4 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Weapons", "Epic")
					if v30["SellWeapon4"] then
					local v227 = v210:AddToggle("SellWeapon5Toggle", { v181 = "⚔️  Sell Legendary Weapons ⚠️", v63 = false })
					v227:OnChanged(function()
						v30.SellWeapon4 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Weapons", "Epic")
					if v30["SellArmor1"] then
					local v229 = v439:AddToggle("SellArmor1Toggle", { v181 = "⚙️  Sell Common Armors", v63 = false })
					v229:OnChanged(function()
						v30.SellArmor1 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Armors", "Common")
					if v30["SellArmor2"] then
					local v231 = v439:AddToggle("SellArmor2Toggle", { v181 = "⚙️  Sell Uncommon Armors", v63 = false })
					v231:OnChanged(function()
						v30.SellArmor2 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Armors", "Uncommon")
					if v30["SellArmor3"] then
					local v230 = v439:AddToggle("SellArmor3Toggle", { v181 = "⚙️  Sell Rare Armors", v63 = false })
					v230:OnChanged(function()
						v30.SellArmor3 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Armors", "Rare")
					if v30["SellArmor4"] then
					local v232 = v439:AddToggle("SellArmor4Toggle", { v181 = "⚙️  Sell Epic Armors ⚠️", v63 = false })
					v232:OnChanged(function()
						v30.SellArmor4 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Armors", "Epic")
					if v30["SellRelic1"] then
					local v234 = v448:AddToggle("SellRelic1Toggle", { v181 = "⚜️  Sell Common Relics", v63 = false })
					v234:OnChanged(function()
						v30.SellRelic1 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Relics", "Common")
					if v30["SellRelic2"] then
					local v236 = v448:AddToggle("SellRelic2Toggle", { v181 = "⚜️  Sell Uncommon Relics", v63 = false })
					v236:OnChanged(function()
						v30.SellRelic2 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Relics", "Uncommon")
					if v30["SellRelic3"] then
					local v235 = v448:AddToggle("SellRelic3Toggle", { v181 = "⚜️  Sell Rare Relics", v63 = false })
					v235:OnChanged(function()
						v30.SellRelic3 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Relics", "Rare")
					if v30["SellOrb1"] then
					local v237 = v455:AddToggle("SellOrb1Toggle", { v181 = "⛰️  Sell Rare Elements", v63 = false })
					v237:OnChanged(function()
						v30.SellOrb1 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Orbs", "Rare")
					if v30["SellOrb2"] then
					local v238 = v455:AddToggle("SellOrb2Toggle", { v181 = "⛰️  Sell Epic Elements ⚠️", v63 = false })
					v238:OnChanged(function()
						v30.SellOrb2 = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
								v152("Orbs", "Epic")
					function v222()
						queue_on_teleport("repeat task.wait() until game:IsLoaded() print('aaaaaaaaaaaaaaaaaaaaa') task.wait(2) loadstring(game:HttpGet('https://raw.githubusercontent.com/xpa1n/Scripts/main/ElementalDungeons.lua'))()")
					coroutine.resume(coroutine.create(function()
						if not v30.autoload then
							v222()
					if v30["autoload"] then
					local v239 = v459:AddToggle("autoloadscripttoggle", { v181 = "Auto Load Script", v63 = false })
					v239:OnChanged(function()
						v30.autoload = v189.Value
						v277()
						if not v30.autoload then
							v222()
					function v233()
							local v241 = game:GetService("Players")
							local v242 = game:GetService("TeleportService")
							game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:connect(function(v41)
								if v41.Name == "ErrorPrompt" then
					coroutine.resume(coroutine.create(function()
						if not v30.autorejoinifkicked then
							v233()
					if v30["autorejoinifkicked"] then
					local v240 = v459:AddToggle("autojoinifkicked", { v181 = "Auto Rejoin If Kicked", v63 = false })
					v240:OnChanged(function()
						v30.autorejoinifkicked = v189.Value
						v277()
						if not v30.autorejoinifkicked then
							v233()
					function v218()
							local v244 = game:GetService("VirtualUser")
							local v245 = game:GetService("Players")
							v245.LocalPlayer.Idled:connect(function()
								local v246 = v189:Button2Down(0)
								v189:Button2Down(v189, v246, workspace.CurrentCamera.CFrame)
								wait(1)
local v246 = v189:Button2Up(0)
								v189:Button2Up(v189, v246, workspace.CurrentCamera.CFrame)
					coroutine.resume(coroutine.create(function()
						if not v30.antiafkk then
							v218()
					if v30["antiafkk"] then
					local v243 = v459:AddToggle("antiafktoggle", { v181 = "Anti-AFK", v63 = false })
					v243:OnChanged(function()
						v30.antiafkk = v189.Value
						v277()
						if not v30.antiafkk then
							v218()
					if v30["fly"] then
					local v247 = v470:AddToggle("flytoggle", { v181 = "Fly (Press 'X' to Toggle)", v63 = false })
					v247:OnChanged(function()
						v30.fly = v189.Value
						v277()
					coroutine.resume(coroutine.create(function()
							v305()
					function v15()
						if not v189 then
							do return end
local v189 = true
						local v249 = workspace:FindFirstChild("Core")
						if not v249 then
							workspace.Core:Destroy()
						v249.Name = "Core"
						v249.v31 = v476
						spawn(function()
							v189.Parent = workspace
							v477.Part0 = v189
							v477.Part1 = v196.Character.LowerTorso
							v477.C0 = v478
						workspace:WaitForChild("Core")
						function v286()
							v479.Name = "EPIXPOS"
							v479.MaxForce = v481
							v479.Position = v189.Position
							v480.MaxTorque = v481
							v480.CFrame = v189.CFrame
								if not v39.w then
local v206 = v206 + 0
								if not v39.s then
local v206 = v206 + 0
								if not v39.d then
local v206 = v206 + 0
								if not v39.v41 then
local v206 = v206 + 0
								if 10 < v206 then
local v206 = 5
								v479.Position = (((v480.CFrame - v480.CFrame.Position + v479.Position + workspace.CurrentCamera.CFrame.LookVector * v206 - workspace.CurrentCamera.CFrame.LookVector * v206) * v482) * v482).Position
								if not v39.w then
									v480.CFrame = workspace.CurrentCamera.CFrame * v484
								else
									if not v39.s then
										v480.CFrame = workspace.CurrentCamera.CFrame * v484
									else
										v480.CFrame = workspace.CurrentCamera.CFrame
								if _u4 then
								if not v480 then
									v480:Destroy()
								if not v479 then
									v479:Destroy()
								v196.Character.Humanoid.PlatformStand = false
local v206 = 10
							if not v189 then
								if v189.Parent then
								else
									do return end
							if v41 == "w" then
								v196.w = true
							else
								if v41 == "s" then
									v196.s = true
								else
									if v41 == "v41" then
										v196.v41 = true
									else
										if v41 == "d" then
											v196.d = true
										else
											if v41 == "x" then
local v39 = not v39
												if not v39 then
													v286()
							if v41 == "w" then
								v189.w = false
							else
								if v41 == "s" then
									v189.s = false
								else
									if v41 == "v41" then
										v189.v41 = false
									else
										if v41 == "d" then
											v189.d = false
					function v305()
						if v189 then
							do return end
local v189 = false
						if not e1 then
							e1:Disconnect()
						if not e2 then
							e2:Disconnect()
						if not workspace.Core then
							workspace.Core:Destroy()
						game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
local v196 = false
					if v30["WalkSpeed"] then
					local v248 = v470:AddSlider("WalkSpeed", {
local v181 = "Walk Speed",
local v63 = 30,
local v22 = 30,
local v111 = 200,
local v146 = 0,
local v318 = function(v41)
						v30.WalkSpeed = v41
						v277()
local v189 = v41
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v30.WalkSpeed
					end,
					coroutine.resume(coroutine.create(function()
								game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v189
					if v30["Jumppower"] then
					local v250 = v470:AddSlider("JumpxPower", {
local v181 = "Jump Power",
local v63 = 30,
local v22 = 50,
local v111 = 200,
local v146 = 0,
local v318 = function(v41)
						v30.Jumppower = v41
						v277()
local v189 = v41
						game.Players.LocalPlayer.Character.Humanoid.JumpPower = v30.Jumppower
					end,
					coroutine.resume(coroutine.create(function()
								game.Players.LocalPlayer.Character.Humanoid.JumpPower = v189
					if v30["infinjump"] then
					local v253 = v470:AddToggle("InfiniteJump", { v181 = "Infinite Jump", v63 = false })
					v253:OnChanged(function()
						v30.infinjump = v189.Value
						v277()
					function v324()
							if _G.infinJumpStarted == nil then
								_G.infinJumpStarted = true
								local v254 = game:GetService("Players")
								v493.KeyDown:connect(function(v41)
									if not v30.infinjump then
										local v255 = v41:byte()
										if v255 == 32 then
local v255 = game:GetService("Players")
local v265 = v255
											v265:ChangeState("Jumping")
											wait()
											v265:ChangeState("Seated")
					v324()
					function v79()
							if not v41.Character then
								local v256 = v41.Character:FindFirstChild("HumanoidRootPart")
								if not v256 then
									v497.Parent = v256
									v497.AlwaysOnTop = true
									v497.v31 = v499
									v497.StudsOffset = v499
									v498.Parent = v497
									v498.BackgroundColor3 = v499
									v498.BackgroundTransparency = 1
									v498.v31 = v499
									v498.Text = v41.Name
									v498.TextColor3 = v499
									v498.TextScaled = true
							if not v41.Character then
								local v258 = v41.Character:FindFirstChild("HumanoidRootPart")
								if not v258 then
									local v259 = v258:FindFirstChildOfClass("BillboardGui")
									if not v259 then
										v259:Destroy()
						local v261, v260, v262 = ipairs(game.Players:GetPlayers())
							for v507, v506 in v261, v260, v262 do
					v79()
					if v30["plrESP"] then
					local v252 = v470:AddToggle("ESPPlayers", { v181 = "ESP Players", v63 = false })
					v252:OnChanged(function()
						v30.plrESP = v189.Value
						v277()
						v79()
					v470:AddButton({
local v181 = "Rejoin",
local v318 = function()
							warn("Rejoinning....")
local v263 = game:GetService("TeleportService")
							v263:Teleport(game.PlaceId, game.Players.LocalPlayer)
					end,
					v470:AddButton({
local v181 = "Server Hop",
local v318 = function()
						local v264 = game:GetService("HttpService")
						local v266 = game:GetService("TeleportService")
						function v19(v41)
							if not v41 then
								if "&cursor=" .. v41 then
								else
							local v267 = game:HttpGet(v189 .. "")
							return v196:JSONDecode(v196, v267)
							return v196:JSONDecode
								if v512.nextPageCursor then
					end,
					v470:AddButton({
local v181 = "Join Lowest Server",
local v318 = function()
						local v268 = game:GetService("HttpService")
						local v269 = game:GetService("TeleportService")
						function v19(v41)
							if not v41 then
								if "&cursor=" .. v41 then
								else
							local v270 = game:HttpGet(v189 .. "")
							return v196:JSONDecode(v196, v270)
							return v196:JSONDecode
							v269:TeleportToPlaceInstance(game.PlaceId, v520.data[1].id, game.Players.LocalPlayer)
					end,
					coroutine.resume(coroutine.create(function()
local v271 = game:GetService("ReplicatedStorage")
								v271.ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.StartDungeon:InvokeServer()
								wait(20)
					v15.credits:AddParagraph({
local v181 = "Script is made by pa1n#8015",
						["v58"] = "Thanks v41 lot to ArponAG & MSDOS for help with some features!",
					v523:AddButton({
local v181 = "Join Discord!",
local v318 = function()
						if not syn then
							if syn.request then
							else
								if not http then
									if http.request then
									else
						local v273 = game:GetService("HttpService")
						if not http_request then
							local v275 = v273:GenerateGUID(false)
							local v274 = v273:JSONEncode(v273, { cmd = "INVITE_BROWSER", nonce = v275, args = v275 })
							http_request({ Url = "http://127.0.0.1:6463/rpc?v=1", Method = "POST", Headers = v274, Body = v274 })
					end,
					local v272 = v523:AddInput("Input", {
local v181 = "or",
local v63 = "",
local v136 = "",
local v132 = false,
local v320 = false,
local v318 = function(v41) print(v41) end,
					v523:AddParagraph({ v181 = "Join discord to request new features and report bugs!" })
					v527:AddParagraph({ v181 = "Adding more features soon ;)" })
local v189 = true
						if not v196 then
							local v278, v276, v279 = pairs(v196:GetChildren())
								for v534, v532 in v278, v276, v279 do
local v189 = false
						if not v196 then
							local v281, v280, v282 = pairs(v196:GetChildren())
								for v541, v539 in v281, v280, v282 do
					coroutine.resume(coroutine.create(function()
										wait(1)
					coroutine.resume(coroutine.create(function()
								if game.PlaceId ~= 10515146389 then
									if v30.FarmStyle == "Tween [Safer]" then
										localCharacter = game.Players.LocalPlayer.Character
										local v284 = localCharacter:WaitForChild("HumanoidRootPart")
										v284.Velocity = v547
					coroutine.resume(coroutine.create(function()
							if not Workspace.Map.FireDungeon then
								wait(2)
								Workspace.Map.FireDungeon.Floor:Destroy()
								Workspace.Map.FireDungeon.BaseFloor:Destroy()
							else
								print("othergaymap")
					if v30.v34 then
					v30.v34 = "Darker"
					if v30["MenuKeybind"] then
					v30["MenuKeybind"] = "K"
					local v283 = v548:AddDropdown("InterfaceTheme", {
local v181 = "v34",
						["Description"] = "Changes the interface theme.",
local v36 = v305["Themes"],
local v63 = v30.v34,
local v318 = function(v41)
						v189:SetTheme(v41)
						v30.v34 = v41
						v277()
					end,
					v283["SetValue"](v30.v34)
					if v30.v1 then
					local v285 = v548:AddToggle("AcrylicToggle", {
local v181 = "v1",
						["Description"] = "The blurred background requires graphic quality 8+",
local v63 = false,
					v285:OnChanged(function()
						v30.v1 = v189.Value
						v277()
						v196:ToggleAcrylic(v30.v1)
					v305["ToggleAcrylic"](v30.v1)
					if v30["Transparency"] then
					local v287 = v548:AddToggle("TransparentToggle", { v181 = "Transparency", ["Description"] = "Makes the interface transparent.", v63 = false })
					v287:OnChanged(function()
						v30.Transparency = v189.Value
						v277()
						v196:ToggleTransparency(v30.Transparency)
					v551:OnChanged(function()
						v30.MenuKeybind = v189.Value
						v277()
					v305["MinimizeKeybind"] = v551
					v305["Notify"]({ v181 = "Janina Hub", ["v58"] = "The script has been loaded.", ["v73"] = 4 })
					v63["SelectTab"](1)
					print("Script Loaded!")
local v58 = game:HttpGet("https://rbxscripts.net/janinahub/opensourcekey")
			function v127()
				local v288 = game:GetService("UserInputService")
				function v251(v41)
						local v289 = game:GetService("TweenService")
						local v290 = v289:Create()
local v289 = v289:Create(v289, v196, v290, { Position = v554 })
						v289:Play()
					v41.InputBegan:Connect(function(v41)
						if v41.UserInputType ~= Enum.UserInputType.MouseButton1 then
							if v41.UserInputType == Enum.UserInputType.Touch then
							else
								local v291 = v189:GetFocusedTextBox()
								if v291 == nil then
local v196 = true
local v39 = v41.Position
local v293 = v206.Position
									v41.Changed:Connect(function()
										if v189.UserInputState == Enum.UserInputState.End then
local v196 = false
					v41.InputChanged:Connect(function(v41)
						if v41.UserInputType ~= Enum.UserInputType.MouseMovement then
							if v41.UserInputType == Enum.UserInputType.Touch then
							else
local v189 = v41
					local v292 = game:GetService("UserInputService")
					v292.InputChanged:Connect(function(v41)
						if v41 == v189 then
							if not v196 then
								v39(v41)
				v559.Parent = v295
				v559.IgnoreGuiInset = true
				v559.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				v559.Name = "JaninaHubKeyUI"
				v560.Name = "Container"
				v560.Parent = v559
				v560.BackgroundColor3 = v295
				v560.BorderColor3 = v295
				v560.v31 = v295
				v560.Position = v295
				v251(v560)
				v561.CornerRadius = v295
				v561.Parent = v560
				v562.Name = "Main"
				v562.Parent = v560
				v562.BackgroundColor3 = v295
				v562.BackgroundTransparency = 1
				v562.BorderColor3 = v295
				v562.BorderSizePixel = 0
				v562.v31 = v295
				v563.Parent = v562
				v563.BackgroundColor3 = v295
				v563.BackgroundTransparency = 1
				v563.BorderColor3 = v295
				v563.BorderSizePixel = 0
				v563.v31 = v295
				v563.Font = Enum.Font.SourceSans
				v563.Text = "Status : Waiting For Key..."
				v563.TextColor3 = v295
				v563.TextSize = 20
				v563.Name = "Status"
				v564.Parent = v562
				v564.BackgroundColor3 = v295
				v564.BorderColor3 = v295
				v564.BorderSizePixel = 0
				v564.Position = v295
				v564.v31 = v295
				v564.Font = Enum.Font.SourceSans
				v564.Text = "Get Key"
				v564.TextColor3 = v295
				v564.TextSize = 17
				v564.Name = "CopyKeybtn"
				v565.CornerRadius = v295
				v565.Parent = v564
				v566.Parent = v562
				v566.BackgroundColor3 = v295
				v566.BorderColor3 = v295
				v566.BorderSizePixel = 0
				v566.Position = v295
				v566.v31 = v295
				v566.Font = Enum.Font.SourceSans
				v566.Text = "Check Key"
				v566.TextColor3 = v295
				v566.TextSize = 17
				v566.Name = "KeyChecker"
				v567.CornerRadius = v295
				v567.Parent = v566
				v568.Parent = v562
				v568.BackgroundColor3 = v295
				v568.BorderColor3 = v295
				v568.BorderSizePixel = 0
				v568.Position = v295
				v568.v31 = v295
				v568.Font = Enum.Font.SourceSans
				v568.Text = "Join Discord"
				v568.TextColor3 = v295
				v568.TextSize = 17
				v568.Name = "JoinDiscord"
				v569.CornerRadius = v295
				v569.Parent = v568
				v570.Parent = v562
				v570.BackgroundColor3 = v295
				v570.BorderColor3 = v295
				v570.BorderSizePixel = 0
				v570.Position = v295
				v570.v31 = v295
				v570.Font = Enum.Font.SourceSans
				v570.PlaceholderColor3 = v295
				v570.PlaceholderText = "Enter Your Key Here"
				v570.Text = ""
				v570.TextColor3 = v295
				v570.TextSize = 17
				v570.TextStrokeColor3 = v295
				v570.Name = "KeyBox"
				v571.CornerRadius = v295
				v571.Parent = v570
				v572.Name = "Topbar"
				v572.Parent = v560
				v572.BackgroundColor3 = v295
				v572.BorderColor3 = v295
				v572.BorderSizePixel = 0
				v572.v31 = v295
				v573.CornerRadius = v295
				v573.Parent = v572
				v574.Parent = v572
				v574.BackgroundColor3 = v295
				v574.BorderColor3 = v295
				v574.BorderSizePixel = 0
				v574.Position = v295
				v574.v31 = v295
				v574.Font = Enum.Font.Unknown
				v574.Text = "X"
				v574.TextColor3 = v295
				v574.TextSize = 10
				v574.Name = "CloseButton"
				v575.CornerRadius = v295
				v575.Parent = v574
				v576.Parent = v572
				v576.BackgroundColor3 = v295
				v576.BackgroundTransparency = 1
				v576.BorderColor3 = v295
				v576.BorderSizePixel = 0
				v576.Position = v295
				v576.v31 = v295
				v576.Font = Enum.Font.SourceSansBold
				v576.Text = "Key System"
				v576.TextColor3 = v295
				v576.TextSize = 22
				v577.Parent = v572
				v577.BackgroundColor3 = v295
				v577.BackgroundTransparency = 1
				v577.BorderColor3 = v295
				v577.BorderSizePixel = 0
				v577.v31 = v295
				v577.Font = Enum.Font.SciFi
				v577.Text = "Janina Hub —"
				v577.TextColor3 = v295
				v577.TextSize = 17
				v578.Parent = v572
				v578.BackgroundColor3 = v295
				v578.BackgroundTransparency = 1
				v578.BorderColor3 = v295
				v578.BorderSizePixel = 0
				v578.Position = v295
				v578.v31 = v295
				v578.Image = "rbxassetid://14943357678"
				v579.Name = "Bottom"
				v579.Parent = v560
				v579.BackgroundColor3 = v295
				v579.BackgroundTransparency = 1
				v579.BorderColor3 = v295
				v579.BorderSizePixel = 0
				v579.Position = v295
				v579.v31 = v295
				v580.Parent = v579
				v580.BackgroundColor3 = v295
				v580.BackgroundTransparency = 1
				v580.BorderColor3 = v295
				v580.BorderSizePixel = 0
				v580.v31 = v295
				v580.Font = Enum.Font.Arial
				v580.Text = "If you can't copy: "
				v580.TextColor3 = v295
				v580.TextSize = 11
				v580.Position = v295
local v295 = v562:FindFirstChild("Status")
				local v296 = v572:FindFirstChild("CloseButton")
				local v297 = v562:FindFirstChild("JoinDiscord")
				local v298 = v562:FindFirstChild("CopyKeybtn")
				local v299 = v562:FindFirstChild("KeyChecker")
				local v300 = v562:FindFirstChild("KeyBox")
				v296.MouseButton1Click:Connect(function() v189:Destroy() end)
				v297.MouseButton1Click:Connect(function()
					setclipboard(tostring("https://"))
					v189.Text = "Copied Discord Invite"
					task.wait(0.6)
					v189.Text = "Join Discord"
				v298.MouseButton1Click:Connect(function()
					setclipboard(tostring("https://rbxscripts.net/janinahub/key"))
					v189.Text = "Copied Key Link"
					task.wait(0.6)
					v189.Text = "Get Key"
				v299.MouseButton1Click:Connect(function()
					warn("Verifying key...")
					warn("Verifying key...")
					task.wait()
					if v189.Text == v196 then
						v30.Key = v189.Text
						v277()
						v39.Text = "Status: Checking Key..."
						task.wait(1)
						v39.Text = "Status: Key is Correct!"
						task.wait(1)
						v39.Text = "Status: Loading GUI!"
						task.wait(1)
						v206:Destroy()
						v107()
					else
						v39.Text = "Status: Checking Key..."
						task.wait(1)
						v39.Text = "Status: Invalid Key :("
						task.wait(1)
						v39.Text = "Status: Please get v41 real key..."
						task.wait(1)
						v39.Text = "Status: Waiting for key..."
local v294 = "BqxIFdTrNO"
			function v52()
				if v294 == v189 then
					if game.PlaceId == 10515146389 then
						v107()
					else
						if game.PlaceId ~= 10515146389 then
								v107()
							else
								v127()
			function v48()
				if _G.LastOpenTime then
					do return true end
				local v301 = tick()
				if v189 <= v301 - _G.LastOpenTime then
					do return true end
				return false
			local v302 = game:GetService("CoreGui")
local v302 = v302:FindFirstChild("ScreenGui")
			if not v302 then
				print("Script Already Running!")
			else
local v302 = game:GetService("CoreGui")
local v302 = v302:FindFirstChild("ScreenGui")
local v302 = v48()
					if not v302 then
									local v303 = tick()
									_G.LastOpenTime = v303
									v52()