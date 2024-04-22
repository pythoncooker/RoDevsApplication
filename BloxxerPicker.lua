--Constants
local ServerStorage = game:GetService("ServerStorage")
local CollectibleAssets = ServerStorage:WaitForChild("CollectibleAssets")
local Bloxxer = CollectibleAssets:WaitForChild("Bloxxer")
local RigFolder = Bloxxer:WaitForChild("Rig")
local Rig = RigFolder:WaitForChild("Dummy")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFolder = ReplicatedStorage:WaitForChild("Events")
local DataEventServer = RemoteFolder:WaitForChild("BloxxerDataEventServer")
local DataEventClient = RemoteFolder:WaitForChild("BloxxerDataEventClient")

--Variables

local hatloottable = require(game.ServerStorage.CollectibleAssets.Bloxxer:WaitForChild("HatLootTable"))
local hats = game.ServerStorage.CollectibleAssets.Bloxxer.Hats

local neckloottable = require(game.ServerStorage.CollectibleAssets.Bloxxer:WaitForChild("NeckLootTable"))
local neckaccessories = game.ServerStorage.CollectibleAssets.Bloxxer.NeckAccessories

local hairloottable = require(game.ServerStorage.CollectibleAssets.Bloxxer:WaitForChild("HairLootTable"))
local hairs = game.ServerStorage.CollectibleAssets.Bloxxer.Hairs

local faceloottable = require(game.ServerStorage.CollectibleAssets.Bloxxer:WaitForChild("FaceLootTable"))
local faces = game.ServerStorage.CollectibleAssets.Bloxxer.Faces

local shirtsloottable = require(game.ServerStorage.CollectibleAssets.Bloxxer:WaitForChild("ShirtLootTable"))
local shirts = game.ServerStorage.CollectibleAssets.Bloxxer.Shirts

local pantsloottable = require(game.ServerStorage.CollectibleAssets.Bloxxer:WaitForChild("PantLootTable"))
local pants = game.ServerStorage.CollectibleAssets.Bloxxer.Pants

local itemPercentage = {
	Hats = {
		["Dominus Empyreus"] = 1,
		["Dominus Frigidus"] = 2,
		["Domino Crown"] = 3,
		["Duke of the Federation"] = 3, 
		["Lord of the Federation"] = 4, 
		["Eccentric Shop Teacher"] = 5, 
		["Black Sparkle Time Fedora"] = 7, 
		["Emerald Valkyrie"] = 8, 
		["Rbadam's Smokestack Top Hat"] = 10, 
		["Sparkle Time Fedora"] = 13, 
		["Fiery Horns of the Netherworld"] = 15, 
		["Frozen Horns of the Frigid Planes"] = 20,
		["Classic Fedora"] = 20,
		["Valkyrie Helm"] = 20, 
	},
	Hairs = {
		["Rainbow Shaggy"] = 1,
		["Fuchsia Fantastique"] = 9,
		["Peanutbutter Sparkle TimeHair"] = 30,
		["Purple Shaggy"] = 60,
	},
	NeckAccessories = {
		["Bling $$ Necklace"] = 1,
		["Bluesteel Bling $$ Necklace"] = 2,
		["Disgraced Starstone of the Federation"] = 40,
		["None"] = 60,
	},
	Faces1 = {
		["Red Tango"] = 1,
		["Red Glowing Eyes"] = 3,
		["Green Glowing Eyes"] = 4,
		["Eyes of Azurewrath"] = 7,
		["Eyes of Crimsonwrath"] = 10,
		["Yum!"] = 10,
		["Tattletale"] = 15,
		["Eyes of Emeraldwrath"] = 20,
		["Prankster"] = 30,
	},
	Shirts1 = {
		["Classic Shirt"] = 100,
	},
	Pants1 = {
		["Jeans"] = 100,
	},
}

function getRandomHat()--Gets a random hat from the loot table in server storage 
	-- Initialize a variable to keep track of the sum of chances in the loot table
	local Sum = 0
	-- Iterate over the hatloottable, which is assumed to be a table containing hat names as keys and their chances as values
	for HatName, Chance in pairs(hatloottable) do
		-- Add the chance to the sum
		Sum += Chance
	end
	-- Generate a random number between 1 and the sum of chances
	local randomNumber = math.random(Sum)
	-- Iterate over the hatloottable again
	for HatName, Chance in pairs(hatloottable) do
		if randomNumber <= Chance then
			-- If true, return the hat name
			return HatName
		else
			randomNumber -= Chance
		end
	end
end

function getRandomNeck() 
	local Sum = 0
	for NeckName, Chance in pairs(neckloottable) do
		Sum += Chance
	end
	local randomNumber = math.random(Sum)
	for NeckName, Chance in pairs(neckloottable) do
		if randomNumber <= Chance then
			return NeckName
		else
			randomNumber -= Chance
		end
	end
end

function getRandomHair() 
	local Sum = 0
	for HairName, Chance in pairs(hairloottable) do
		Sum += Chance
	end
	local randomNumber = math.random(Sum)
	for HairName, Chance in pairs(hairloottable) do
		if randomNumber <= Chance then
			return HairName
		else
			randomNumber -= Chance
		end
	end
end

function getRandomFace() 
	local Sum = 0
	for FaceName, Chance in pairs(faceloottable) do
		Sum += Chance
	end
	local randomNumber = math.random(Sum)
	for FaceName, Chance in pairs(faceloottable) do
		if randomNumber <= Chance then
			return FaceName
		else
			randomNumber -= Chance
		end
	end
end

function getRandomShirt() 
	local Sum = 0
	for ShirtName, Chance in pairs(shirtsloottable) do
		Sum += Chance
	end
	local randomNumber = math.random(Sum)
	for ShirtName, Chance in pairs(shirtsloottable) do
		if randomNumber <= Chance then
			return ShirtName
		else
			randomNumber -= Chance
		end
	end
end

function getRandomPant() 
	local Sum = 0
	for PantName, Chance in pairs(pantsloottable) do
		Sum += Chance
	end
	local randomNumber = math.random(Sum)
	for PantName, Chance in pairs(pantsloottable) do
		if randomNumber <= Chance then
			return PantName
		else
			randomNumber -= Chance
		end
	end
end

game.Players.PlayerAdded:Connect(function(player)--Checks if the player joins the game and creates a player paramater.
	player.CharacterAdded:Connect(function(character)--Checking when the player's character is added to the game.
		local hat =  hats:FindFirstChild(getRandomHat()):Clone()--It finds the first child in the hats directory which is located in server storage then it calls the function from earlier and gets the random hat and it clones it to the rig using the path.
		hat.Parent = Rig--Setting the parent as the rig we defined earlier

		local neck = neckaccessories:FindFirstChild(getRandomNeck()):Clone()
		neck.Parent = Rig 

		local hair = hairs:FindFirstChild(getRandomHair()):Clone()
		hair.Parent = Rig

		local face = faces:FindFirstChild(getRandomFace()):Clone()
		face.Parent = Rig.Head 

		local shirt = shirts:FindFirstChild(getRandomShirt()):Clone()
		shirt.Parent = Rig 

		local pant = pants:FindFirstChild(getRandomPant()):Clone()
		pant.Parent = Rig 

		local RigClone = Rig:Clone()		
		RigClone.Parent = game.Workspace

		local InvRig = RigClone:Clone()
		InvRig.Parent = player.CollectibleInventory

		local function generateUniqueID()
			local seed = os.clock()
			math.randomseed(seed)

			-- Concatenate the current time (as a string) with a random number between 1000 and 9999
			local uniqueID = os.time() .. math.random(1000, 9999)

			-- Returns the generated unique identifier
			return uniqueID
		end

		local function RandInt()
			-- Get the current time (in seconds since the program started running) as a seed
			local seed = os.clock()
			-- Set the random seed based on the current time

			math.randomseed(seed)

			-- Generate a random integer between 1 and 99999
			local RandomInt = math.random(1, 99999)

			-- Return the generated random integer
			return RandomInt
		end

		local uniqueID = generateUniqueID()
		local RandomInt = RandInt()

		DataEventClient:FireAllClients(player, {
			Owner = player,--Setting the Owner variable as player
			ID = uniqueID,--Setting the name as Rare Madness# with the random integer we generate.
			CollectibleName = "Bloxxer#"..RandomInt,--Setting the name as Bloxxer# with the random integer we generate.
			Rig = RigClone,--Clone the rig we generated
			Hat = {
				Name = hat.Name,--Get the name of the hat from the one we generated.
				Percent = itemPercentage.Hats[hat.Name] or 0,--Getting percent from the percent table.
			},
			NeckAccessory = {
				Name = neck.Name,
				Percent = itemPercentage.NeckAccessories[neck.Name] or 0,
			},
			Hair = {
				Name = hair.Name,
				Percent = itemPercentage.Hairs[hair.Name] or 0,
			},
			Face = {
				Name = face.Name	,
				Percent = itemPercentage.Faces1[face.Name] or 0,
			},
			Shirt = {
				Name = shirt.Name,
				Percent = itemPercentage.Shirts1[shirt.Name] or 0
			},
			Pant = {
				Name = pant.Name,
				Percent = itemPercentage.Pants1[pant.Name] or 0
			},
		})

		DataEventServer:Fire(player, {
			Owner = player,
			ID = uniqueID,
			CollectibleName = "RareMadness#"..RandomInt,
			Rig = RigClone,
			Hat = {
				Name = hat.Name,
				Price = itemPercentage.Hats[hat.Name] or 0,
			},
			NeckAccessory = {
				Name = neck.Name,
				Price = itemPercentage.NeckAccessories[neck.Name] or 0,
			},
			Hair = {
				Name = hairs.Name,
				Price = itemPercentage.Hairs[hair.Name] or 0,
			},
			Face = {
				Name = face.Name	,
				Price = itemPercentage.Faces1[face.Name] or 0,
			},
			Shirt = {
				Name = shirt.Name,
				Price = itemPercentage.Shirts1[shirt.Name] or 0
			},
			Pant = {
				Name = pant.Name,
				Price = itemPercentage.Pants1[pant.Name] or 0
			},
		})
	end)
end)
