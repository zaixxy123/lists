local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
pcall(function()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
    if PlayerGui then
        local hotbar = PlayerGui:WaitForChild("ReactUniversalHotbar", 5)
        if hotbar then
            local frame = hotbar:WaitForChild("Frame", 5)
            if frame then
                frame:WaitForChild("troops", 5)
            end
        end
    end
end)

local rs = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local NPCReplicator
pcall(function()
	NPCReplicator = require(rs.Client.Modules.Replicators.NPCReplicator)
end)

local defaultConfig = {
	autofire = true,
	gunVolume = 0.05, -- 0 to mute firing sounds completely, 0.05 for very quiet
	umbraPriority = true, -- Lock onto and prioritize The Umbra boss
	umbraAimLegs = true, -- Aim at Umbra's legs / skirt to avoid bow obstruction and upper-body animation sway
	autoCaliber = true,
	smartTargeting = true,
	maxTargets = 5,
	maxTarget = 5,
	mode = "First",
	dynamicMultiplier = true,
	dynamicFireRate = true,
	dynamicMultiplierFloor = 1,
	dynamicMultiplierCeiling = 5.8,
	dynamicShotFloor = 1,
	dynamicShotCeiling = 260,
	dynamicBudgetMin = 40,
	dynamicBudgetMax = 180,
	baseFireRate = 26,
	minFireRate = 14,
	maxFireRate = 170,
	autoCaliberPendingWindow = 0.2,
	autoCaliberBurstCap = 2,
	autoCaliberDpsBoost = true,
	autoCaliberBoostMinMultiplier = 1,
	autoCaliberBoostMaxMultiplier = 3.8,
	autoCaliberBoostStartShots = 30,
	autoCaliberBoostFullShots = 190,
	autoCaliberBoostShotCap = 420,
	autoCaliberStrongBurstCap = 5,
	autoCaliberStrongWait = 0.006,
	norecoil = true,
	chams = true,
	espMode = "Chams",
	pierceLogic = true,
	burstSize = 4,
	rangePadding = 3,
	predictionBase = 0.022,
	predictionDistanceScale = 0.00135,
	predictionMaxTime = 0.16,
	predictionMaxLead = 10.5,
	useIntercept = true,
	maxLateralSpread = 1.25,
	useDeltaVelocity = true,
	deltaVelocityMax = 220,
	alwaysLeadMoving = true,
	leadSpeedThreshold = 6,
	leadDistanceThreshold = 28,
	fastAim = true,
	fastSpeedThreshold = 30,
	fastBurstSize = 2,
	fastExtraLeadTime = 0.03,
	fastLateralSpread = 1.1,
	closeAimCompensation = true,
	closeRangeThreshold = 14,
	closeLeadScale = 0.3,
	closeSpreadScale = 0.15,
	closeForwardScale = 0.35,
	closeCenterBias = 0.88,
	velocitySmoothFactor = 0.35,
	accelLeadWeight = 0.55,
	verticalLeadScale = 0.2,
	projectileSpeedFallback = 360,
	projectileSpeedMin = 120,
	aimErrorCompensation = true,
	aimErrorLearnRate = 0.25,
	aimErrorDecay = 0.92,
	aimErrorMax = 3.5,
	lockOnTarget = true,
	lockGraceTime = 0.2,
	nearEndPriority = true,
	nearEndProgressThreshold = 0.8,
	nearEndForceBonus = 2.5,
	specialTargetPriority = true,
	specialTargetLockBypass = true,
	specialTargetMaxShots = 8,
	tricksterPriority = true,
	portalPriority = true,
	shootCorpses = true,
	corpsePriority = true,
	ignoreHolograms = true,
	prioritizeDamagable = false,
	shootImmune = false,
	shootLead = false,
	strongModePathWeight = 1.6,
	strongModeHpWeight = 0.65,
	maxShotsPerThreat = 18,
	nearEndReservePerTarget = 8,
	unlimitedRange = true,
	showBulletLines = true,
	rainbowBulletLines = true,
	rainbowESP = true,
	disablePrediction = true,
}

if not getgenv().config then
	getgenv().config = {}
end
for k, v in pairs(defaultConfig) do
	if getgenv().config[k] == nil then
		getgenv().config[k] = v
	end
end

local DAMAGE_VALUES = { [0] = 5, [1] = 8, [2] = 12, [3] = 16, [4] = 25, [5] = 45, [6] = 85 }

local THEME = {
	Bg = Color3.fromRGB(12, 12, 18),
	Header = Color3.fromRGB(18, 18, 25),
	Accent = Color3.fromRGB(90, 140, 255),
	Text = Color3.fromRGB(245, 245, 255),
	TextDim = Color3.fromRGB(140, 140, 160),
	Stroke = Color3.fromRGB(45, 45, 65),
}

local MotionCache = {}
local AimErrorCache = {}
local MotionSampleCounter = 0

if getgenv().RunningTowers then
	for _, taskConn in pairs(getgenv().RunningTowers) do
		if typeof(taskConn) == "thread" then
			task.cancel(taskConn)
		end
	end
end
getgenv().RunningTowers = {}

if coreGui:FindFirstChild("TheRailgun_UI") then
	coreGui.TheRailgun_UI:Destroy()
end
if players.LocalPlayer.PlayerGui:FindFirstChild("TheRailgun_UI") then
	players.LocalPlayer.PlayerGui.TheRailgun_UI:Destroy()
end
if coreGui:FindFirstChild("TheRailgun_TargetESP") then
	coreGui.TheRailgun_TargetESP:Destroy()
end
if coreGui:FindFirstChild("KOPI_GATLING_UI") then
	coreGui.KOPI_GATLING_UI:Destroy()
end
if players.LocalPlayer.PlayerGui:FindFirstChild("KOPI_GATLING_UI") then
	players.LocalPlayer.PlayerGui.KOPI_GATLING_UI:Destroy()
end
if coreGui:FindFirstChild("KopiTargetESP") then
	coreGui.KopiTargetESP:Destroy()
end
if coreGui:FindFirstChild("KopiChams") then
	coreGui.KopiChams:Destroy()
end
if workspace:FindFirstChild("TheRailgun_BulletLines") then
	workspace.TheRailgun_BulletLines:Destroy()
end
if getgenv().RainbowESPConnection then
	pcall(function()
		getgenv().RainbowESPConnection:Disconnect()
	end)
	getgenv().RainbowESPConnection = nil
end
if getgenv().LaserConnection then
	pcall(function()
		getgenv().LaserConnection:Disconnect()
	end)
	getgenv().LaserConnection = nil
end
if getgenv().BulletHitCleaner then
	pcall(function() getgenv().BulletHitCleaner:Disconnect() end)
	getgenv().BulletHitCleaner = nil
end

local function SetupBulletHitCleaner()
	local net = rs:FindFirstChild("Network")
	local gg = net and net:FindFirstChild("GatlingGun")
	local bulletHit = gg and gg:FindFirstChild("RE:BulletHit")
	if bulletHit and bulletHit:IsA("RemoteEvent") then
		if getgenv().BulletHitCleaner then
			pcall(function() getgenv().BulletHitCleaner:Disconnect() end)
		end
		getgenv().BulletHitCleaner = bulletHit.OnClientEvent:Connect(function() end)
	end
end
pcall(SetupBulletHitCleaner)

if getgenv().HitmarkerListener then
	getgenv().HitmarkerListener:Disconnect()
end
local function DestroyHitmarkers()
	local pGui = players.LocalPlayer:FindFirstChild("PlayerGui")
	if pGui then
		local view = pGui:FindFirstChild("ReactGameHitmarkerView")
		if view then
			view:Destroy()
		end
	end
end
DestroyHitmarkers()
getgenv().HitmarkerListener = players.LocalPlayer:WaitForChild("PlayerGui").ChildAdded:Connect(function(child)
	if child.Name == "ReactGameHitmarkerView" then
		task.wait()
		child:Destroy()
	end
end)

local function RemoveDamageDisplay()
	local net = rs:WaitForChild("Network", 5)
	if net then
		local dmgFolder = net:WaitForChild("Damage", 5)
		if dmgFolder then
			local remote = dmgFolder:FindFirstChild("URE:DisplayDamage")
			if remote then
				remote:Destroy()
			end
		end
	end
end
pcall(RemoveDamageDisplay)

if coreGui:FindFirstChild("TheRailgun_TargetESP") then
	pcall(function() coreGui.TheRailgun_TargetESP:Destroy() end)
end
if workspace:FindFirstChild("TheRailgun_BulletLines") then
	pcall(function() workspace.TheRailgun_BulletLines:Destroy() end)
end

local BulletLineFolder = Instance.new("Folder")
BulletLineFolder.Name = "TheRailgun_BulletLines"
BulletLineFolder.Parent = workspace

local EspFolder = Instance.new("Folder")
EspFolder.Name = "TheRailgun_TargetESP"
pcall(function() EspFolder.Parent = coreGui end)
if not EspFolder.Parent then
	pcall(function() EspFolder.Parent = players.LocalPlayer:WaitForChild("PlayerGui") end)
end

local MAX_ESP_POOL = 5
local ChamsPool = {}
local CsgoPool = {}

local function ClearTargetESP()
	for _, hl in pairs(ChamsPool) do
		hl.Adornee = nil
		hl.Enabled = false
	end
	for _, entry in pairs(CsgoPool) do
		if entry.outline then entry.outline.Adornee = nil end
		if entry.box then entry.box.Adornee = nil end
		if entry.tag then
			entry.tag.Adornee = nil
			entry.tag.Enabled = false
		end
	end
end

local function IsGatlingReloading(activeTower)
	if activeTower and activeTower.Parent then
		local rep = activeTower:FindFirstChild("TowerReplicator")
		if rep then
			if rep:GetAttribute("Reloading") == true then
				return true
			end
			local ammo = rep:GetAttribute("Ammo")
			if ammo and ammo <= 0 then
				return true
			end
		end
	end

	local ok, store = pcall(function()
		return require(rs.Client.Interfaces.Stores.Game.TowerAmmoStore)
	end)
	if ok and store and store.getState then
		local state = store.getState()
		if state then
			if state.reloading == true then
				return true
			end
			if state.enabled and state.ammo and state.ammo <= 0 then
				return true
			end
		end
	end

	return false
end

local TowerBarrelCache = setmetatable({}, { __mode = "k" })
local TowerBarrelIndex = setmetatable({}, { __mode = "k" })

local ActiveLasers = {}

local function ClearBulletLines(specificTower)
	if specificTower then
		for key, laser in pairs(ActiveLasers) do
			if laser.tower == specificTower then
				if laser.startPart and laser.startPart.Parent then
					laser.startPart:Destroy()
				end
				if laser.endPart and laser.endPart.Parent then
					laser.endPart:Destroy()
				end
				ActiveLasers[key] = nil
			end
		end
		return
	end

	for key, laser in pairs(ActiveLasers) do
		if laser.startPart and laser.startPart.Parent then
			laser.startPart:Destroy()
		end
		if laser.endPart and laser.endPart.Parent then
			laser.endPart:Destroy()
		end
	end
	table.clear(ActiveLasers)
	if BulletLineFolder and BulletLineFolder.Parent then
		BulletLineFolder:ClearAllChildren()
	end
end

local function GetRainbowColor(offset, saturation, value)
	local s = saturation or 1
	local v = value or 1
	local h = ((os.clock() * 0.75) + (offset or 0)) % 1
	return Color3.fromHSV(h, s, v)
end

local function GetRainbowColorSequence(offset)
	local h = ((os.clock() * 1.5) + (offset or 0)) % 1
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromHSV((h + 0.00) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.17, Color3.fromHSV((h + 0.17) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.33, Color3.fromHSV((h + 0.33) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.50, Color3.fromHSV((h + 0.50) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.67, Color3.fromHSV((h + 0.67) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.83, Color3.fromHSV((h + 0.83) % 1, 1, 1)),
		ColorSequenceKeypoint.new(1.00, Color3.fromHSV((h + 1.00) % 1, 1, 1)),
	})
end

local function GetRainbowCoreColorSequence(offset)
	local h = ((os.clock() * 1.5) + (offset or 0)) % 1
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromHSV((h + 0.00) % 1, 0.45, 1)),
		ColorSequenceKeypoint.new(0.20, Color3.fromHSV((h + 0.20) % 1, 0.45, 1)),
		ColorSequenceKeypoint.new(0.40, Color3.fromHSV((h + 0.40) % 1, 0.45, 1)),
		ColorSequenceKeypoint.new(0.60, Color3.fromHSV((h + 0.60) % 1, 0.45, 1)),
		ColorSequenceKeypoint.new(0.80, Color3.fromHSV((h + 0.80) % 1, 0.45, 1)),
		ColorSequenceKeypoint.new(1.00, Color3.fromHSV((h + 1.00) % 1, 0.45, 1)),
	})
end

local function GetBulletLineColor(towerReplicator)
	if towerReplicator then
		local bulletColor = towerReplicator:GetAttribute("BulletColor")
		if typeof(bulletColor) == "Color3" then
			return bulletColor
		end
	end
	return Color3.fromRGB(255, 220, 130)
end

local function BuildTowerBarrelCache(tower)
	local barrels = {}
	if tower and tower.Parent then
		for _, desc in ipairs(tower:GetDescendants()) do
			if desc:IsA("Attachment") and (desc.Name == "Fire" or desc.Name == "Muzzle") then
				local parentPart = desc.Parent
				if parentPart and parentPart:IsA("BasePart") then
					table.insert(barrels, desc)
				end
			end
		end
	end
	TowerBarrelCache[tower] = barrels
	TowerBarrelIndex[tower] = 1
	return barrels
end

local function GetTowerLaserStartPosition(tower)
	if not tower or not tower.Parent then
		return nil
	end

	local barrels = TowerBarrelCache[tower]
	if not barrels or #barrels == 0 then
		barrels = BuildTowerBarrelCache(tower)
	end
	if barrels and #barrels > 0 then
		local sum = Vector3.new(0, 0, 0)
		local count = 0
		for _, b in ipairs(barrels) do
			if b and b.Parent then
				sum = sum + b.WorldPosition
				count = count + 1
			end
		end
		if count > 0 then
			return sum / count
		end
	end

	local weapon = tower:FindFirstChild("Weapon")
	if weapon then
		local main = weapon:FindFirstChild("Main")
		local barrel = main and main:FindFirstChild("Barrel")
		local fireAtt = barrel and (barrel:FindFirstChild("Fire") or barrel:FindFirstChild("Muzzle"))
		if fireAtt then
			return fireAtt.WorldPosition
		end
		if barrel and barrel:IsA("BasePart") then
			return barrel.Position
		end
	end

	local head = tower:FindFirstChild("Head") or tower:FindFirstChild("Gun") or tower.PrimaryPart
	if head and head:IsA("BasePart") then
		return head.Position
	end

	local hrp = tower:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:IsA("BasePart") then
		return hrp.Position + Vector3.new(0, 1.5, 0)
	end
	return nil
end

local function GetUmbraLegPosition(model)
	if not model or not model.Parent then return nil end

	-- 1. Check foot/lower leg bones
	local rFoot = model:FindFirstChild("Right Foot", true) or model:FindFirstChild("DEF_Foot_R", true) or model:FindFirstChild("DEF_Lower_Leg_R", true)
	local lFoot = model:FindFirstChild("Left Foot", true) or model:FindFirstChild("DEF_Foot_L", true) or model:FindFirstChild("DEF_Lower_Leg_L", true)
	if rFoot and lFoot and rFoot:IsA("Bone") and lFoot:IsA("Bone") then
		return (rFoot.WorldPosition + lFoot.WorldPosition) * 0.5
	elseif rFoot and rFoot:IsA("Bone") then
		return rFoot.WorldPosition
	elseif lFoot and lFoot:IsA("Bone") then
		return lFoot.WorldPosition
	end

	-- 2. Check main leg bones (offset down by 1.8 studs from hip joint to hit knee/shin)
	local legR = model:FindFirstChild("Right Leg", true)
	local legL = model:FindFirstChild("Left Leg", true)
	if (legR and legR:IsA("Bone")) or (legL and legL:IsA("Bone")) then
		local hipPos = (legR and legL) and ((legR.WorldPosition + legL.WorldPosition) * 0.5) or (legR and legR.WorldPosition or legL.WorldPosition)
		return hipPos - Vector3.new(0, 1.8, 0)
	end

	-- 3. Check Skirt MeshPart (bottom of skirt is at knee/leg level, Y ≈ 2.0)
	local skirt = model:FindFirstChild("Skirt")
	if skirt and skirt:IsA("BasePart") then
		return skirt.Position - Vector3.new(0, (skirt.Size.Y * 0.45), 0)
	end

	-- 4. Calculate directly from Character or Model Pivot (Umbra height = 8.8 studs, center Y ≈ 5.5, legs Y ≈ 1.9)
	local char = model:FindFirstChild("Character")
	if char and char:IsA("BasePart") then
		return char.Position - Vector3.new(0, (char.Size.Y * 0.38), 0)
	end

	local ok, cf = pcall(function() return model:GetPivot() end)
	if ok and cf then
		return cf.Position - Vector3.new(0, 3.4, 0)
	end

	return nil
end

local TargetVisualPartCache = setmetatable({}, { __mode = "k" })

local function GetTargetVisualPosition(model, defaultPos)
	if not model or not model.Parent then
		return defaultPos
	end

	local mName = string.lower(model.Name)
	if string.find(mName, "umbra", 1, true) then
		local cfg = getgenv().config
		if cfg and cfg.umbraAimLegs ~= false then
			local legPos = GetUmbraLegPosition(model)
			if legPos then
				return legPos
			end
		end
		local charPart = model:FindFirstChild("Character")
		if charPart and charPart:IsA("BasePart") and charPart.Transparency < 1 then
			return charPart.Position
		end
		local torso = model:FindFirstChild("Torso", true) or model:FindFirstChild("UpperTorso", true)
		if torso and torso:IsA("BasePart") and torso.Transparency < 1 then
			return torso.Position
		end
	end

	local cached = TargetVisualPartCache[model]
	if cached and cached.Parent then
		if cached:IsA("Bone") then
			return cached.WorldPosition
		elseif cached:IsA("BasePart") then
			return cached.Position
		end
	end

	if string.find(mName, "eye", 1, true) and not string.find(mName, "reaver", 1, true) then
		local eyePart = model:FindFirstChild("Eye", true)
		if eyePart and eyePart:IsA("BasePart") and eyePart.Transparency < 1 then
			TargetVisualPartCache[model] = eyePart
			return eyePart.Position
		end
	end

	if string.find(mName, "breaker", 1, true) then
		local torso = model:FindFirstChild("Torso", true) or model:FindFirstChild("UpperTorso", true)
		if torso and torso:IsA("BasePart") and torso.Transparency < 1 then
			TargetVisualPartCache[model] = torso
			return torso.Position
		end
	end

	local hitbox = model:FindFirstChild("Hitbox", true)
	if hitbox and hitbox:IsA("BasePart") then
		TargetVisualPartCache[model] = hitbox
		return hitbox.Position
	end
	local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
	if torso and torso:IsA("BasePart") then
		TargetVisualPartCache[model] = torso
		return torso.Position
	end
	local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart") or model.PrimaryPart
	if hrp and hrp:IsA("BasePart") then
		TargetVisualPartCache[model] = hrp
		return hrp.Position
	end
	local charPart = model:FindFirstChild("Character")
	if charPart and charPart:IsA("BasePart") then
		TargetVisualPartCache[model] = charPart
		return charPart.Position
	end
	local eyePart = model:FindFirstChild("Eye")
	if eyePart and eyePart:IsA("BasePart") then
		TargetVisualPartCache[model] = eyePart
		return eyePart.Position
	end
	local legR = model:FindFirstChild("DEF_Lower_Leg_R", true)
	if legR and legR:IsA("Bone") then
		TargetVisualPartCache[model] = legR
		return legR.WorldPosition
	end
	local rLeg = model:FindFirstChild("Right Leg") or model:FindFirstChild("RightLowerLeg")
	if rLeg and rLeg:IsA("BasePart") then
		TargetVisualPartCache[model] = rLeg
		return rLeg.Position
	end
	local head = model:FindFirstChild("Head")
	if head and head:IsA("BasePart") then
		TargetVisualPartCache[model] = head
		return head.Position
	end
	local ok, cf = pcall(function()
		return model:GetPivot()
	end)
	if ok and cf then
		return cf.Position
	end
	return defaultPos
end

local function GetLaserKey(tower, targetModel)
	local tKey = "tower"
	if tower then
		local rep = tower:FindFirstChild("TowerReplicator")
		local uid = (rep and rep:GetAttribute("UID")) or tower:GetAttribute("UID")
		if uid and uid ~= "" then
			tKey = tostring(uid)
		else
			local ok, id = pcall(function() return tower:GetDebugId() end)
			if ok and id and id ~= "" then
				tKey = tostring(id)
			else
				local okPivot, pivot = pcall(function() return tower:GetPivot().Position end)
				if okPivot and pivot then
					tKey = string.format("pos_%.1f_%.1f_%.1f", pivot.X, pivot.Y, pivot.Z)
				else
					tKey = tostring(tower)
				end
			end
		end
	end

	local mKey = "target"
	if targetModel then
		local rep = targetModel:FindFirstChild("Replicator")
		local uid = (rep and (rep:GetAttribute("ID") or rep:GetAttribute("UID"))) or targetModel:GetAttribute("ID") or targetModel:GetAttribute("UID")
		if uid and uid ~= "" then
			mKey = tostring(uid)
		else
			local ok, id = pcall(function() return targetModel:GetDebugId() end)
			if ok and id and id ~= "" then
				mKey = tostring(id)
			else
				local okPivot, pivot = pcall(function() return targetModel:GetPivot().Position end)
				if okPivot and pivot then
					mKey = string.format("target_%.1f_%.1f_%.1f", pivot.X, pivot.Y, pivot.Z)
				else
					mKey = tostring(targetModel)
				end
			end
		end
	end

	return tKey .. "_" .. mKey
end

local function SpawnBulletLine(tower, towerReplicator, endPosition, targetModel)
	if getgenv().config.showBulletLines ~= true then
		return
	end
	if not BulletLineFolder or not BulletLineFolder.Parent then
		return
	end

	local startPosition = GetTowerLaserStartPosition(tower)
	if not startPosition then
		local hrp = tower and tower:FindFirstChild("HumanoidRootPart")
		startPosition = hrp and hrp.Position
	end
	if not startPosition then
		return
	end

	local targetVisualPos = targetModel and GetTargetVisualPosition(targetModel, endPosition) or endPosition
	if typeof(targetVisualPos) ~= "Vector3" then
		return
	end

	local distance = (targetVisualPos - startPosition).Magnitude
	if distance <= 0.05 then
		return
	end

	local laserKey = GetLaserKey(tower, targetModel)
	local existing = ActiveLasers[laserKey]

	if existing and existing.startPart and existing.startPart.Parent and existing.endPart and existing.endPart.Parent then
		existing.startPart.CFrame = CFrame.new(startPosition)
		existing.endPart.CFrame = CFrame.new(targetVisualPos)
		existing.lastFiredTick = os.clock()
		existing.targetModel = targetModel
		existing.tower = tower
		return
	end

	local startPart = Instance.new("Part")
	startPart.Name = "LaserStart"
	startPart.Size = Vector3.new(0.05, 0.05, 0.05)
	startPart.Anchored = true
	startPart.CanCollide = false
	startPart.CanQuery = false
	startPart.CanTouch = false
	startPart.Transparency = 1
	startPart.CFrame = CFrame.new(startPosition)
	startPart.Parent = BulletLineFolder

	local endPart = Instance.new("Part")
	endPart.Name = "LaserEnd"
	endPart.Size = Vector3.new(0.05, 0.05, 0.05)
	endPart.Anchored = true
	endPart.CanCollide = false
	endPart.CanQuery = false
	endPart.CanTouch = false
	endPart.Transparency = 1
	endPart.CFrame = CFrame.new(targetVisualPos)
	endPart.Parent = BulletLineFolder

	local startAttachment = Instance.new("Attachment")
	startAttachment.Parent = startPart

	local endAttachment = Instance.new("Attachment")
	endAttachment.Parent = endPart

	local beam = Instance.new("Beam")
	beam.Attachment0 = startAttachment
	beam.Attachment1 = endAttachment
	beam.FaceCamera = true
	beam.LightEmission = 0.75
	pcall(function()
		beam.LightInfluence = 0
		beam.Brightness = 2.2
		beam.ZOffset = 0.2
	end)
	beam.Texture = ""
	beam.Width0 = 0.25
	beam.Width1 = 0.20
	beam.Color = GetRainbowColorSequence()
	beam.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.05),
		NumberSequenceKeypoint.new(0.75, 0.15),
		NumberSequenceKeypoint.new(1, 0.25),
	})
	beam.Parent = startPart

	local coreBeam = Instance.new("Beam")
	coreBeam.Attachment0 = startAttachment
	coreBeam.Attachment1 = endAttachment
	coreBeam.FaceCamera = true
	coreBeam.LightEmission = 0.95
	pcall(function()
		coreBeam.LightInfluence = 0
		coreBeam.Brightness = 3.2
		coreBeam.ZOffset = 0.25
	end)
	coreBeam.Texture = ""
	coreBeam.Width0 = 0.08
	coreBeam.Width1 = 0.06
	coreBeam.Color = GetRainbowCoreColorSequence()
	coreBeam.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.0),
		NumberSequenceKeypoint.new(1, 0.1),
	})
	coreBeam.Parent = startPart

	ActiveLasers[laserKey] = {
		startPart = startPart,
		endPart = endPart,
		beam = beam,
		coreBeam = coreBeam,
		lastFiredTick = os.clock(),
		targetModel = targetModel,
		tower = tower,
	}
end

if getgenv().LaserConnection then
	pcall(function()
		getgenv().LaserConnection:Disconnect()
	end)
	getgenv().LaserConnection = nil
end

local LastLaserColorTick = 0
local CachedRainbowSeq = nil
local CachedCoreRainbowSeq = nil

getgenv().LaserConnection = RunService.RenderStepped:Connect(function()
	if next(ActiveLasers) == nil then
		return
	end

	local now = os.clock()
	local colorUpdated = false
	if not CachedRainbowSeq or (now - LastLaserColorTick) >= 0.033 then
		CachedRainbowSeq = GetRainbowColorSequence()
		CachedCoreRainbowSeq = GetRainbowCoreColorSequence()
		LastLaserColorTick = now
		colorUpdated = true
	end

	for key, laser in pairs(ActiveLasers) do
		local towerDead = not laser.tower or not laser.tower.Parent or not laser.tower:IsDescendantOf(workspace)
		local targetDead = laser.targetModel and (
			not laser.targetModel.Parent
			or not laser.targetModel:IsDescendantOf(workspace)
		)
		local timeout = (now - laser.lastFiredTick) > 0.14

		if timeout or targetDead or towerDead or (getgenv().config and getgenv().config.showBulletLines == false) then
			if laser.startPart and laser.startPart.Parent then
				laser.startPart:Destroy()
			end
			if laser.endPart and laser.endPart.Parent then
				laser.endPart:Destroy()
			end
			ActiveLasers[key] = nil
		else
			if colorUpdated then
				if laser.beam and laser.beam.Parent then
					laser.beam.Color = CachedRainbowSeq
				end
				if laser.coreBeam and laser.coreBeam.Parent then
					laser.coreBeam.Color = CachedCoreRainbowSeq
				end
			end
			if laser.targetModel and laser.targetModel.Parent and laser.endPart and laser.endPart.Parent then
				local ePos = GetTargetVisualPosition(laser.targetModel, nil)
				if ePos then
					laser.endPart.CFrame = CFrame.new(ePos)
				end
			end
		end
	end
end)

print("[AutoGatling] Running in Headless/No-GUI mode with default settings.")
local function get_base_position()
	for _, name in pairs({ "Exit", "End", "EndPoint", "Lives" }) do
		local found = workspace:FindFirstChild(name, true)
		if found and found:IsA("BasePart") then
			return found.Position
		end
	end
	return Vector3.new(0, 10, 0)
end

local function NormalizeLookupName(name)
	if type(name) ~= "string" then
		return ""
	end
	return string.lower(name):gsub("[^%w]", "")
end

local function ReadNumericStat(source, keys, recursive)
	if not source then
		return nil
	end
	for _, key in ipairs(keys) do
		local attr = source:GetAttribute(key)
		if type(attr) == "number" then
			return attr
		end
		if type(attr) == "string" then
			local parsedAttr = tonumber(attr)
			if parsedAttr then
				return parsedAttr
			end
		end

		local child = source:FindFirstChild(key, recursive == true)
		if child then
			if child:IsA("NumberValue") or child:IsA("IntValue") then
				return child.Value
			end
			if child:IsA("StringValue") then
				local parsedValue = tonumber(child.Value)
				if parsedValue then
					return parsedValue
				end
			end
		end
	end
	return nil
end

local HEALTH_STAT_KEYS = {
	"Health",
	"HP",
	"HitPoints",
	"Hitpoints",
	"CurrentHealth",
	"CurrentHP",
	"Hp",
}

local MAX_HEALTH_STAT_KEYS = {
	"MaxHealth",
	"MaxHP",
	"HealthMax",
	"HitPointMax",
	"MaximumHealth",
}

local function IsLikelyHitboxPart(part)
	if not part or not part:IsA("BasePart") then
		return false
	end
	local lowered = string.lower(part.Name or "")
	return string.find(lowered, "hitbox", 1, true) ~= nil or string.find(lowered, "hurtbox", 1, true) ~= nil
end

local function FindFirstUsableBasePart(root)
	if not root then
		return nil
	end
	local fallback
	for _, part in ipairs(root:GetDescendants()) do
		if part:IsA("BasePart") then
			if not fallback then
				fallback = part
			end
			if not IsLikelyHitboxPart(part) then
				return part
			end
		end
	end
	return fallback
end

local function GetBreakerAimPart(model)
	if not model then
		return nil
	end
	local torso = model:FindFirstChild("Torso", true) or model:FindFirstChild("UpperTorso", true)
	if torso and torso:IsA("BasePart") and torso.Transparency < 1 then
		return torso
	end
	local head = model:FindFirstChild("Head", true)
	if head and head:IsA("BasePart") and head.Transparency < 1 then
		return head
	end
	for _, part in ipairs(model:GetChildren()) do
		if part:IsA("BasePart") and part.Transparency < 1 and not IsLikelyHitboxPart(part) then
			return part
		end
	end
	local hitbox = model:FindFirstChild("Hitbox", true)
	if hitbox and hitbox:IsA("BasePart") then
		return hitbox
	end
	local hrp = model:FindFirstChild("HumanoidRootPart", true) or model:FindFirstChild("RootPart", true) or model.PrimaryPart
	if hrp and hrp:IsA("BasePart") then
		return hrp
	end
	return nil
end

local function GetUmbraAimPart(model)
	if not model then
		return nil
	end
	local cfg = getgenv().config
	if cfg and cfg.umbraAimLegs ~= false then
		local skirt = model:FindFirstChild("Skirt")
		if skirt and skirt:IsA("BasePart") and skirt.Transparency < 1 then
			return skirt
		end
	end
	local charPart = model:FindFirstChild("Character")
	if charPart and charPart:IsA("BasePart") and charPart.Transparency < 1 then
		return charPart
	end
	local torso = model:FindFirstChild("Torso", true) or model:FindFirstChild("UpperTorso", true)
	if torso and torso:IsA("BasePart") and torso.Transparency < 1 then
		return torso
	end
	local pauldrons = model:FindFirstChild("Pauldrons")
	if pauldrons and pauldrons:IsA("BasePart") and pauldrons.Transparency < 1 then
		return pauldrons
	end
	local skirt = model:FindFirstChild("Skirt")
	if skirt and skirt:IsA("BasePart") and skirt.Transparency < 1 then
		return skirt
	end
	for _, part in ipairs(model:GetChildren()) do
		if part:IsA("BasePart") and part.Transparency < 1 and not IsLikelyHitboxPart(part) then
			return part
		end
	end
	return model:FindFirstChild("Hitbox") or model.PrimaryPart
end

local function FindTargetPart(model, npcData)
	if not model then
		return nil
	end

	local mName = string.lower(model.Name)
	local npcName = npcData and npcData.Name

	local isUmbra = string.find(mName, "umbra", 1, true) or (npcName and string.find(string.lower(tostring(npcName)), "umbra", 1, true))
	if isUmbra then
		local umbraPart = GetUmbraAimPart(model)
		if umbraPart then
			return umbraPart
		end
	end

	local isEye = ((string.find(mName, "eye", 1, true) or model:FindFirstChild("Eye") or model:FindFirstChild("EyeModelFake")) or (npcName and string.find(string.lower(tostring(npcName)), "eye", 1, true))) and not string.find(mName, "reaver", 1, true)
	if isEye then
		local hitbox = model:FindFirstChild("Hitbox", true) or model:FindFirstChild("Eye", true)
		if hitbox and hitbox:IsA("BasePart") then
			return hitbox
		end
	end

	local isBreaker = (string.find(mName, "breaker", 1, true) ~= nil) or (npcName and string.find(string.lower(tostring(npcName)), "breaker", 1, true) ~= nil)
	if isBreaker then
		local breakerPart = GetBreakerAimPart(model)
		if breakerPart then
			return breakerPart
		end
	end

	local hrp = model:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:IsA("BasePart") then
		return hrp
	end

	local primary = (npcData and npcData.Model and npcData.Model.PrimaryPart) or model.PrimaryPart
	if primary and primary:IsA("BasePart") then
		return primary
	end

	for _, name in ipairs({
		"Torso",
		"UpperTorso",
		"LowerTorso",
		"Character",
		"Head",
		"RootPart",
		"Main",
		"Center",
		"Core",
		"Crystal",
		"Portal",
		"Hitbox",
		"Eye",
	}) do
		local candidate = model:FindFirstChild(name, true)
		if candidate and candidate:IsA("BasePart") then
			return candidate
		end
	end

	return FindFirstUsableBasePart(model)
end

local CRYSTAL_TARGET_KEYWORDS = {
	"beacon",
	"crystal",
	"totem",
	"idol",
	"pylon",
	"shard",
}

local SPECIAL_TARGET_KEYWORDS = {
	"summon",
	"eye",
	"void eye",
	"voideye",
	"void portal",
	"voidportal",
	"portal",
}

local PORTAL_TARGET_KEYWORDS = {
	"void portal",
	"voidportal",
	"portal",
}

local function HasKeyword(value, keywords)
	if type(value) ~= "string" then
		return false
	end
	local lowered = string.lower(value)
	for _, keyword in ipairs(keywords) do
		if string.find(lowered, keyword, 1, true) then
			return true
		end
	end
	return false
end

local function HasSpecialKeyword(value)
	return HasKeyword(value, SPECIAL_TARGET_KEYWORDS)
end

local function HasCrystalKeyword(value)
	return HasKeyword(value, CRYSTAL_TARGET_KEYWORDS)
end

local function HasPortalKeyword(value)
	return HasKeyword(value, PORTAL_TARGET_KEYWORDS)
end

local function GetNPCFromFolder(folder)
	if not NPCReplicator or not folder then
		return nil
	end
	local ok, npc = pcall(NPCReplicator.GetNPCFromFolder, folder)
	if ok and npc then
		return npc
	end
	return nil
end

local function GetNPCFromModel(model)
	if not NPCReplicator or not model then
		return nil
	end
	local ok, npc = pcall(NPCReplicator.GetNPCFromModel, model)
	if ok and npc then
		return npc
	end
	return nil
end

local function IsUmbraTarget(model, rep)
	if model then
		local name = string.lower(model.Name)
		if string.find(name, "umbra", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = model:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "umbra", 1, true) ~= nil then
				return true
			end
		end
		local npc = GetNPCFromModel(model)
		if npc and npc.Name and string.find(string.lower(npc.Name), "umbra", 1, true) ~= nil then
			return true
		end
	end
	if rep then
		local name = string.lower(rep.Name)
		if string.find(name, "umbra", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = rep:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "umbra", 1, true) ~= nil then
				return true
			end
		end
		local npc = GetNPCFromFolder(rep)
		if npc and npc.Name and string.find(string.lower(npc.Name), "umbra", 1, true) ~= nil then
			return true
		end
	end
	return false
end

local function IsTricksterTarget(model, rep)
	if model then
		local name = string.lower(model.Name)
		if string.find(name, "trickster", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = model:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "trickster", 1, true) ~= nil then
				return true
			end
		end
		local npc = GetNPCFromModel(model)
		if npc and npc.Name and string.find(string.lower(npc.Name), "trickster", 1, true) ~= nil then
			return true
		end
	end
	if rep then
		local name = string.lower(rep.Name)
		if string.find(name, "trickster", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = rep:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "trickster", 1, true) ~= nil then
				return true
			end
		end
		local npc = GetNPCFromFolder(rep)
		if npc and npc.Name and string.find(string.lower(npc.Name), "trickster", 1, true) ~= nil then
			return true
		end
	end
	return false
end

local function IsCrystalTarget(model, rep)
	if IsTricksterTarget(model, rep) or IsUmbraTarget(model, rep) then
		return false
	end
	local function CheckAttributesForCrystal(source, keys)
		for _, key in ipairs(keys) do
			if HasCrystalKeyword(source:GetAttribute(key)) then
				return true
			end
		end
		return false
	end

	if model then
		if HasCrystalKeyword(model.Name) then
			return true
		end
		if CheckAttributesForCrystal(model, { "DisplayName", "Name", "Type", "Class", "UnitType" }) then
			return true
		end
		if
			model:FindFirstChild("Crystal", true)
			or model:FindFirstChild("Beacon", true)
			or model:FindFirstChild("IceBeacon", true)
			or model:FindFirstChild("Ice Beacon", true)
		then
			return true
		end
	end

	if rep then
		if HasCrystalKeyword(rep.Name) then
			return true
		end
		if CheckAttributesForCrystal(rep, { "DisplayName", "Name", "Type", "Class", "UnitType" }) then
			return true
		end
	end

	return false
end

local function IsSpecialSpawnTarget(model, rep)
	if (model and (string.find(string.lower(model.Name), "guardian", 1, true) or string.find(string.lower(model.Name), "trickster", 1, true) or string.find(string.lower(model.Name), "umbra", 1, true)))
		or (rep and (string.find(string.lower(rep.Name), "guardian", 1, true) or string.find(string.lower(rep.Name), "trickster", 1, true) or string.find(string.lower(rep.Name), "umbra", 1, true)))
		or IsTricksterTarget(model, rep)
		or IsUmbraTarget(model, rep) then
		return false
	end
	if model then
		if HasSpecialKeyword(model.Name) then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class" }) do
			if HasSpecialKeyword(model:GetAttribute(key)) then
				return true
			end
		end
	end
	if rep then
		if HasSpecialKeyword(rep.Name) then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType" }) do
			if HasSpecialKeyword(rep:GetAttribute(key)) then
				return true
			end
		end
	end
	return false
end

local function IsEyeTarget(model, rep)
	if IsTricksterTarget(model, rep) or IsUmbraTarget(model, rep) then
		return false
	end
	if model then
		local name = string.lower(model.Name)
		if string.find(name, "reaver", 1, true) then
			return false
		end
		if string.find(name, "eye", 1, true) or model:FindFirstChild("Eye") or model:FindFirstChild("EyeModelFake") then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local attr = model:GetAttribute(key)
			if type(attr) == "string" and string.find(string.lower(attr), "eye", 1, true) and not string.find(string.lower(attr), "reaver", 1, true) then
				return true
			end
		end
	end
	if rep then
		local name = string.lower(rep.Name)
		if string.find(name, "reaver", 1, true) then
			return false
		end
		if string.find(name, "eye", 1, true) then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local attr = rep:GetAttribute(key)
			if type(attr) == "string" and string.find(string.lower(attr), "eye", 1, true) and not string.find(string.lower(attr), "reaver", 1, true) then
				return true
			end
		end
	end
	return false
end

local function IsVoidPortalTarget(model, rep)
	if IsTricksterTarget(model, rep) or IsUmbraTarget(model, rep) then
		return false
	end
	local function CheckAttributesForPortal(source, keys)
		for _, key in ipairs(keys) do
			if HasPortalKeyword(source:GetAttribute(key)) then
				return true
			end
		end
		return false
	end

	if model then
		if HasPortalKeyword(model.Name) then
			return true
		end
		if CheckAttributesForPortal(model, { "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) then
			return true
		end
		if model:FindFirstChild("Portal", true) then
			return true
		end
	end

	if rep then
		if HasPortalKeyword(rep.Name) then
			return true
		end
		if CheckAttributesForPortal(rep, { "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) then
			return true
		end
	end

	return false
end

local HOLOGRAM_KEYWORDS = {
	"hologram",
	"decoy",
	"fake",
}

local function HasHologramKeyword(value)
	return HasKeyword(value, HOLOGRAM_KEYWORDS)
end

local function IsHologramEnemy(model, rep, npcData)
	if rep then
		if rep:GetAttribute("FakeUnit") == true
			or rep:GetAttribute("Hologram") == true
			or rep:GetAttribute("IsHologram") == true
			or rep:GetAttribute("Decoy") == true
		then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local attr = rep:GetAttribute(key)
			if HasHologramKeyword(attr) then
				return true
			end
		end
		if HasHologramKeyword(rep.Name) then
			return true
		end
	end

	if npcData then
		if npcData.FakeUnit == true or npcData.Hologram == true or npcData.IsHologram == true or npcData.Decoy == true then
			return true
		end
		if npcData.Type == "Units" and rep and rep:GetAttribute("FakeUnit") ~= nil then
			return true
		end
		if HasHologramKeyword(npcData.Name) or HasHologramKeyword(npcData.DisplayName) then
			return true
		end
	end

	if model then
		if model:GetAttribute("FakeUnit") == true
			or model:GetAttribute("Hologram") == true
			or model:GetAttribute("IsHologram") == true
			or model:GetAttribute("Decoy") == true
		then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local attr = model:GetAttribute(key)
			if HasHologramKeyword(attr) then
				return true
			end
		end
		if HasHologramKeyword(model.Name) then
			return true
		end
	end

	return false
end

local CORPSE_TARGET_KEYWORDS = {
	"corpse",
	"hex corpse",
	"moltencorpse",
	"grave",
	"tombstone",
	"statue",
}

local function HasCorpseKeyword(value)
	return HasKeyword(value, CORPSE_TARGET_KEYWORDS)
end

local function IsCorpseTarget(model, rep)
	if IsHologramEnemy(model, rep) or IsTricksterTarget(model, rep) or IsUmbraTarget(model, rep) then
		return false
	end

	if model then
		if HasCorpseKeyword(model.Name) then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			if HasCorpseKeyword(model:GetAttribute(key)) then
				return true
			end
		end
		if model:GetAttribute("Revived") == true or model:GetAttribute("Corpse") == true or model:GetAttribute("IsCorpse") == true then
			return true
		end
		if model:FindFirstChild("Corpse") then
			return true
		end
	end

	if rep then
		if HasCorpseKeyword(rep.Name) then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			if HasCorpseKeyword(rep:GetAttribute(key)) then
				return true
			end
		end
		if rep:GetAttribute("Revived") == true or rep:GetAttribute("Corpse") == true or rep:GetAttribute("IsCorpse") == true then
			return true
		end
	end

	return false
end

local function IsBreakerTarget(model, rep)
	if model then
		local name = string.lower(model.Name)
		if string.find(name, "breaker", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = model:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "breaker", 1, true) ~= nil then
				return true
			end
		end
	end
	if rep then
		local name = string.lower(rep.Name)
		if string.find(name, "breaker", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = rep:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "breaker", 1, true) ~= nil then
				return true
			end
		end
	end
	return false
end

local function IsGuardianTarget(model, rep)
	if model then
		local name = string.lower(model.Name)
		if string.find(name, "guardian", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = model:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "guardian", 1, true) ~= nil then
				return true
			end
		end
	end
	if rep then
		local name = string.lower(rep.Name)
		if string.find(name, "guardian", 1, true) ~= nil then
			return true
		end
		for _, key in ipairs({ "DisplayName", "Name", "Type", "Class", "UnitType", "ModelName" }) do
			local val = rep:GetAttribute(key)
			if type(val) == "string" and string.find(string.lower(val), "guardian", 1, true) ~= nil then
				return true
			end
		end
	end
	return false
end

local function ResolveNPC(model, rep)
	if rep then
		local fromFolder = GetNPCFromFolder(rep)
		if fromFolder then
			return fromFolder, rep
		end
	end

	local fromModel = GetNPCFromModel(model)
	if fromModel then
		local folderPointer = fromModel.FolderPointer
		local resolvedRep = rep
		if folderPointer and folderPointer:IsA("ObjectValue") and folderPointer.Value then
			resolvedRep = folderPointer.Value
		end
		return fromModel, resolvedRep
	end

	return nil, rep
end

local function GetReplicator(model)
	if not model then
		return nil
	end
	local npc = GetNPCFromModel(model)
	if npc and npc.FolderPointer and npc.FolderPointer:IsA("ObjectValue") and npc.FolderPointer.Value then
		return npc.FolderPointer.Value
	end
	local ptr = model:FindFirstChild("RootPointer")
	if ptr and ptr:IsA("ObjectValue") and ptr.Value then
		return ptr.Value
	end
	local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart")
	if hrp then
		local ptr2 = hrp:FindFirstChild("RootPointer")
		if ptr2 and ptr2:IsA("ObjectValue") and ptr2.Value then
			return ptr2.Value
		end
	end
	local stateRep = rs:FindFirstChild("StateReplicators")
	if stateRep then
		local normalizedModelName = NormalizeLookupName(model.Name)
		local bestPartial, bestScore = nil, -1
		for _, folder in ipairs(stateRep:GetChildren()) do
			if folder.Name == "NPCReplicator" or folder:GetAttribute("Health") ~= nil then
				local repName = folder:GetAttribute("ModelName") or folder:GetAttribute("Name") or folder.Name
				local normalizedRepName = NormalizeLookupName(repName)
				if normalizedRepName ~= "" and normalizedRepName == normalizedModelName then
					return folder
				end
				if normalizedRepName ~= "" and normalizedModelName ~= "" then
					if
						string.find(normalizedRepName, normalizedModelName, 1, true)
						or string.find(normalizedModelName, normalizedRepName, 1, true)
					then
						local score = math.min(#normalizedRepName, #normalizedModelName)
						if score > bestScore then
							bestPartial = folder
							bestScore = score
						end
					end
				end
			end
		end
		if bestPartial then
			return bestPartial
		end
	end
	return nil
end

local function get_stats_from_npc(npc)
	if not npc then
		return 0, 0, -1, 0, 0
	end
	if npc.NoHealth == true or npc.Dead == true or npc.Dying == true or npc.Killed == true or npc.Destroyed == true then
		return 0, 0, tonumber(npc.PathDistance) or -1, tonumber(npc.Defense) or 0, tonumber(npc.MaxHealth) or 0
	end
	if type(npc.IsAlive) == "function" and not npc:IsAlive() then
		return 0, 0, tonumber(npc.PathDistance) or -1, tonumber(npc.Defense) or 0, tonumber(npc.MaxHealth) or 0
	end

	local hp = tonumber(npc.Health) or 0
	local shield = tonumber(npc.Shield) or 0
	if hp <= 0 and shield <= 0 then
		return 0, 0, tonumber(npc.PathDistance) or -1, tonumber(npc.Defense) or 0, tonumber(npc.MaxHealth) or 0
	end

	local path = tonumber(npc.PathDistance) or -1
	local defense = tonumber(npc.Defense) or 0
	local maxHp = tonumber(npc.MaxHealth) or 0
	return hp, shield, path, defense, maxHp
end

local function get_stats_from_rep(rep)
	if not rep or not rep.Parent then
		return 0, 0, -1, 0, 0
	end
	if
		rep:GetAttribute("NoHealth") == true
		or rep:GetAttribute("Dead") == true
		or rep:GetAttribute("Dying") == true
		or rep:GetAttribute("Killed") == true
		or rep:GetAttribute("IsDead") == true
	then
		return 0, 0, -1, 0, 0
	end

	local hp = ReadNumericStat(rep, HEALTH_STAT_KEYS, false) or ReadNumericStat(rep, HEALTH_STAT_KEYS, true)
	if hp and hp <= 0 then
		return 0, 0, -1, 0, 0
	end

	local shield = ReadNumericStat(rep, { "Shield", "Armor" }, false)
		or ReadNumericStat(rep, { "Shield", "Armor" }, true)
		or 0

	if (hp or 0) <= 0 and shield <= 0 then
		return 0, 0, -1, 0, 0
	end

	local defense = ReadNumericStat(rep, { "Defense", "DamageReduction", "Resist" }, false) or 0
	local path = ReadNumericStat(rep, { "PathDistance", "DistanceAlongPath", "Distance", "Dist" }, false)
		or ReadNumericStat(rep, { "PathDistance", "DistanceAlongPath", "Distance", "Dist" }, true)
	local maxHp = ReadNumericStat(rep, MAX_HEALTH_STAT_KEYS, false) or ReadNumericStat(rep, MAX_HEALTH_STAT_KEYS, true) or 0
	return hp or 0, shield, path or -1, defense, maxHp
end

local function get_stats_from_model(model)
	if not model or not model.Parent or not model:IsDescendantOf(workspace) then
		return 0, 0, -1, 0, 0
	end

	local isCorpse = IsCorpseTarget(model, nil)
	local isUmbra = IsUmbraTarget(model, nil)

	if not isCorpse and not isUmbra then
		if
			model:GetAttribute("NoHealth") == true
			or model:GetAttribute("Dead") == true
			or model:GetAttribute("Dying") == true
			or model:GetAttribute("Killed") == true
			or model:GetAttribute("IsDead") == true
		then
			return 0, 0, -1, 0, 0
		end

		local humanoid = model:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then
				return 0, 0, -1, 0, 0
			end
		end
	end

	local hp = ReadNumericStat(model, HEALTH_STAT_KEYS, false) or ReadNumericStat(model, HEALTH_STAT_KEYS, true)
	if hp and hp <= 0 and not isCorpse and not isUmbra then
		return 0, 0, -1, 0, 0
	end

	local shield = ReadNumericStat(model, { "Shield", "Armor" }, false)
		or ReadNumericStat(model, { "Shield", "Armor" }, true)
		or 0

	if (hp or 0) <= 0 and shield <= 0 then
		local humanoid = model:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.Health > 0 then
			hp = humanoid.Health
		elseif isCorpse or isUmbra then
			local fallback = ReadNumericStat(model, HEALTH_STAT_KEYS, true)
				or ReadNumericStat(model, MAX_HEALTH_STAT_KEYS, true)
			if type(fallback) == "number" and fallback > 0 then
				hp = fallback
			else
				return 0, 0, -1, 0, 0
			end
		else
			return 0, 0, -1, 0, 0
		end
	end

	local defense = ReadNumericStat(model, { "Defense", "DamageReduction", "Resist" }, false) or 0
	local path = ReadNumericStat(model, { "PathDistance", "DistanceAlongPath", "Distance", "Dist" }, false)
		or ReadNumericStat(model, { "PathDistance", "DistanceAlongPath", "Distance", "Dist" }, true)
	local maxHp = ReadNumericStat(model, MAX_HEALTH_STAT_KEYS, false) or ReadNumericStat(model, MAX_HEALTH_STAT_KEYS, true) or 0

	return hp or 0, shield, path or -1, defense, maxHp
end

local function get_stats(model, rep)
	if model and (not model.Parent or not model:IsDescendantOf(workspace)) then
		return 0, 0, -1, 0, nil, nil, 0
	end

	rep = rep or GetReplicator(model)
	local isCorpse = IsCorpseTarget(model, rep)
	local isUmbra = IsUmbraTarget(model, rep)
	local npc
	npc, rep = ResolveNPC(model, rep)

	if npc then
		local hp, shield, pathDist, defense, maxHp = get_stats_from_npc(npc)
		if (isCorpse or isUmbra) and hp <= 0 and (shield or 0) <= 0 then
			local fallbackHp = ReadNumericStat(model, HEALTH_STAT_KEYS, true)
				or ReadNumericStat(model, MAX_HEALTH_STAT_KEYS, true)
				or (rep and ReadNumericStat(rep, HEALTH_STAT_KEYS, true))
			if type(fallbackHp) == "number" and fallbackHp > 0 then
				hp = fallbackHp
			end
		end
		if hp <= 0 and (shield or 0) <= 0 then
			if not isCorpse and not isUmbra then
				return 0, 0, pathDist or -1, defense or 0, rep, npc, maxHp or 0
			end
		end
		if (not isCorpse and not isUmbra) and model and model.Parent then
			local hum = model:FindFirstChildOfClass("Humanoid")
			if hum and (hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead) then
				return 0, 0, pathDist or -1, defense or 0, rep, npc, maxHp or 0
			end
		end
		return hp, shield, pathDist, defense, rep, npc, maxHp
	end

	if rep then
		local repHp, repShield, repPath, repDefense, repMax = get_stats_from_rep(rep)
		if (isCorpse or isUmbra) and repHp <= 0 and (repShield or 0) <= 0 then
			local fallbackHp = ReadNumericStat(model, HEALTH_STAT_KEYS, true)
				or ReadNumericStat(model, MAX_HEALTH_STAT_KEYS, true)
				or ReadNumericStat(rep, HEALTH_STAT_KEYS, true)
			if type(fallbackHp) == "number" and fallbackHp > 0 then
				repHp = fallbackHp
			end
		end
		if repHp <= 0 and (repShield or 0) <= 0 then
			if not isCorpse and not isUmbra then
				return 0, 0, repPath or -1, repDefense or 0, rep, nil, repMax or 0
			end
		end
		if (not isCorpse and not isUmbra) and model and model.Parent then
			local hum = model:FindFirstChildOfClass("Humanoid")
			if hum and (hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead) then
				return 0, 0, repPath or -1, repDefense or 0, rep, nil, repMax or 0
			end
		end
		return repHp, repShield, repPath, repDefense, rep, nil, repMax or 0
	end

	local modelHp, modelShield, modelPath, modelDefense, modelMax = get_stats_from_model(model)
	return modelHp or 0, modelShield or 0, modelPath or -1, modelDefense or 0, rep, nil, modelMax or 0
end

local function IsTargetDead(model, rep, npcData)
	if not model or not model.Parent or not model:IsDescendantOf(workspace) then
		return true
	end

	rep = rep or GetReplicator(model)
	local isCorpse = IsCorpseTarget(model, rep)
	local isUmbra = IsUmbraTarget(model, rep)

	if not isCorpse and not isUmbra then
		if
			model:GetAttribute("Dead") == true
			or model:GetAttribute("Dying") == true
			or model:GetAttribute("NoHealth") == true
			or model:GetAttribute("Killed") == true
			or model:GetAttribute("IsDead") == true
		then
			return true
		end
		local hum = model:FindFirstChildOfClass("Humanoid")
		if hum and (hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead) then
			return true
		end
		if rep then
			if not rep.Parent then
				return true
			end
			if
				rep:GetAttribute("Dead") == true
				or rep:GetAttribute("Dying") == true
				or rep:GetAttribute("NoHealth") == true
				or rep:GetAttribute("Killed") == true
				or rep:GetAttribute("IsDead") == true
			then
				return true
			end
		end
		if npcData then
			if npcData.NoHealth == true or npcData.Dead == true or npcData.Dying == true or npcData.Killed == true then
				return true
			end
			if type(npcData.IsAlive) == "function" and not npcData:IsAlive() then
				return true
			end
		end
	end

	local hp, shield = get_stats(model, rep)
	if (hp or 0) <= 0 and (shield or 0) <= 0 then
		return true
	end
	return false
end

local function IsRevived(rep, model)
	if rep and rep:GetAttribute("Revived") == true then
		return true
	end
	if model and model:GetAttribute("Revived") == true then
		return true
	end
	return false
end

local function IsEnemyLead(rep, model, npcData)
	-- Umbra, Vindicator, Void Eye, Corpses, Guardians, Breakers, and Tricksters are NEVER lead modifier enemies
	if (model and (string.find(string.lower(model.Name), "vindicator", 1, true) or IsUmbraTarget(model, rep) or IsEyeTarget(model, rep) or IsCorpseTarget(model, rep) or IsGuardianTarget(model, rep) or IsBreakerTarget(model, rep) or IsTricksterTarget(model, rep)))
		or (rep and (string.find(string.lower(rep.Name), "vindicator", 1, true) or IsUmbraTarget(model, rep) or IsEyeTarget(model, rep) or IsCorpseTarget(model, rep) or IsGuardianTarget(model, rep) or IsBreakerTarget(model, rep) or IsTricksterTarget(model, rep))) then
		return false
	end

	if not rep and model then
		rep = GetReplicator(model)
	end

	if npcData then
		if npcData.StatusEffectRenderer and type(npcData.StatusEffectRenderer.has) == "function" then
			local ok, hasLead = pcall(function()
				return npcData.StatusEffectRenderer:has("Lead")
			end)
			if ok and hasLead then
				return true
			end
		end
		if npcData.StatusEffects and type(npcData.StatusEffects) == "table" then
			for k, v in pairs(npcData.StatusEffects) do
				local lk = string.lower(tostring(k))
				if string.find(lk, "lead", 1, true) or lk == "5" then
					return true
				end
				if type(v) == "string" and string.find(string.lower(v), "lead", 1, true) then
					return true
				end
			end
		end
		if npcData.Modifiers and type(npcData.Modifiers) == "table" then
			for k, v in pairs(npcData.Modifiers) do
				local lk = string.lower(tostring(k))
				if string.find(lk, "lead", 1, true) or lk == "5" then
					return true
				end
				if type(v) == "string" and string.find(string.lower(v), "lead", 1, true) then
					return true
				end
			end
		end
	end

	if rep then
		if rep:GetAttribute("Lead") == true or rep:GetAttribute("LeadModifier") == true or rep:GetAttribute("LeadArmor") == true or rep:GetAttribute("5") == true then
			return true
		end
		local modVal = rep:GetAttribute("Modifier")
		if modVal == 5 or modVal == "5" or modVal == "Lead" or (type(modVal) == "string" and string.find(string.lower(modVal), "lead", 1, true)) then
			return true
		end

		local se = rep:FindFirstChild("StatusEffects")
		if se then
			if se:GetAttribute("Lead") ~= nil and se:GetAttribute("Lead") ~= false then
				return true
			end
			for key, val in pairs(se:GetAttributes()) do
				local lkey = string.lower(tostring(key))
				if (string.find(lkey, "lead", 1, true) or lkey == "5") and not string.find(lkey, "didnodamage", 1, true) then
					return true
				end
				if type(val) == "string" and string.find(string.lower(val), "lead", 1, true) then
					return true
				end
			end
			for _, child in ipairs(se:GetChildren()) do
				if string.find(string.lower(child.Name), "lead", 1, true) or child.Name == "5" then
					return true
				end
			end
		end

		local modsChild = rep:FindFirstChild("Modifiers")
		if modsChild then
			if modsChild:GetAttribute("Lead") ~= nil and modsChild:GetAttribute("Lead") ~= false then
				return true
			end
			if modsChild:GetAttribute("5") == true or modsChild:FindFirstChild("5") then
				return true
			end
			for key, val in pairs(modsChild:GetAttributes()) do
				local lkey = string.lower(tostring(key))
				if (string.find(lkey, "lead", 1, true) or lkey == "5") and not string.find(lkey, "didnodamage", 1, true) then
					return true
				end
				if type(val) == "string" and string.find(string.lower(val), "lead", 1, true) then
					return true
				end
			end
			for _, child in ipairs(modsChild:GetChildren()) do
				if string.find(string.lower(child.Name), "lead", 1, true) or child.Name == "5" then
					return true
				end
			end
		end
	end

	if model then
		if model:GetAttribute("Lead") == true or model:GetAttribute("LeadModifier") == true or model:GetAttribute("LeadArmor") == true or model:GetAttribute("5") == true then
			return true
		end
		local mModVal = model:GetAttribute("Modifier")
		if mModVal == 5 or mModVal == "5" or mModVal == "Lead" or (type(mModVal) == "string" and string.find(string.lower(mModVal), "lead", 1, true)) then
			return true
		end

		local se = model:FindFirstChild("StatusEffects")
		if se then
			if se:GetAttribute("Lead") ~= nil and se:GetAttribute("Lead") ~= false then
				return true
			end
			for key, val in pairs(se:GetAttributes()) do
				local lkey = string.lower(tostring(key))
				if (string.find(lkey, "lead", 1, true) or lkey == "5") and not string.find(lkey, "didnodamage", 1, true) then
					return true
				end
			end
			for _, child in ipairs(se:GetChildren()) do
				if string.find(string.lower(child.Name), "lead", 1, true) or child.Name == "5" then
					return true
				end
			end
		end

		local mods = model:FindFirstChild("Modifiers")
		if mods then
			if mods:GetAttribute("Lead") ~= nil and mods:GetAttribute("Lead") ~= false then
				return true
			end
			if mods:GetAttribute("5") == true or mods:FindFirstChild("5") then
				return true
			end
			for key, val in pairs(mods:GetAttributes()) do
				local lkey = string.lower(tostring(key))
				if (string.find(lkey, "lead", 1, true) or lkey == "5") and not string.find(lkey, "didnodamage", 1, true) then
					return true
				end
			end
			for _, child in ipairs(mods:GetChildren()) do
				if string.find(string.lower(child.Name), "lead", 1, true) or child.Name == "5" then
					return true
				end
			end
		end

		for _, child in ipairs(model:GetChildren()) do
			local clower = string.lower(child.Name)
			if clower == "lead" or clower == "leadarmor" or clower == "leadmodifier" or clower == "leadshield" or clower == "lead_armor" then
				return true
			end
		end
	end

	return false
end

local function CanTowerHitLead(tower)
	if not tower then
		return false
	end
	local rep = tower:FindFirstChild("TowerReplicator")
	if not rep then
		return false
	end

	local se = rep:FindFirstChild("StatusEffects")
	if se then
		if se:GetAttribute("FireworkBuff") ~= nil or se:GetAttribute("LeadDetection") ~= nil or se:GetAttribute("AllDetection") ~= nil then
			return true
		end
		for k, _ in pairs(se:GetAttributes()) do
			local lk = string.lower(tostring(k))
			if string.find(lk, "firework", 1, true) or string.find(lk, "lead", 1, true) then
				return true
			end
		end
	end

	local mods = rep:FindFirstChild("Modifiers")
	if mods then
		if mods:GetAttribute("FireworkBuff") ~= nil or mods:GetAttribute("30") == true or mods:GetAttribute("Lead") ~= nil then
			return true
		end
		for k, _ in pairs(mods:GetAttributes()) do
			local lk = string.lower(tostring(k))
			if string.find(lk, "firework", 1, true) or string.find(lk, "lead", 1, true) then
				return true
			end
		end
	end

	if rep:GetAttribute("FireworkBuff") ~= nil or rep:GetAttribute("Firework") ~= nil or rep:GetAttribute("LeadDetection") == true then
		return true
	end

	local towersFolder = tower.Parent
	if towersFolder and towersFolder.Name == "Towers" then
		local towerHrp = tower:FindFirstChild("HumanoidRootPart")
		local towerPos = towerHrp and towerHrp.Position or (tower:GetPivot() and tower:GetPivot().Position)
		if towerPos then
			for _, otherTower in ipairs(towersFolder:GetChildren()) do
				if otherTower ~= tower then
					local oRep = otherTower:FindFirstChild("TowerReplicator")
					local oName = oRep and oRep:GetAttribute("Name") or otherTower.Name
					if string.find(string.lower(oName), "firework", 1, true) then
						local oHrp = otherTower:FindFirstChild("HumanoidRootPart")
						local oPos = oHrp and oHrp.Position or (otherTower:GetPivot() and otherTower:GetPivot().Position)
						if oPos then
							local fwRange = (oRep and oRep:GetAttribute("Range")) or 12
							if (oPos - towerPos).Magnitude <= (fwRange + 3) then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

local function GetTowerRange(rep)
	if not rep then
		return nil
	end
	local range

	for _, key in ipairs({ "Range", "MaxRange", "AttackRange", "Radius" }) do
		local value = rep:GetAttribute(key)
		if type(value) ~= "number" then
			local obj = rep:FindFirstChild(key)
			if obj and obj:IsA("NumberValue") then
				value = obj.Value
			end
		end
		if type(value) == "number" and value > 0 then
			range = range and math.max(range, value) or value
		end
	end

	if not range then
		return nil
	end

	local buff = rep:GetAttribute("RangeBuff")
	if type(buff) ~= "number" then
		local buffObj = rep:FindFirstChild("RangeBuff")
		if buffObj and buffObj:IsA("NumberValue") then
			buff = buffObj.Value
		end
	end
	if type(buff) == "number" then
		if buff > 0 and buff <= 1 then
			range = range * (1 + buff)
		elseif buff > 1 and buff <= 100 then
			range = range * (1 + (buff / 100))
		elseif buff > 100 then
			range = range + buff
		end
	end

	return range
end

local function GetTowerProjectileSpeed(rep)
	local fallback = getgenv().config.projectileSpeedFallback or 360
	if not rep then
		return fallback
	end

	local speed
	for _, key in ipairs({ "ProjectileSpeed", "BulletSpeed", "MuzzleVelocity", "Velocity" }) do
		local value = rep:GetAttribute(key)
		if type(value) ~= "number" then
			local obj = rep:FindFirstChild(key)
			if obj and obj:IsA("NumberValue") then
				value = obj.Value
			end
		end
		if type(value) == "number" and value > 0 then
			speed = speed and math.max(speed, value) or value
		end
	end

	if not speed then
		speed = fallback
	end
	if speed < (getgenv().config.projectileSpeedMin or 120) then
		speed = fallback
	end
	return speed
end

local function GetTowerDamagePerShot(rep)
	local levelFallback = DAMAGE_VALUES[rep and (rep:GetAttribute("Level") or 0) or 0] or 5
	if not rep then
		return levelFallback
	end

	local baseDamage = ReadNumericStat(rep, { "Damage", "BaseDamage", "AttackDamage", "BulletDamage", "ShotDamage" }, false)
		or ReadNumericStat(rep, { "Damage", "BaseDamage", "AttackDamage", "BulletDamage", "ShotDamage" }, true)
		or levelFallback

	local damageBuff = ReadNumericStat(rep, { "DamageBuff", "DamageBonus", "DamageBoost" }, false)
		or ReadNumericStat(rep, { "DamageBuff", "DamageBonus", "DamageBoost" }, true)
		or 0
	local damageMultiplier = ReadNumericStat(rep, { "DamageMultiplier", "DamageMult", "DamageMulti" }, false)
		or ReadNumericStat(rep, { "DamageMultiplier", "DamageMult", "DamageMulti" }, true)
		or 1

	if damageMultiplier > 0 then
		if damageMultiplier <= 10 then
			baseDamage = baseDamage * damageMultiplier
		elseif damageMultiplier > 10 and damageMultiplier <= 1000 then
			baseDamage = baseDamage * (damageMultiplier / 100)
		end
	end

	if damageBuff ~= 0 then
		if damageBuff > -1 and damageBuff < 1 then
			baseDamage = baseDamage * (1 + damageBuff)
		else
			baseDamage = baseDamage * (1 + (damageBuff / 100))
		end
	end

	return math.max(1, baseDamage)
end

local function GetTargetThreatPressure(targetData, hp, effectiveDmg)
	local cfg = getgenv().config
	local progress = math.clamp(targetData and (targetData.Progress or 0) or 0, 0, 1)
	local dmg = math.max(1, effectiveDmg or 1)
	local hpUnits = math.clamp((hp or 0) / (dmg * 25), 0, 4)
	local hpPressure = hpUnits / 4

	local pressure = (progress * 0.42) + (hpPressure * 0.38)
	if targetData and targetData.IsUmbra then
		pressure += 0.5
	end
	if targetData and targetData.IsVoidPortal then
		pressure += 0.35
	end
	if targetData and targetData.IsTrickster then
		pressure += 0.4
	end
	if targetData and targetData.IsSpecial then
		pressure += 0.14
	end
	if targetData and targetData.IsCrystal then
		pressure += 0.2
	end

	local nearThreshold = cfg.nearEndProgressThreshold or 0.8
	if cfg.nearEndPriority and progress >= nearThreshold then
		pressure += 0.2 + ((progress - nearThreshold) * 0.9)
	end

	return math.clamp(pressure, 0, 1.35)
end

local function GetDynamicShotsNeeded(targetData, hp, effectiveDmg)
	if not hp or hp <= 0 then
		return 0
	end
	local cfg = getgenv().config
	local dmg = math.max(1, effectiveDmg or 1)
	local baseShots = math.max(1, math.ceil((hp or 0) / dmg))
	if cfg.dynamicMultiplier == false then
		return baseShots
	end

	local pressure = GetTargetThreatPressure(targetData, hp, dmg)
	local floorMult = math.max(1, tonumber(cfg.dynamicMultiplierFloor) or 1)
	local ceilingMult = math.max(floorMult, tonumber(cfg.dynamicMultiplierCeiling) or 5.8)
	local multiplier = floorMult + ((ceilingMult - floorMult) * math.clamp(pressure, 0, 1))

	if (hp or 0) <= (dmg * 1.1) then
		multiplier = 1
	elseif (hp or 0) <= (dmg * 3) then
		multiplier = math.min(multiplier, 1.2)
	end

	local shotFloor = math.max(1, math.floor(cfg.dynamicShotFloor or 1))
	local shotCeiling = math.max(shotFloor, math.floor(cfg.dynamicShotCeiling or 260))
	local scaledShots = math.ceil(baseShots * multiplier)
	return math.clamp(scaledShots, shotFloor, shotCeiling)
end

local PendingDamageByTarget = setmetatable({}, { __mode = "k" })

local function PrunePendingDamage(targetModel, now, window)
	if not targetModel then
		return 0
	end

	local state = PendingDamageByTarget[targetModel]
	if not state or not state.entries then
		return 0
	end

	local entries = state.entries
	local writeIndex = 1
	local total = 0

	for readIndex = 1, #entries do
		local entry = entries[readIndex]
		if entry and (now - (entry.t or now)) <= window then
			entries[writeIndex] = entry
			writeIndex += 1
			total += tonumber(entry.d) or 0
		end
	end

	for i = writeIndex, #entries do
		entries[i] = nil
	end

	if writeIndex == 1 then
		PendingDamageByTarget[targetModel] = nil
	end

	return total
end

local function GetPendingDamage(targetModel)
	local cfg = getgenv().config
	local window = math.clamp(tonumber(cfg.autoCaliberPendingWindow) or 0.2, 0.05, 0.5)
	return PrunePendingDamage(targetModel, os.clock(), window)
end

local function AddPendingDamage(targetModel, damage)
	if not targetModel then
		return
	end

	local dmg = tonumber(damage) or 0
	if dmg <= 0 then
		return
	end

	local cfg = getgenv().config
	local window = math.clamp(tonumber(cfg.autoCaliberPendingWindow) or 0.2, 0.05, 0.5)
	local now = os.clock()
	local state = PendingDamageByTarget[targetModel]
	if not state then
		state = { entries = {} }
		PendingDamageByTarget[targetModel] = state
	end

	PrunePendingDamage(targetModel, now, window)
	state = PendingDamageByTarget[targetModel]
	if not state then
		state = { entries = {} }
		PendingDamageByTarget[targetModel] = state
	end
	table.insert(state.entries, { t = now, d = dmg })
end

local function GetConservativeAutoCaliberShots(hp, effectiveDmg)
	local dmg = math.max(1, effectiveDmg or 1)
	local hpNow = math.max(0, hp or 0)
	if hpNow <= 0 then
		return 0
	end

	return math.max(1, math.ceil(hpNow / dmg))
end

local function GetAutoCaliberBoostMultiplier(targetData, hp, effectiveDmg)
	local cfg = getgenv().config
	if cfg.autoCaliberDpsBoost == false then
		return 1
	end

	local dmg = math.max(1, effectiveDmg or 1)
	local hpRatio = math.max(0, hp or 0) / dmg
	local startShots = math.max(8, tonumber(cfg.autoCaliberBoostStartShots) or 30)
	if hpRatio <= startShots then
		return 1
	end

	local fullShots = math.max(startShots + 1, tonumber(cfg.autoCaliberBoostFullShots) or 190)
	local strength = math.clamp((hpRatio - startShots) / (fullShots - startShots), 0, 1)
	local pressure = GetTargetThreatPressure(targetData, hp, dmg)
	local pressureFactor = math.clamp((pressure - 0.22) / 0.95, 0, 1)
	local blend = math.clamp((strength * 0.72) + (pressureFactor * 0.28), 0, 1)

	local minMult = math.max(1, tonumber(cfg.autoCaliberBoostMinMultiplier) or 1)
	local maxMult = math.max(minMult, tonumber(cfg.autoCaliberBoostMaxMultiplier) or 3.8)
	local mult = minMult + ((maxMult - minMult) * blend)

	if targetData and targetData.IsUmbra then
		mult = mult * 1.45
	end
	if targetData and (targetData.IsVoidPortal or targetData.IsEye) then
		mult = mult * 1.3
	end
	if targetData and targetData.IsTrickster then
		mult = mult * 1.35
	end
	if targetData and targetData.IsSpecial then
		mult = mult * 1.12
	end
	if targetData and targetData.IsCrystal then
		mult = mult * 1.18
	end

	return math.max(1, mult)
end

local function GetAutoCaliberBoostedShots(targetData, hp, effectiveDmg)
	if not hp or hp <= 0 then
		return 0
	end
	local baseShots = GetConservativeAutoCaliberShots(hp, effectiveDmg)
	if baseShots <= 0 then
		return 0
	end

	local cfg = getgenv().config
	local mult = GetAutoCaliberBoostMultiplier(targetData, hp, effectiveDmg)
	local boosted = math.max(1, math.ceil(baseShots * mult))
	local cap = math.max(baseShots, math.floor(cfg.autoCaliberBoostShotCap or 420))
	return math.clamp(boosted, 1, cap)
end

local function GetDynamicShotBudget(currentAmmo, targetData, effectiveDmg)
	local cfg = getgenv().config
	local minBudget = math.max(20, math.floor(cfg.dynamicBudgetMin or 40))
	local maxBudget = math.max(minBudget, math.floor(cfg.dynamicBudgetMax or 180))
	local budget = minBudget

	if targetData then
		local hp = math.max(0, targetData.HP or 0)
		local dmg = math.max(1, effectiveDmg or 1)
		local pressure = GetTargetThreatPressure(targetData, hp, dmg)
		budget = math.floor(minBudget + ((maxBudget - minBudget) * math.clamp(pressure, 0, 1)))
		if hp > (dmg * 120) or targetData.IsUmbra then
			budget = maxBudget
		end
		if cfg.autoCaliber and cfg.autoCaliberDpsBoost ~= false then
			local startShots = math.max(8, tonumber(cfg.autoCaliberBoostStartShots) or 30)
			local fullShots = math.max(startShots + 1, tonumber(cfg.autoCaliberBoostFullShots) or 190)
			local hpRatio = hp / dmg
			if hpRatio > startShots then
				local strength = math.clamp((hpRatio - startShots) / (fullShots - startShots), 0, 1)
				local boostBudget = math.floor((maxBudget - minBudget) * (0.25 + (0.45 * strength)))
				budget = math.min(maxBudget, budget + boostBudget)
			end
		end
	end

	if type(currentAmmo) == "number" then
		budget = math.max(1, math.min(budget, currentAmmo))
	end
	return budget
end

local function GetDynamicLoopDelay(targetData, effectiveDmg, shotsFired, maxBudget)
	local cfg = getgenv().config
	local minRate = math.max(1, tonumber(cfg.minFireRate) or 14)
	local maxRate = math.max(minRate, tonumber(cfg.maxFireRate) or 170)
	local baseRate = math.clamp(tonumber(cfg.baseFireRate) or 26, minRate, maxRate)
	local rate = baseRate

	if cfg.dynamicFireRate ~= false and targetData then
		local hp = math.max(0, targetData.HP or 0)
		local pressure = GetTargetThreatPressure(targetData, hp, math.max(1, effectiveDmg or 1))
		rate = baseRate + ((maxRate - baseRate) * math.clamp(pressure, 0, 1))
		if targetData.IsUmbra then
			rate = maxRate
		elseif targetData.IsVoidPortal or targetData.IsEye then
			rate *= 1.25
		elseif targetData.IsTrickster then
			rate *= 1.3
		elseif targetData.IsSpecial then
			rate *= 1.1
		elseif targetData.IsCrystal then
			rate *= 1.16
		end
	end

	if maxBudget and maxBudget > 0 then
		local usage = shotsFired / maxBudget
		if usage < 0.25 then
			rate *= 0.88
		elseif usage > 0.85 then
			rate *= 1.08
		end
	end

	rate = math.clamp(rate, minRate, maxRate)
	return 1 / rate
end

local function SolveInterceptTime(relPos, relVel, projSpeed)
	if not relPos or not relVel or projSpeed <= 0 then
		return nil
	end

	local a = relVel:Dot(relVel) - (projSpeed * projSpeed)
	local b = 2 * relPos:Dot(relVel)
	local c = relPos:Dot(relPos)

	if math.abs(a) < 1e-6 then
		if math.abs(b) < 1e-6 then
			return nil
		end
		local t = -c / b
		if t > 0 then
			return t
		end
		return nil
	end

	local disc = (b * b) - (4 * a * c)
	if disc < 0 then
		return nil
	end

	local sqrtDisc = math.sqrt(disc)
	local t1 = (-b - sqrtDisc) / (2 * a)
	local t2 = (-b + sqrtDisc) / (2 * a)

	if t1 > 0 and t2 > 0 then
		return math.min(t1, t2)
	end
	if t1 > 0 then
		return t1
	end
	if t2 > 0 then
		return t2
	end
	return nil
end

local function GetSmoothedMotion(hrp)
	if not hrp then
		return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), 0
	end

	local now = os.clock()
	local cfg = getgenv().config
	local smoothFactor = math.clamp(cfg.velocitySmoothFactor or 0.35, 0.05, 0.95)
	local verticalScale = math.clamp(cfg.verticalLeadScale or 0.2, 0, 1)

	local pos = hrp.Position
	local raw = hrp.AssemblyLinearVelocity
	local velocity = Vector3.new(raw.X, raw.Y * verticalScale, raw.Z)
	local prev = MotionCache[hrp]

	if not prev then
		MotionCache[hrp] = {
			t = now,
			v = velocity,
			a = Vector3.new(0, 0, 0),
			p = pos,
			lastSeen = now,
		}
		return velocity, Vector3.new(0, 0, 0), velocity.Magnitude
	end

	local dt = now - (prev.t or now)
	if dt <= 0 or dt > 1 then
		dt = 1 / 60
	end

	local blendedVel = velocity
	if cfg.useDeltaVelocity ~= false and prev.p then
		local delta = (pos - prev.p) / dt
		delta = Vector3.new(delta.X, delta.Y * verticalScale, delta.Z)
		local maxDelta = cfg.deltaVelocityMax or 220
		if delta.Magnitude > maxDelta and delta.Magnitude > 0 then
			delta = delta.Unit * maxDelta
		end
		local velMag = velocity.Magnitude
		local deltaMag = delta.Magnitude
		if velMag < 0.5 and deltaMag > 0.5 then
			blendedVel = delta
		elseif deltaMag > velMag * 1.35 then
			blendedVel = velocity:Lerp(delta, 0.7)
		end
	end

	local smoothVel
	if prev.v.Magnitude < 0.5 and blendedVel.Magnitude >= 0.5 then
		smoothVel = blendedVel
	else
		smoothVel = prev.v:Lerp(blendedVel, smoothFactor)
	end
	local accel = (smoothVel - prev.v) / dt

	prev.t = now
	prev.v = smoothVel
	prev.a = accel
	prev.p = pos
	prev.lastSeen = now

	MotionSampleCounter = MotionSampleCounter + 1
	if MotionSampleCounter % 120 == 0 then
		for trackedPart, trackedData in pairs(MotionCache) do
			if not trackedPart or not trackedPart.Parent or (now - (trackedData.lastSeen or now)) > 4 then
				MotionCache[trackedPart] = nil
			end
		end
		for trackedPart, trackedData in pairs(AimErrorCache) do
			if not trackedPart or not trackedPart.Parent or (now - (trackedData.lastSeen or now)) > 4 then
				AimErrorCache[trackedPart] = nil
			end
		end
	end

	return smoothVel, accel, smoothVel.Magnitude
end

local function GetAimErrorBias(hrp, rawAimPos, speed, dist)
	local cfg = getgenv().config
	if cfg.aimErrorCompensation == false or not hrp then
		return Vector3.new(0, 0, 0)
	end

	local now = os.clock()
	local cache = AimErrorCache[hrp]
	if not cache then
		AimErrorCache[hrp] = {
			lastAim = rawAimPos,
			lastTime = now,
			bias = Vector3.new(0, 0, 0),
			lastSeen = now,
		}
		return Vector3.new(0, 0, 0)
	end

	local dt = now - (cache.lastTime or now)
	if dt <= 0 or dt > 1 then
		dt = 1 / 60
	end

	local observed = hrp.Position - (cache.lastAim or hrp.Position)
	local dynamicMax = math.max(0.45, (speed * dt * 1.5) + 0.35)
	local hardMax = cfg.aimErrorMax or 3.5
	local maxErr = math.min(hardMax, dynamicMax)
	if observed.Magnitude > maxErr and observed.Magnitude > 0 then
		observed = observed.Unit * maxErr
	end

	local decay = math.clamp(cfg.aimErrorDecay or 0.92, 0, 0.999)
	local learn = math.clamp(cfg.aimErrorLearnRate or 0.25, 0.01, 1)
	local bias = (cache.bias or Vector3.new(0, 0, 0)) * decay
	bias = bias:Lerp(observed, learn)
	if bias.Magnitude > hardMax and bias.Magnitude > 0 then
		bias = bias.Unit * hardMax
	end

	cache.bias = bias
	cache.lastAim = rawAimPos
	cache.lastTime = now
	cache.lastSeen = now

	local distScale = math.clamp((dist or 0) / 35, 0.2, 1.15)
	return bias * distScale
end

local function GetLiveAimPosition(targetData, towerPos, towerReplicator)
	if not targetData then
		return nil
	end
	local hrp = targetData.HRP
	if not hrp or not hrp.Parent then
		local fallbackPos = targetData.PivotPos
		local model = targetData.Model
		if model and model.Parent then
			local ok, cf = pcall(function()
				return model:GetPivot()
			end)
			if ok and cf then
				fallbackPos = cf.Position
			end
		end
		local fallbackDist = towerPos and (fallbackPos - towerPos).Magnitude or 0
		return fallbackPos, 0, Vector3.new(0, 0, 0), fallbackDist, 1
	end

	local cfg = getgenv().config
	local targetPos = hrp.Position
	local dist = towerPos and (targetPos - towerPos).Magnitude or 0
	local velocity, acceleration, speed = GetSmoothedMotion(hrp)
	local isStopped = (targetData.Replicator and targetData.Replicator:GetAttribute("Stopped") == true)
		or (targetData.Model and targetData.Model:GetAttribute("Stopped") == true)
	if targetData.IsUmbra == true or targetData.IsVoidPortal == true or targetData.IsCrystal == true or targetData.IsSpecial == true or targetData.IsCorpse == true or targetData.IsEye == true or isStopped or (hrp and (hrp.Name == "Eye" or hrp.Name == "Hitbox")) then
		return targetPos, 0, Vector3.new(0, 0, 0), dist, 1
	end

	local closeThreshold = cfg.closeRangeThreshold or 14
	local closeFactor = 1
	if cfg.closeAimCompensation ~= false then
		closeFactor = math.clamp(dist / math.max(closeThreshold, 0.01), 0.08, 1)
	end
	if cfg.disablePrediction == true then
		return targetPos, speed, velocity, dist, closeFactor
	end

	if speed < 1 then
		local lowSpeedBias = GetAimErrorBias(hrp, targetPos, speed, dist)
		return targetPos + lowSpeedBias, speed, velocity, dist, closeFactor
	end

	local base = cfg.predictionBase or 0.018
	local scale = cfg.predictionDistanceScale or 0.001
	local maxTime = cfg.predictionMaxTime or 0.11
	local maxLead = cfg.predictionMaxLead or 6.5
	local fastThreshold = cfg.fastSpeedThreshold or 30

	local projectileSpeed = GetTowerProjectileSpeed(towerReplicator)
	local leadTime
	local usedIntercept = false

	if cfg.useIntercept ~= false then
		leadTime = SolveInterceptTime(targetPos - towerPos, velocity, projectileSpeed)
		if leadTime and leadTime > 0 then
			usedIntercept = true
		else
			leadTime = nil
		end
	end

	if not leadTime then
		local timeFromDistance = dist / math.max(projectileSpeed, 1)
		leadTime = base + (dist * scale) + timeFromDistance

		if cfg.fastAim and speed >= fastThreshold then
			local speedFactor = math.clamp((speed - fastThreshold) / math.max(fastThreshold, 1), 0, 2.5)
			leadTime = leadTime + ((cfg.fastExtraLeadTime or 0.03) * (1 + speedFactor))
		end
	end

	if cfg.closeAimCompensation ~= false and dist < closeThreshold then
		local closeLeadScale = cfg.closeLeadScale or 0.3
		local leadScale = closeLeadScale + ((1 - closeLeadScale) * closeFactor)
		leadTime = leadTime * leadScale
		maxLead = maxLead * (0.65 + (0.35 * closeFactor))
	end

	if usedIntercept then
		leadTime = math.max(leadTime, 0.01)
	else
		leadTime = math.clamp(leadTime, 0.01, maxTime)
	end
	local accelWeight = cfg.accelLeadWeight or 0.55
	local lead = (velocity * leadTime) + (acceleration * (0.5 * leadTime * leadTime * accelWeight))

	if lead.Magnitude > maxLead then
		lead = lead.Unit * maxLead
	end

	if not usedIntercept and cfg.pierceLogic and speed > 8 and speed < fastThreshold and velocity.Magnitude > 0.05 then
		lead = lead - (velocity.Unit * (0.15 + ((1 - closeFactor) * 0.08)))
	end

	local rawAimPos = targetPos + lead
	local aimPos = rawAimPos
	if speed < 1 then
		local errorBias = GetAimErrorBias(hrp, rawAimPos, speed, dist)
		aimPos = rawAimPos + errorBias
	end

	if cfg.closeAimCompensation ~= false then
		local centerBias = math.clamp(cfg.closeCenterBias or 0.88, 0, 0.98)
		local centerMix = centerBias * (1 - closeFactor) * 0.35
		aimPos = aimPos:Lerp(targetPos, centerMix)
	end

	return aimPos, speed, velocity, dist, closeFactor
end

local function GetESPMode()
	local mode = getgenv().config.espMode
	if mode == "Off" or mode == "Chams" or mode == "CSGO" then
		return mode
	end
	if getgenv().config.chams == false then
		return "Off"
	end
	return "Chams"
end

local function EnsureModelPartsHighlightable(model)
	if not model or not model.Parent then return end
	local bodyPartNames = {
		["Torso"] = true, ["UpperTorso"] = true, ["LowerTorso"] = true,
		["Head"] = true,
		["Left Leg"] = true, ["Right Leg"] = true,
		["Left Arm"] = true, ["Right Arm"] = true,
		["LeftLowerLeg"] = true, ["RightLowerLeg"] = true,
		["LeftUpperLeg"] = true, ["RightUpperLeg"] = true,
		["LeftLowerArm"] = true, ["RightLowerArm"] = true,
		["LeftUpperArm"] = true, ["RightUpperArm"] = true,
		["Character"] = true,
	}
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("BasePart") then
			if bodyPartNames[desc.Name] and desc.Transparency >= 1 then
				desc.Transparency = 0.99
			end
		end
	end
end

local function GetChamsEntry(i)
	local hl = ChamsPool[i]
	if not hl then
		hl = Instance.new("Highlight")
		hl.Name = "EspRainbowHighlight"
		hl.FillTransparency = 0.5
		hl.OutlineTransparency = 0.1
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Enabled = false
		hl.Parent = EspFolder
		ChamsPool[i] = hl
	end
	return hl
end

local function GetCsgoEntry(i)
	local entry = CsgoPool[i]
	if not entry then
		local outline = Instance.new("SelectionBox")
		outline.Name = "EspBoxOutline"
		outline.Color3 = Color3.fromRGB(0, 0, 0)
		outline.LineThickness = 0.08
		outline.SurfaceTransparency = 1
		outline.Parent = EspFolder

		local box = Instance.new("SelectionBox")
		box.Name = "EspRainbowBox"
		box.LineThickness = 0.045
		box.SurfaceTransparency = 1
		box.Parent = EspFolder

		local tag = Instance.new("BillboardGui")
		tag.Name = "EspTag"
		tag.AlwaysOnTop = true
		tag.Size = UDim2.fromOffset(190, 48)
		tag.StudsOffset = Vector3.new(0, 3.8, 0)
		tag.ClipsDescendants = false
		tag.Enabled = false
		tag.Parent = EspFolder

		local nameLbl = Instance.new("TextLabel")
		nameLbl.Name = "NameLabel"
		nameLbl.Size = UDim2.new(1, 0, 0, 18)
		nameLbl.BackgroundTransparency = 1
		nameLbl.Font = Enum.Font.GothamBold
		nameLbl.TextSize = 12
		nameLbl.TextStrokeTransparency = 0.45
		nameLbl.Parent = tag

		local infoLbl = Instance.new("TextLabel")
		infoLbl.Name = "InfoLabel"
		infoLbl.Position = UDim2.new(0, 0, 0, 16)
		infoLbl.Size = UDim2.new(1, 0, 0, 16)
		infoLbl.BackgroundTransparency = 1
		infoLbl.Font = Enum.Font.GothamSemibold
		infoLbl.TextSize = 11
		infoLbl.TextStrokeTransparency = 0.5
		infoLbl.Parent = tag

		local healthBg = Instance.new("Frame")
		healthBg.Position = UDim2.new(0.15, 0, 1, -8)
		healthBg.Size = UDim2.new(0.7, 0, 0, 4)
		healthBg.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		healthBg.BorderSizePixel = 0
		healthBg.Parent = tag

		local healthFill = Instance.new("Frame")
		healthFill.BorderSizePixel = 0
		healthFill.Parent = healthBg

		entry = {
			outline = outline,
			box = box,
			tag = tag,
			nameLbl = nameLbl,
			infoLbl = infoLbl,
			healthFill = healthFill,
		}
		CsgoPool[i] = entry
	end
	return entry
end

local LastEspUpdateTick = 0
local function UpdateTargetESP(targets, activeTower)
	local now = os.clock()
	if (now - LastEspUpdateTick) < 0.065 then
		return
	end
	LastEspUpdateTick = now

	if activeTower and IsGatlingReloading(activeTower) then
		ClearTargetESP()
		return
	end
	local mode = GetESPMode()
	if mode == "Off" then
		ClearTargetESP()
		return
	end

	local maxCount = math.clamp(math.floor(tonumber(getgenv().config.maxTargets or getgenv().config.maxTarget) or 5), 1, 5)

	if mode == "Chams" then
		for _, entry in pairs(CsgoPool) do
			if entry.outline then entry.outline.Adornee = nil end
			if entry.box then entry.box.Adornee = nil end
			if entry.tag then
				entry.tag.Adornee = nil
				entry.tag.Enabled = false
			end
		end

		for i = 1, MAX_ESP_POOL do
			local hl = GetChamsEntry(i)
			local tData = (i <= maxCount) and targets[i] or nil
			local model = tData and tData.Model
			if model and model.Parent and (not (tData.HP and tData.HP <= 0)) and (not IsTargetDead(model, tData.Replicator, tData.NPC)) then
				EnsureModelPartsHighlightable(model)
				local rainbowOffset = (i - 1) * 0.18
				local rainbowColor = GetRainbowColor(rainbowOffset)
				hl.Adornee = model
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.Enabled = true
				if getgenv().config.rainbowESP ~= false then
					hl.FillColor = rainbowColor
					hl.OutlineColor = rainbowColor
					hl:SetAttribute("RainbowOffset", rainbowOffset)
				else
					hl.FillColor = THEME.Accent
					hl.OutlineColor = THEME.Accent
				end
			else
				hl.Adornee = nil
				hl.Enabled = false
			end
		end
	else -- CSGO
		for _, hl in pairs(ChamsPool) do
			hl.Adornee = nil
			hl.Enabled = false
		end

		for i = 1, MAX_ESP_POOL do
			local entry = GetCsgoEntry(i)
			local tData = (i <= maxCount) and targets[i] or nil
			local model = tData and tData.Model
			local hrp = tData and tData.HRP
			if model and model.Parent and hrp and hrp.Parent and (not (tData.HP and tData.HP <= 0)) and (not IsTargetDead(model, tData.Replicator, tData.NPC)) then
				EnsureModelPartsHighlightable(model)
				local hpNow = math.max(0, tData.HP or 0)
				local hpMax = math.max(hpNow, tData.MaxHP or hpNow)
				local hpRatio = hpMax > 0 and math.clamp(hpNow / hpMax, 0, 1) or 0
				local hpColor = Color3.fromRGB(math.floor(255 * (1 - hpRatio)), math.floor(255 * hpRatio), 70)
				local rainbowOffset = (i - 1) * 0.18
				local rainbowColor = GetRainbowColor(rainbowOffset)

				entry.outline.Adornee = model
				entry.box.Adornee = model
				entry.tag.Adornee = hrp
				entry.tag.Enabled = true

				if getgenv().config.rainbowESP ~= false then
					entry.box.Color3 = rainbowColor
					entry.box:SetAttribute("RainbowOffset", rainbowOffset)
					entry.nameLbl.TextColor3 = rainbowColor
					entry.nameLbl:SetAttribute("RainbowOffset", rainbowOffset)
				else
					entry.box.Color3 = hpColor
					entry.nameLbl.TextColor3 = Color3.new(1, 1, 1)
					entry.nameLbl:SetAttribute("RainbowOffset", nil)
				end

				local umbraTag = tData.IsUmbra and " [UMBRA]" or ""
				local leadTag = tData.IsLead and " [LEAD]" or ""
				local tricksterTag = tData.IsTrickster and " [TRICKSTER]" or ""
				local portalTag = tData.IsVoidPortal and " [PORTAL]" or ""
				local corpseTag = tData.IsCorpse and " [CORPSE]" or ""
				local breakerTag = tData.IsBreaker and " [BREAKER]" or ""
				local guardianTag = tData.IsGuardian and " [GUARDIAN]" or ""
				entry.nameLbl.Text = string.upper(model.Name) .. umbraTag .. leadTag .. tricksterTag .. portalTag .. corpseTag .. breakerTag .. guardianTag
				entry.infoLbl.TextColor3 = hpColor
				entry.infoLbl.Text = string.format("HP %d | %.0f studs", math.floor(hpNow), tData.DistToTower or 0)
				entry.healthFill.Size = UDim2.new(hpRatio, 0, 1, 0)
				entry.healthFill.BackgroundColor3 = hpColor
			else
				entry.outline.Adornee = nil
				entry.box.Adornee = nil
				entry.tag.Adornee = nil
				entry.tag.Enabled = false
			end
		end
	end
end

if getgenv().RainbowESPConnection then
	pcall(function()
		getgenv().RainbowESPConnection:Disconnect()
	end)
	getgenv().RainbowESPConnection = nil
end

local LastRainbowEspTick = 0
getgenv().RainbowESPConnection = RunService.RenderStepped:Connect(function()
	if getgenv().config and getgenv().config.rainbowESP == false then
		return
	end
	local now = os.clock()
	if (now - LastRainbowEspTick) < 0.033 then
		return
	end
	LastRainbowEspTick = now

	for i = 1, MAX_ESP_POOL do
		local hl = ChamsPool[i]
		if hl and hl.Enabled and hl.Adornee then
			local offset = hl:GetAttribute("RainbowOffset") or 0
			local col = Color3.fromHSV((now * 0.75 + offset) % 1, 1, 1)
			hl.FillColor = col
			hl.OutlineColor = col
		end

		local entry = CsgoPool[i]
		if entry and entry.tag and entry.tag.Enabled and entry.tag.Adornee then
			local offset = entry.box:GetAttribute("RainbowOffset") or 0
			local col = Color3.fromHSV((now * 0.75 + offset) % 1, 1, 1)
			entry.box.Color3 = col
			entry.nameLbl.TextColor3 = col
		end
	end
end)

local function BuildThreatMetrics(candidates)
	local pathMin, pathMax = math.huge, -math.huge
	local distMin, distMax = math.huge, -math.huge
	local hpMax = 1

	for _, c in ipairs(candidates) do
		if c.Path and c.Path > -1 then
			if c.Path < pathMin then
				pathMin = c.Path
			end
			if c.Path > pathMax then
				pathMax = c.Path
			end
		end
		if c.DistToBase < distMin then
			distMin = c.DistToBase
		end
		if c.DistToBase > distMax then
			distMax = c.DistToBase
		end
		if c.HP > hpMax then
			hpMax = c.HP
		end
	end

	local hasPathRange = pathMin ~= math.huge and pathMax > pathMin
	local distRange = (distMax > distMin) and (distMax - distMin) or 1
	local hpLogMax = math.log(hpMax + 1)
	if hpLogMax <= 0 then
		hpLogMax = 1
	end

	for _, c in ipairs(candidates) do
		local progress
		if hasPathRange and c.Path and c.Path > -1 then
			progress = (c.Path - pathMin) / (pathMax - pathMin)
		elseif c.Path and c.Path > -1 then
			progress = 0.5
		else
			progress = 1 - ((c.DistToBase - distMin) / distRange)
		end
		c.Progress = math.clamp(progress or 0, 0, 1)
		c.HPFactor = math.clamp(math.log((c.HP or 0) + 1) / hpLogMax, 0, 1)
	end
end

local RawEnemyCache = {
	lastScan = 0,
	candidates = {},
}

local function GetRawEnemyCandidates()
	local now = os.clock()
	if (now - RawEnemyCache.lastScan) < 0.035 and #RawEnemyCache.candidates > 0 then
		return RawEnemyCache.candidates
	end

	local candidates = {}
	local processedModels = {}
	local indexedModelsByName = {}
	local indexedModelsByReplicator = {}
	local cfg = getgenv().config
	local basePos = get_base_position()
	local npcRootFolder = workspace:FindFirstChild("NPCs")
	local enemiesFolder = workspace:FindFirstChild("Enemies")

	local function IndexModel(model)
		if not model or not model:IsA("Model") then
			return
		end
		local normalized = NormalizeLookupName(model.Name)
		if normalized == "" then
			return
		end
		local bucket = indexedModelsByName[normalized]
		if not bucket then
			bucket = {}
			indexedModelsByName[normalized] = bucket
		end
		table.insert(bucket, model)

		local ptr = model:FindFirstChild("RootPointer")
		if ptr and ptr:IsA("ObjectValue") and ptr.Value then
			indexedModelsByReplicator[ptr.Value] = model
		else
			local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart")
			if hrp then
				local hrpPtr = hrp:FindFirstChild("RootPointer")
				if hrpPtr and hrpPtr:IsA("ObjectValue") and hrpPtr.Value then
					indexedModelsByReplicator[hrpPtr.Value] = model
				end
			end
		end
	end

	local function FindModelForRep(rep)
		local npcFromRep = GetNPCFromFolder(rep)
		if npcFromRep and npcFromRep.Model and npcFromRep.Model.Parent then
			return npcFromRep.Model
		end

		local byPointer = indexedModelsByReplicator[rep]
		if byPointer and byPointer.Parent then
			return byPointer
		end

		local repName = rep:GetAttribute("ModelName") or rep:GetAttribute("Name") or rep.Name
		local normalizedRepName = NormalizeLookupName(repName)
		if normalizedRepName ~= "" then
			local exactBucket = indexedModelsByName[normalizedRepName]
			if exactBucket and exactBucket[1] then
				return exactBucket[1]
			end
		end

		local direct = (npcRootFolder and (npcRootFolder:FindFirstChild(repName, true) or npcRootFolder:FindFirstChild(rep.Name, true)))
			or (enemiesFolder and (enemiesFolder:FindFirstChild(repName, true) or enemiesFolder:FindFirstChild(rep.Name, true)))
			or workspace:FindFirstChild(repName, true)
		if direct and direct:IsA("Model") then
			local ptr = direct:FindFirstChild("RootPointer")
			if not ptr or not ptr:IsA("ObjectValue") or ptr.Value == rep then
				return direct
			end
		end

		if normalizedRepName ~= "" then
			local bestModel, bestScore = nil, -1
			for normalizedModelName, bucket in pairs(indexedModelsByName) do
				if
					string.find(normalizedModelName, normalizedRepName, 1, true)
					or string.find(normalizedRepName, normalizedModelName, 1, true)
				then
					local score = math.min(#normalizedModelName, #normalizedRepName)
					if score > bestScore and bucket[1] then
						bestModel = bucket[1]
						bestScore = score
					end
				end
			end
			if bestModel then
				return bestModel
			end
		end

		return nil
	end

	local function AddCandidate(model, rep)
		if
			(not model)
			or (not model:IsA("Model"))
			or (not model.Parent)
			or (not model:IsDescendantOf(workspace))
			or processedModels[model]
			or (npcRootFolder and model.Parent == npcRootFolder and (model.Name == "Red" or model.Name == "Blue"))
		then
			return
		end

		if IsTargetDead(model, rep) then
			return
		end

		local hp, shield, pathDist, defense, resolvedRep, npcData, maxHp = get_stats(model, rep)
		local targetModel = (npcData and npcData.Model and npcData.Model.Parent and npcData.Model) or model
		if processedModels[targetModel] then
			return
		end

		if IsTargetDead(targetModel, resolvedRep, npcData) then
			return
		end

		if cfg.ignoreHolograms ~= false and IsHologramEnemy(targetModel, resolvedRep, npcData) then
			return
		end

		local isUmbraTarget = IsUmbraTarget(targetModel, resolvedRep)
		local isVoidPortalTarget = IsVoidPortalTarget(targetModel, resolvedRep)
		local isCrystalTarget = IsCrystalTarget(targetModel, resolvedRep)
		local isCorpseTarget = IsCorpseTarget(targetModel, resolvedRep)
		local isEyeTarget = IsEyeTarget(targetModel, resolvedRep)
		local npcName = npcData and npcData.Name
		if (not isUmbraTarget) and npcName and string.find(string.lower(npcName), "umbra", 1, true) ~= nil then
			isUmbraTarget = true
		end
		if (not isVoidPortalTarget) and npcName and HasPortalKeyword(npcName) then
			isVoidPortalTarget = true
		end
		if (not isCrystalTarget) and npcName and HasCrystalKeyword(npcName) then
			isCrystalTarget = true
		end
		if (not isCorpseTarget) and npcName and HasCorpseKeyword(npcName) then
			isCorpseTarget = true
		end
		if (not isEyeTarget) and npcName and (string.find(string.lower(npcName), "eye", 1, true) ~= nil) then
			isEyeTarget = true
		end
		local isBreakerTarget = IsBreakerTarget(targetModel, resolvedRep)
		if (not isBreakerTarget) and npcName and (string.find(string.lower(npcName), "breaker", 1, true) ~= nil) then
			isBreakerTarget = true
		end
		local isGuardianTarget = IsGuardianTarget(targetModel, resolvedRep)
		if (not isGuardianTarget) and npcName and (string.find(string.lower(npcName), "guardian", 1, true) ~= nil) then
			isGuardianTarget = true
		end
		local isTricksterTarget = IsTricksterTarget(targetModel, resolvedRep)
		if (not isTricksterTarget) and npcName and (string.find(string.lower(npcName), "trickster", 1, true) ~= nil) then
			isTricksterTarget = true
		end
		local isSpecialTarget = isUmbraTarget or isVoidPortalTarget or isCrystalTarget or isCorpseTarget or isEyeTarget or IsSpecialSpawnTarget(targetModel, resolvedRep)

		local hrp = FindTargetPart(targetModel, npcData)

		local pivotPos
		if hrp then
			pivotPos = hrp.Position
		else
			local ok, cf = pcall(function()
				return targetModel:GetPivot()
			end)
			if ok and cf then
				pivotPos = cf.Position
			else
				return
			end
		end

		if hp <= 0 and (isUmbraTarget or isCrystalTarget or isVoidPortalTarget or isCorpseTarget or isEyeTarget or isBreakerTarget) then
			local fallbackHp = ReadNumericStat(targetModel, HEALTH_STAT_KEYS, true)
				or ReadNumericStat(targetModel, MAX_HEALTH_STAT_KEYS, true)
				or (resolvedRep and ReadNumericStat(resolvedRep, HEALTH_STAT_KEYS, true))
				or (resolvedRep and ReadNumericStat(resolvedRep, MAX_HEALTH_STAT_KEYS, true))
			if type(fallbackHp) == "number" and fallbackHp > 0 then
				hp = fallbackHp
			end
		end

		local totalHP = hp + (shield or 0)
		if totalHP <= 0 then
			return
		end

		if cfg.shootCorpses == false and isCorpseTarget then
			return
		end
		if cfg.shootCorpses ~= false or not IsRevived(resolvedRep, targetModel) then
			local isLead = IsEnemyLead(resolvedRep, targetModel, npcData)
			if isLead and not (cfg and cfg.shootLead == true) then
				return
			end

			local isExemptPending = isUmbraTarget or isVoidPortalTarget or isSpecialTarget or isEyeTarget or isCorpseTarget or isTricksterTarget
			local pendingDamage = (cfg.autoCaliber and not isExemptPending) and GetPendingDamage(targetModel) or 0
			if (totalHP - pendingDamage) <= 0 then
				return
			end

			local effectiveMaxHp = math.max(totalHP, (maxHp or 0) + (shield or 0))
			local repMax = resolvedRep
				and (ReadNumericStat(resolvedRep, MAX_HEALTH_STAT_KEYS, false) or ReadNumericStat(resolvedRep, MAX_HEALTH_STAT_KEYS, true))
			if type(repMax) == "number" and repMax > 0 then
				effectiveMaxHp = math.max(effectiveMaxHp, repMax + shield)
			end
			local humanoid = targetModel:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.MaxHealth > 0 then
				effectiveMaxHp = math.max(effectiveMaxHp, humanoid.MaxHealth + shield)
			end
			local modelMax = ReadNumericStat(targetModel, MAX_HEALTH_STAT_KEYS, true)
			if type(modelMax) == "number" and modelMax > 0 then
				effectiveMaxHp = math.max(effectiveMaxHp, modelMax + shield)
			end

			processedModels[targetModel] = true
			table.insert(candidates, {
				Model = targetModel,
				Replicator = resolvedRep,
				NPC = npcData,
				HRP = hrp,
				PivotPos = pivotPos,
				HP = totalHP,
				MaxHP = effectiveMaxHp,
				Path = pathDist,
				Defense = defense,
				IsUmbra = isUmbraTarget,
				IsVoidPortal = isVoidPortalTarget,
				IsCrystal = isCrystalTarget,
				IsSpecial = isSpecialTarget,
				IsCorpse = isCorpseTarget,
				IsEye = isEyeTarget,
				IsBreaker = isBreakerTarget,
				IsGuardian = isGuardianTarget,
				IsTrickster = isTricksterTarget,
				IsLead = isLead,
				DistToBase = (pivotPos - basePos).Magnitude,
			})
		end
	end

	local folders = {
		npcRootFolder,
		enemiesFolder,
		workspace:FindFirstChild("Boss"),
		workspace:FindFirstChild("Bosses")
	}

	for _, child in ipairs(workspace:GetChildren()) do
		if child:IsA("Model") and string.find(string.lower(child.Name), "umbra", 1, true) then
			table.insert(folders, child)
		end
	end

	local function RecurseScan(parent)
		for _, v in ipairs(parent:GetChildren()) do
			if v:IsA("Model") then
				IndexModel(v)
				local isTeamContainer =
					npcRootFolder and v.Parent == npcRootFolder and (v.Name == "Red" or v.Name == "Blue")
				if not isTeamContainer then
					local likelyEnemy = v:FindFirstChild("HumanoidRootPart")
						or v:FindFirstChild("RootPart")
						or v:FindFirstChild("RootPointer")
						or v:FindFirstChildOfClass("Humanoid")
						or v:GetAttribute("Health") ~= nil
						or v:GetAttribute("HP") ~= nil
						or v:GetAttribute("MaxHealth") ~= nil
						or v:GetAttribute("MaxHP") ~= nil
						or v:FindFirstChild("Crystal")
						or v:FindFirstChild("Portal")
						or string.find(string.lower(v.Name), "umbra", 1, true)
						or HasPortalKeyword(v.Name)
						or HasCrystalKeyword(v.Name)
						or HasSpecialKeyword(v.Name)
						or HasCorpseKeyword(v.Name)
					if likelyEnemy then
						AddCandidate(v, nil)
					end
				end
				RecurseScan(v)
			elseif v:IsA("Folder") then
				RecurseScan(v)
			end
		end
	end

	for _, f in pairs(folders) do
		if f then
			RecurseScan(f)
		end
	end

	local stateRep = rs:FindFirstChild("StateReplicators")
	if stateRep then
		for _, rep in ipairs(stateRep:GetChildren()) do
			if rep.Name == "NPCReplicator" or rep:GetAttribute("Health") ~= nil then
				if cfg.ignoreHolograms ~= false and IsHologramEnemy(nil, rep) then
					continue
				end
				local repNpc = GetNPCFromFolder(rep)
				local foundModel = repNpc and repNpc.Model or FindModelForRep(rep)
				if foundModel then
					AddCandidate(foundModel, rep)
				elseif IsUmbraTarget(nil, rep) or IsCrystalTarget(nil, rep) or IsVoidPortalTarget(nil, rep) or IsCorpseTarget(nil, rep) or IsTricksterTarget(nil, rep) then
					local repName = rep:GetAttribute("ModelName") or rep:GetAttribute("Name") or rep.Name
					local namedModel = (npcRootFolder and (npcRootFolder:FindFirstChild(repName, true) or npcRootFolder:FindFirstChild(rep.Name, true) or npcRootFolder:FindFirstChild(repName .. "Enemy", true)))
						or (enemiesFolder and (enemiesFolder:FindFirstChild(repName, true) or enemiesFolder:FindFirstChild(rep.Name, true) or enemiesFolder:FindFirstChild(repName .. "Enemy", true)))
						or workspace:FindFirstChild(repName, true)
						or workspace:FindFirstChild(repName .. "Enemy", true)
					if namedModel and namedModel:IsA("Model") then
						AddCandidate(namedModel, rep)
					end
				end
			end
		end
	end

	RawEnemyCache.lastScan = now
	RawEnemyCache.candidates = candidates
	return candidates
end

local function GetSortedTargets(activeTower)
	local cfg = getgenv().config
	local towerPos = activeTower
			and activeTower:FindFirstChild("HumanoidRootPart")
			and activeTower.HumanoidRootPart.Position
		or workspace.CurrentCamera.CFrame.Position

	local canHitLead = CanTowerHitLead(activeTower)
	local towerRange = nil
	if activeTower then
		local rep = activeTower:FindFirstChild("TowerReplicator")
		if rep then
			towerRange = GetTowerRange(rep)
		end
	end
	local rangePadding = cfg.rangePadding or 3
	local ignoreRange = cfg.unlimitedRange == true

	local rawCandidates = GetRawEnemyCandidates()
	local candidates = {}

	for _, raw in ipairs(rawCandidates) do
		local model = raw.Model
		if not model or not model.Parent or not model:IsDescendantOf(workspace) then
			continue
		end
		if IsTargetDead(model, raw.Replicator, raw.NPC) then
			continue
		end
		if raw.IsLead and not (cfg and cfg.shootLead == true) then
			continue
		end

		local distToTower = (raw.PivotPos - towerPos).Magnitude
		if (not ignoreRange) and towerRange and distToTower > (towerRange + rangePadding) then
			continue
		end

		table.insert(candidates, {
			Model = raw.Model,
			Replicator = raw.Replicator,
			NPC = raw.NPC,
			HRP = raw.HRP,
			PivotPos = raw.PivotPos,
			HP = raw.HP,
			MaxHP = raw.MaxHP,
			Path = raw.Path,
			Defense = raw.Defense,
			IsUmbra = raw.IsUmbra,
			IsVoidPortal = raw.IsVoidPortal,
			IsCrystal = raw.IsCrystal,
			IsSpecial = raw.IsSpecial,
			IsCorpse = raw.IsCorpse,
			IsEye = raw.IsEye,
			IsBreaker = raw.IsBreaker,
			IsGuardian = raw.IsGuardian,
			IsTrickster = raw.IsTrickster,
			IsLead = raw.IsLead,
			DistToBase = raw.DistToBase,
			DistToTower = distToTower,
		})
	end

	if #candidates > 0 then
		local hasUmbra = false
		if cfg.umbraPriority ~= false then
			for _, c in ipairs(candidates) do
				if c.IsUmbra then
					hasUmbra = true
					break
				end
			end
		end

		local hasTrickster = false
		if not hasUmbra and cfg.tricksterPriority ~= false then
			for _, c in ipairs(candidates) do
				if c.IsTrickster then
					hasTrickster = true
					break
				end
			end
		end

		if hasUmbra then
			local umbraCandidates = {}
			for _, c in ipairs(candidates) do
				if c.IsUmbra then
					table.insert(umbraCandidates, c)
				end
			end
			if #umbraCandidates > 0 then
				candidates = umbraCandidates
			end
		elseif hasTrickster then
			local tricksterCandidates = {}
			for _, c in ipairs(candidates) do
				if c.IsTrickster then
					table.insert(tricksterCandidates, c)
				end
			end
			if #tricksterCandidates > 0 then
				candidates = tricksterCandidates
			end
		elseif cfg.portalPriority ~= false then
			local hasPortal = false
			for _, c in ipairs(candidates) do
				if c.IsVoidPortal or c.IsEye then
					hasPortal = true
					break
				end
			end
			if hasPortal then
				local portalCandidates = {}
				for _, c in ipairs(candidates) do
					if c.IsVoidPortal or c.IsEye then
						table.insert(portalCandidates, c)
					end
				end
				if #portalCandidates > 0 then
					candidates = portalCandidates
				end
			end
		end

		BuildThreatMetrics(candidates)

		if cfg.mode == "First" then
			table.sort(candidates, function(a, b)
				if cfg.umbraPriority ~= false and a.IsUmbra ~= b.IsUmbra then
					return a.IsUmbra == true
				end
				if cfg.tricksterPriority ~= false and a.IsTrickster ~= b.IsTrickster then
					return a.IsTrickster == true
				end
				local aPortal = a.IsVoidPortal or a.IsEye
				local bPortal = b.IsVoidPortal or b.IsEye
				if cfg.portalPriority ~= false and aPortal ~= bPortal then
					return aPortal == true
				end
				if a.IsCrystal ~= b.IsCrystal then
					return a.IsCrystal == true
				end
				if cfg.corpsePriority ~= false and a.IsCorpse ~= b.IsCorpse then
					return a.IsCorpse == true
				end
				if cfg.specialTargetPriority ~= false and a.IsSpecial ~= b.IsSpecial then
					return a.IsSpecial == true
				end
				if cfg.prioritizeDamagable == true then
					local aCanDamage = not (a.IsLead and not (cfg and cfg.shootLead == true))
					local bCanDamage = not (b.IsLead and not (cfg and cfg.shootLead == true))
					if aCanDamage ~= bCanDamage then
						return aCanDamage == true
					end
				end
				if a.Path > -1 and b.Path > -1 then
					return a.Path > b.Path
				end
				return a.DistToBase < b.DistToBase
			end)
		elseif cfg.mode == "Strongest" then
			local pathWeight = cfg.strongModePathWeight or 1.6
			local hpWeight = cfg.strongModeHpWeight or 0.65
			local nearThreshold = cfg.nearEndProgressThreshold or 0.8
			local nearBonus = cfg.nearEndForceBonus or 2.5

			local function Score(c)
				local score = ((c.Progress or 0) * pathWeight) + ((c.HPFactor or 0) * hpWeight)
				if cfg.nearEndPriority and (c.Progress or 0) >= nearThreshold then
					score = score + nearBonus + ((c.Progress or 0) - nearThreshold)
				end
				return score
			end

			table.sort(candidates, function(a, b)
				if cfg.umbraPriority ~= false and a.IsUmbra ~= b.IsUmbra then
					return a.IsUmbra == true
				end
				if cfg.tricksterPriority ~= false and a.IsTrickster ~= b.IsTrickster then
					return a.IsTrickster == true
				end
				local aPortal = a.IsVoidPortal or a.IsEye
				local bPortal = b.IsVoidPortal or b.IsEye
				if cfg.portalPriority ~= false and aPortal ~= bPortal then
					return aPortal == true
				end
				if a.IsCrystal ~= b.IsCrystal then
					return a.IsCrystal == true
				end
				if cfg.corpsePriority ~= false and a.IsCorpse ~= b.IsCorpse then
					return a.IsCorpse == true
				end
				if cfg.specialTargetPriority ~= false and a.IsSpecial ~= b.IsSpecial then
					return a.IsSpecial == true
				end
				if cfg.prioritizeDamagable == true then
					local aCanDamage = not (a.IsLead and not (cfg and cfg.shootLead == true))
					local bCanDamage = not (b.IsLead and not (cfg and cfg.shootLead == true))
					if aCanDamage ~= bCanDamage then
						return aCanDamage == true
					end
				end
				local sa, sb = Score(a), Score(b)
				if math.abs(sa - sb) > 0.01 then
					return sa > sb
				end
				return a.HP > b.HP
			end)
		elseif cfg.mode == "Close" then
			table.sort(candidates, function(a, b)
				if cfg.umbraPriority ~= false and a.IsUmbra ~= b.IsUmbra then
					return a.IsUmbra == true
				end
				if cfg.tricksterPriority ~= false and a.IsTrickster ~= b.IsTrickster then
					return a.IsTrickster == true
				end
				local aPortal = a.IsVoidPortal or a.IsEye
				local bPortal = b.IsVoidPortal or b.IsEye
				if cfg.portalPriority ~= false and aPortal ~= bPortal then
					return aPortal == true
				end
				if a.IsCrystal ~= b.IsCrystal then
					return a.IsCrystal == true
				end
				if cfg.corpsePriority ~= false and a.IsCorpse ~= b.IsCorpse then
					return a.IsCorpse == true
				end
				if cfg.specialTargetPriority ~= false and a.IsSpecial ~= b.IsSpecial then
					return a.IsSpecial == true
				end
				if cfg.prioritizeDamagable == true then
					local aCanDamage = not (a.IsLead and not (cfg and cfg.shootLead == true))
					local bCanDamage = not (b.IsLead and not (cfg and cfg.shootLead == true))
					if aCanDamage ~= bCanDamage then
						return aCanDamage == true
					end
				end
				return a.DistToTower < b.DistToTower
			end)
		end
	end

	local maxTargets = math.clamp(math.floor(tonumber(cfg.maxTargets or cfg.maxTarget) or 5), 1, 5)
	if #candidates > maxTargets then
		for i = #candidates, maxTargets + 1, -1 do
			candidates[i] = nil
		end
	end

	if IsGatlingReloading(activeTower) then
		ClearTargetESP()
	else
		UpdateTargetESP(candidates, activeTower)
	end
	return candidates
end

local function StopSpecificHook(Tower)
	if getgenv().RunningTowers[Tower] then
		task.cancel(getgenv().RunningTowers[Tower])
		getgenv().RunningTowers[Tower] = nil
	end
	TowerBarrelCache[Tower] = nil
	TowerBarrelIndex[Tower] = nil
	ClearTargetESP()
	ClearBulletLines(Tower)
end

local TorsoPartCache = setmetatable({}, { __mode = "k" })

local function GetTorsoPosition(model)
	if not model or not model.Parent then return nil end

	local cached = TorsoPartCache[model]
	if cached ~= nil then
		if cached == false then
		elseif cached:IsA("Bone") then
			if cached.Parent then return cached.WorldPosition end
		elseif cached:IsA("BasePart") then
			if cached.Parent then return cached.Position end
		end
	end

	local mName = string.lower(model.Name)
	if string.find(mName, "umbra", 1, true) then
		local charPart = model:FindFirstChild("Character")
		if charPart and charPart:IsA("BasePart") then
			TorsoPartCache[model] = charPart
			return charPart.Position
		end
	end

	local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("LowerTorso")
	if torso and torso:IsA("BasePart") then
		TorsoPartCache[model] = torso
		return torso.Position
	end

	local chestBone = model:FindFirstChild("DEF_Chest", true) or model:FindFirstChild("DEF_Spine", true)
	if chestBone and chestBone:IsA("Bone") then
		TorsoPartCache[model] = chestBone
		return chestBone.WorldPosition
	end

	local charPart = model:FindFirstChild("Character")
	if charPart and charPart:IsA("BasePart") then
		TorsoPartCache[model] = charPart
		return charPart.Position + Vector3.new(0, 0.5, 0)
	end

	local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart")
	if hrp and hrp:IsA("BasePart") then
		TorsoPartCache[model] = hrp
		return hrp.Position
	end

	local hitbox = model:FindFirstChild("Hitbox", true)
	if hitbox and hitbox:IsA("BasePart") then
		TorsoPartCache[model] = hitbox
		return hitbox.Position
	end

	if model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then
		TorsoPartCache[model] = model.PrimaryPart
		return model.PrimaryPart.Position
	end

	TorsoPartCache[model] = false

	local ok, cf = pcall(function() return model:GetPivot() end)
	if ok and cf then
		return cf.Position
	end
	return nil
end

local LegBoneCache = setmetatable({}, { __mode = "k" })

local function GetLegsPosition(model)
	if not model or not model.Parent then return nil end

	if IsEyeTarget(model) then
		return nil
	end

	local cached = LegBoneCache[model]
	if cached ~= nil then
		if cached == false then
		elseif cached.isBone then
			if cached.legR and cached.legR.Parent and cached.legL and cached.legL.Parent then
				return (cached.legR.WorldPosition + cached.legL.WorldPosition) * 0.5
			elseif cached.legR and cached.legR.Parent then
				return cached.legR.WorldPosition
			elseif cached.legL and cached.legL.Parent then
				return cached.legL.WorldPosition
			end
		elseif cached.isPart then
			if cached.legR and cached.legR.Parent and cached.legL and cached.legL.Parent then
				return (cached.legR.Position + cached.legL.Position) * 0.5
			elseif cached.legR and cached.legR.Parent then
				return cached.legR.Position
			elseif cached.legL and cached.legL.Parent then
				return cached.legL.Position
			end
		end
	end

	if IsUmbraTarget(model) then
		local pos = GetUmbraLegPosition(model)
		if pos then
			return pos
		end
	end

	local legR = model:FindFirstChild("DEF_Lower_Leg_R", true) or model:FindFirstChild("DEF_Upper_Leg_R", true)
	local legL = model:FindFirstChild("DEF_Lower_Leg_L", true) or model:FindFirstChild("DEF_Upper_Leg_L", true)
	if (legR and legR:IsA("Bone")) or (legL and legL:IsA("Bone")) then
		LegBoneCache[model] = { isBone = true, legR = legR, legL = legL }
		if legR and legR:IsA("Bone") and legL and legL:IsA("Bone") then
			return (legR.WorldPosition + legL.WorldPosition) * 0.5
		elseif legR and legR:IsA("Bone") then
			return legR.WorldPosition
		else
			return legL.WorldPosition
		end
	end

	local rLeg = model:FindFirstChild("Right Leg") or model:FindFirstChild("RightLowerLeg") or model:FindFirstChild("RightFoot")
	local lLeg = model:FindFirstChild("Left Leg") or model:FindFirstChild("LeftLowerLeg") or model:FindFirstChild("LeftFoot")
	if (rLeg and rLeg:IsA("BasePart")) or (lLeg and lLeg:IsA("BasePart")) then
		LegBoneCache[model] = { isPart = true, legR = rLeg, legL = lLeg }
		if rLeg and rLeg:IsA("BasePart") and lLeg and lLeg:IsA("BasePart") then
			return (rLeg.Position + lLeg.Position) * 0.5
		elseif rLeg and rLeg:IsA("BasePart") then
			return rLeg.Position
		else
			return lLeg.Position
		end
	end

	LegBoneCache[model] = false

	local charPart = model:FindFirstChild("Character")
	if charPart and charPart:IsA("BasePart") then
		return charPart.Position - Vector3.new(0, (charPart.Size.Y * 0.35), 0)
	end

	local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart")
	if hrp and hrp:IsA("BasePart") then
		return hrp.Position - Vector3.new(0, 2, 0)
	end

	return nil
end

local function GetTargetPosition(hrp, model)
	if model then
		local mName = string.lower(model.Name)
		if string.find(mName, "umbra", 1, true) then
			local cfg = getgenv().config
			if cfg and cfg.umbraAimLegs ~= false then
				local legPos = GetUmbraLegPosition(model)
				if legPos then
					return legPos
				end
			end
			local umbraPart = GetUmbraAimPart(model)
			if umbraPart then
				return umbraPart.Position
			end
		end
		if (string.find(mName, "eye", 1, true) or model:FindFirstChild("Eye") or model:FindFirstChild("EyeModelFake")) and not string.find(mName, "reaver", 1, true) then
			local hitbox = model:FindFirstChild("Hitbox", true) or model:FindFirstChild("Eye", true)
			if hitbox and hitbox:IsA("BasePart") then
				return hitbox.Position
			end
		end
	end
	if hrp and hrp.Parent then
		return hrp.Position
	end
	if model and model.Parent then
		local ok, cf = pcall(function()
			return model:GetPivot()
		end)
		if ok and cf then
			return cf.Position
		end
	end
	return nil
end

local function ResolveExecutorProfile()
	local profile = {
		name = "Unknown",
		isVolt = false,
		hasNamecallHook = false,
		hasExecutorClosures = false,
		hasCloneref = type(cloneref) == "function",
	}

	local ok, executorName = pcall(function()
		if type(identifyexecutor) == "function" then
			return identifyexecutor()
		elseif type(getexecutorname) == "function" then
			return getexecutorname()
		end
		return nil
	end)

	if ok and type(executorName) == "string" and executorName ~= "" then
		profile.name = executorName
	end

	local normalized = string.lower(profile.name)
	profile.isVolt = string.find(normalized, "volt", 1, true) ~= nil
	profile.hasNamecallHook = type(hookmetamethod) == "function" or type(getrawmetatable) == "function"
	profile.hasExecutorClosures = type(newcclosure) == "function"
	return profile
end

local function BuildGatlingFireTransport(ggchannel)
	local networkFolder = rs:FindFirstChild("Network")
	local gatlingFolder = networkFolder and networkFolder:FindFirstChild("GatlingGun")
	local fireRemote = gatlingFolder and gatlingFolder:FindFirstChild("RE:Fire")
	local repRemote = gatlingFolder and (gatlingFolder:FindFirstChild("URE:ReplicateAimPosition") or gatlingFolder:FindFirstChild("RE:ReplicateAimPosition"))

	local transport = {}

	function transport:Aim(aimPosition)
		if not aimPosition then return end
		if ggchannel then
			if type(ggchannel.fireUnreliableServer) == "function" then
				pcall(function() ggchannel:fireUnreliableServer("ReplicateAimPosition", aimPosition) end)
			elseif type(ggchannel.FireUnreliableServer) == "function" then
				pcall(function() ggchannel:FireUnreliableServer("ReplicateAimPosition", aimPosition) end)
			elseif type(ggchannel.fireServer) == "function" then
				pcall(function() ggchannel:fireServer("ReplicateAimPosition", aimPosition) end)
			elseif type(ggchannel.FireServer) == "function" then
				pcall(function() ggchannel:FireServer("ReplicateAimPosition", aimPosition) end)
			end
		end
		if repRemote then
			pcall(function()
				repRemote:FireServer(aimPosition)
			end)
		end
	end

	function transport:Fire(firePosition)
		local sync = workspace:GetAttribute("Sync")
		local serverTime = workspace:GetServerTimeNow()

		if fireRemote and fireRemote:IsA("RemoteEvent") then
			fireRemote:FireServer(firePosition, sync, serverTime)
			return true
		end

		if ggchannel then
			if type(ggchannel.fireServer) == "function" then
				ggchannel:fireServer("Fire", firePosition, sync, serverTime)
				return true
			elseif type(ggchannel.FireServer) == "function" then
				ggchannel:FireServer("Fire", firePosition, sync, serverTime)
				return true
			end
		end

		return false
	end

	return transport
end

local AimRaycastParams = RaycastParams.new()
AimRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
AimRaycastParams.IgnoreWater = true

local function IsShieldPart(part)
	if not part or not part:IsA("BasePart") then
		return false
	end
	if part.Material == Enum.Material.ForceField then
		return true
	end
	local name = string.lower(part.Name)
	return string.find(name, "shield", 1, true) ~= nil
		or string.find(name, "forcefield", 1, true) ~= nil
		or string.find(name, "barrier", 1, true) ~= nil
end

local function ModelHasShield(model)
	if not model then
		return false
	end
	if IsBreakerTarget(model) or IsEyeTarget(model) or IsCorpseTarget(model) or IsGuardianTarget(model) or IsTricksterTarget(model) or IsUmbraTarget(model) then
		return false
	end
	local name = string.lower(model.Name)
	if string.find(name, "vindicator", 1, true) ~= nil then
		return true
	end
	return false
end

local function GetDirectRaycastPosition(origin, targetModel, fallbackPos, activeTower)
	if not targetModel or not targetModel.Parent then
		return fallbackPos
	end

	local isUmbra = IsUmbraTarget(targetModel)
	local isEye = IsEyeTarget(targetModel)
	local isCorpse = IsCorpseTarget(targetModel)
	local isBreaker = IsBreakerTarget(targetModel)
	local isGuardian = IsGuardianTarget(targetModel)
	local isTrickster = IsTricksterTarget(targetModel)
	local hitbox = targetModel:FindFirstChild("Hitbox", true) or (isEye and targetModel:FindFirstChild("Eye", true))
	local hrp = targetModel:FindFirstChild("HumanoidRootPart", true)
		or targetModel:FindFirstChild("RootPart", true)
		or targetModel.PrimaryPart
	local breakerPart = isBreaker and GetBreakerAimPart(targetModel)
	local breakerPos = breakerPart and breakerPart.Position
	local hitboxPos = hitbox and hitbox:IsA("BasePart") and hitbox.Position
	local hrpPos = hrp and hrp:IsA("BasePart") and hrp.Position
	local legPos = (not isEye and not isCorpse and not isBreaker and not isGuardian and not isTrickster) and GetLegsPosition(targetModel) or nil
	local torsoPos = GetTorsoPosition(targetModel)
	local hasShield = (not isEye and not isCorpse and not isBreaker and not isGuardian and not isTrickster and not isUmbra) and ModelHasShield(targetModel)

	local candidates
	if isUmbra then
		local cfg = getgenv().config
		local uLeg = GetUmbraLegPosition(targetModel)
		if cfg and cfg.umbraAimLegs ~= false and uLeg then
			candidates = { uLeg, legPos, fallbackPos }
		else
			local umbraAim = GetUmbraAimPart(targetModel)
			local uPos = umbraAim and umbraAim.Position
			candidates = { uPos or torsoPos, torsoPos, fallbackPos }
		end
	elseif isCorpse then
		candidates = { hitboxPos, hrpPos, torsoPos, fallbackPos }
	elseif isEye then
		candidates = { hitboxPos, fallbackPos }
	elseif isTrickster then
		candidates = { fallbackPos, hrpPos, torsoPos, hitboxPos }
	elseif isBreaker then
		candidates = { breakerPos or torsoPos, torsoPos, fallbackPos, hrpPos }
	elseif isGuardian then
		candidates = { fallbackPos, hitboxPos, hrpPos, torsoPos }
	elseif hasShield then
		candidates = { legPos, torsoPos, fallbackPos }
	else
		candidates = { fallbackPos, hitboxPos, hrpPos, torsoPos }
	end

	if not origin then
		if isUmbra and getgenv().config and getgenv().config.umbraAimLegs ~= false then
			local uLeg = GetUmbraLegPosition(targetModel)
			if uLeg then
				return uLeg
			end
		end
		return (isUmbra and (torsoPos or fallbackPos)) or (isBreaker and (breakerPos or torsoPos)) or (isEye and (hitboxPos or fallbackPos)) or (isCorpse and (hitboxPos or hrpPos)) or (hasShield and legPos) or fallbackPos or torsoPos
	end

	local ignoreList = {}
	if activeTower then
		table.insert(ignoreList, activeTower)
	end
	local towersFolder = workspace:FindFirstChild("Towers")
	if towersFolder then
		table.insert(ignoreList, towersFolder)
	end
	local clientUnits = workspace:FindFirstChild("ClientUnits")
	if clientUnits then
		table.insert(ignoreList, clientUnits)
	end
	if LocalPlayer and LocalPlayer.Character then
		table.insert(ignoreList, LocalPlayer.Character)
	end
	if workspace.CurrentCamera then
		table.insert(ignoreList, workspace.CurrentCamera)
	end
	local map = workspace:FindFirstChild("Map")
	if map then
		local env = map:FindFirstChild("Environment")
		if env then table.insert(ignoreList, env) end
		local bounds = map:FindFirstChild("Boundaries")
		if bounds then table.insert(ignoreList, bounds) end
		local decor = map:FindFirstChild("Decorations") or map:FindFirstChild("Props")
		if decor then table.insert(ignoreList, decor) end
	end
	AimRaycastParams.FilterDescendantsInstances = ignoreList

	for _, candPos in ipairs(candidates) do
		if candPos then
			local toTarget = candPos - origin
			local dist = toTarget.Magnitude
			if dist > 0.1 then
				local dir = toTarget.Unit
				local remainingDist = dist
				local curOrigin = origin
				local pass = false
				local filterList = table.clone(ignoreList)
				local rayParams = RaycastParams.new()
				rayParams.FilterType = Enum.RaycastFilterType.Exclude
				rayParams.FilterDescendantsInstances = filterList

				for iter = 1, 5 do
					local result = workspace:Raycast(curOrigin, dir * remainingDist, rayParams)
					if result == nil then
						pass = true
						break
					elseif result.Instance and result.Instance:IsDescendantOf(targetModel) then
						if (not hasShield) or (not IsShieldPart(result.Instance)) then
							pass = true
						end
						break
					elseif result.Instance and (
						result.Instance.Transparency >= 0.95
						or result.Instance.CanQuery == false
						or (workspace:FindFirstChild("NPCs") and result.Instance:IsDescendantOf(workspace.NPCs))
						or (workspace:FindFirstChild("Enemies") and result.Instance:IsDescendantOf(workspace.Enemies))
						or (workspace:FindFirstChild("ClientUnits") and result.Instance:IsDescendantOf(workspace.ClientUnits))
					) then
						local hitModel = result.Instance:FindFirstAncestorOfClass("Model")
						if hitModel and hitModel ~= workspace and hitModel ~= workspace:FindFirstChild("NPCs") and hitModel ~= workspace:FindFirstChild("Enemies") and hitModel ~= workspace:FindFirstChild("ClientUnits") then
							table.insert(filterList, hitModel)
						else
							table.insert(filterList, result.Instance)
						end
						rayParams.FilterDescendantsInstances = filterList
						local stepDist = (result.Position - curOrigin).Magnitude
						remainingDist = remainingDist - stepDist - 0.05
						curOrigin = result.Position + (dir * 0.05)
						if remainingDist <= 0 then
							pass = true
							break
						end
					else
						break
					end
				end

				if pass then
					return candPos
				end
			end
		end
	end

	if isUmbra then
		local cfg = getgenv().config
		if cfg and cfg.umbraAimLegs ~= false then
			local uLeg = GetUmbraLegPosition(targetModel)
			if uLeg then
				return uLeg
			end
		end
		return torsoPos or fallbackPos
	end
	if isEye then
		return hitboxPos or fallbackPos
	end
	if isCorpse then
		return hitboxPos or hrpPos or torsoPos or fallbackPos
	end
	if isTrickster then
		return fallbackPos or hrpPos or torsoPos or hitboxPos
	end
	if isBreaker then
		return breakerPos or torsoPos or fallbackPos or hrpPos
	end
	if isGuardian then
		return fallbackPos or hitboxPos or hrpPos or torsoPos
	end
	if hasShield and legPos then
		return legPos
	end
	return fallbackPos or torsoPos
end

local function ComputeAdaptiveFirePosition(cfg, shotPatternCounter, towerPos, targetData, targetModel, targetCenterPos, Replicator)
	local aimPos, targetSpeed, aimVelocity, aimDist, closeFactor =
		GetLiveAimPosition(targetData, towerPos, Replicator)
	if not aimPos then
		return nil, shotPatternCounter
	end

	local disablePrediction = cfg.disablePrediction == true
	local shotUmbra = targetData.IsUmbra == true or IsUmbraTarget(targetModel, targetData.Replicator)
	local shotPortal = targetData.IsVoidPortal == true
	local shotCrystal = targetData.IsCrystal == true
	local shotSpecial = targetData.IsSpecial == true
	local shotCorpse = targetData.IsCorpse == true
	local shotEye = targetData.IsEye == true or IsEyeTarget(targetModel, targetData.Replicator)
	local shotBreaker = targetData.IsBreaker == true or IsBreakerTarget(targetModel, targetData.Replicator)
	local shotGuardian = targetData.IsGuardian == true or IsGuardianTarget(targetModel, targetData.Replicator)
	local shotTrickster = targetData.IsTrickster == true or IsTricksterTarget(targetModel, targetData.Replicator)

	if shotUmbra then
		if cfg and cfg.umbraAimLegs ~= false then
			local legPos = GetUmbraLegPosition(targetModel)
			if legPos then
				return legPos, shotPatternCounter
			end
		end
		local umbraAim = GetUmbraAimPart(targetModel)
		local basePos = umbraAim and umbraAim.Position or targetCenterPos
		return basePos, shotPatternCounter
	end

	if shotEye then
		local hitbox = targetModel:FindFirstChild("Hitbox", true) or targetModel:FindFirstChild("Eye", true)
		local basePos = hitbox and hitbox:IsA("BasePart") and hitbox.Position or targetCenterPos
		return basePos, shotPatternCounter
	end

	if shotBreaker then
		local breakerPart = GetBreakerAimPart(targetModel)
		local basePos = breakerPart and breakerPart.Position or targetCenterPos
		if disablePrediction then
			return basePos, shotPatternCounter
		end
		local horizVel = Vector3.new(aimVelocity.X, 0, aimVelocity.Z)
		local horizSpeed = horizVel.Magnitude
		if horizSpeed > 0.4 then
			local ping = 0.05
			pcall(function()
				if players.LocalPlayer then
					ping = players.LocalPlayer:GetNetworkPing()
				end
			end)
			local leadSec = math.clamp((ping * 0.3) + 0.015, 0.01, 0.04)
			local leadVec = horizVel * leadSec
			if leadVec.Magnitude > 0.3 then
				leadVec = leadVec.Unit * 0.3
			end
			return basePos + leadVec, shotPatternCounter
		else
			return basePos, shotPatternCounter
		end
	end

	if shotGuardian then
		return aimPos, shotPatternCounter
	end

	if shotTrickster then
		return aimPos, shotPatternCounter
	end

	if disablePrediction or shotPortal or shotCrystal or shotSpecial or shotCorpse or shotEye then
		return targetCenterPos, shotPatternCounter
	end

	local shotFast = (not disablePrediction)
		and (not shotPortal)
		and (not shotSpecial)
		and (not shotCrystal)
		and (not shotCorpse)
		and (not shotGuardian)
		and (not shotBreaker)
		and (not shotTrickster)
		and cfg.fastAim
		and targetSpeed >= (cfg.fastSpeedThreshold or 30)
	local forceLead = (not disablePrediction)
		and cfg.alwaysLeadMoving ~= false
		and (targetSpeed >= (cfg.leadSpeedThreshold or 6) or aimDist >= (cfg.leadDistanceThreshold or 28))

	if shotFast then
		local forwardDir
		if aimVelocity.Magnitude > 0.1 then
			forwardDir = aimVelocity.Unit
		else
			local fallbackDir = aimPos - towerPos
			forwardDir = fallbackDir.Magnitude > 0.01 and fallbackDir.Unit or Vector3.new(0, 0, 1)
		end

		local sideDir = forwardDir:Cross(Vector3.new(0, 1, 0))
		if sideDir.Magnitude < 0.05 then
			sideDir = Vector3.new(1, 0, 0)
		else
			sideDir = sideDir.Unit
		end

		local baseSpread = math.clamp((cfg.fastLateralSpread or 1.1) + (targetSpeed * 0.01), 0.2, math.max(1.2, aimDist * 0.08))
		local spreadScale = 1
		if cfg.closeAimCompensation ~= false then
			local closeSpreadScale = cfg.closeSpreadScale or 0.15
			spreadScale = closeSpreadScale + ((1 - closeSpreadScale) * closeFactor)
		end
		local lateralSpread = math.min(baseSpread * spreadScale, cfg.maxLateralSpread or 1.25)

		local baseForward = math.clamp((targetSpeed - (cfg.fastSpeedThreshold or 30)) * 0.02, 0.15, 2.8)
		local forwardScale = 1
		if cfg.closeAimCompensation ~= false then
			local closeForwardScale = cfg.closeForwardScale or 0.35
			forwardScale = closeForwardScale + ((1 - closeForwardScale) * closeFactor)
		end
		local fastAimPoint = aimPos + (forwardDir * (baseForward * forwardScale))

		if cfg.closeAimCompensation ~= false then
			local centerBias = math.clamp(cfg.closeCenterBias or 0.88, 0, 0.98)
			fastAimPoint = fastAimPoint:Lerp(targetCenterPos, centerBias * (1 - closeFactor))
		end

		if forceLead then
			return fastAimPoint, shotPatternCounter
		end

		shotPatternCounter = shotPatternCounter + 1
		if closeFactor < 0.45 then
			local closePattern = shotPatternCounter % 3
			if closePattern == 1 then
				return targetCenterPos:Lerp(fastAimPoint, 0.35), shotPatternCounter
			elseif closePattern == 2 then
				return targetCenterPos, shotPatternCounter
			end
			return targetCenterPos:Lerp(fastAimPoint, 0.55), shotPatternCounter
		end

		local pattern = shotPatternCounter % 4
		if pattern == 1 then
			return fastAimPoint, shotPatternCounter
		elseif pattern == 2 then
			return fastAimPoint + (sideDir * lateralSpread), shotPatternCounter
		elseif pattern == 3 then
			return fastAimPoint - (sideDir * lateralSpread), shotPatternCounter
		end
		return targetCenterPos:Lerp(fastAimPoint, 0.65), shotPatternCounter
	end

	if forceLead then
		return aimPos, shotPatternCounter
	end

	shotPatternCounter = shotPatternCounter + 1
	if cfg.closeAimCompensation ~= false and closeFactor < 0.5 then
		local closePattern = shotPatternCounter % 3
		if closePattern == 1 then
			return targetCenterPos:Lerp(aimPos, 0.35), shotPatternCounter
		elseif closePattern == 2 then
			return targetCenterPos, shotPatternCounter
		end
		return targetCenterPos:Lerp(aimPos, 0.55), shotPatternCounter
	end

	local pattern = shotPatternCounter % 3
	if pattern == 1 then
		return aimPos, shotPatternCounter
	elseif pattern == 2 then
		return targetCenterPos, shotPatternCounter
	end
	return targetCenterPos:Lerp(aimPos, 0.55), shotPatternCounter
end

local function IsHologramTower(tower, replicator)
	if not tower then
		return false
	end
	if tower:GetAttribute("Hologram") == true or tower:GetAttribute("Clone") == true or tower:GetAttribute("HideModel") == true then
		return true
	end
	local rep = replicator or tower:FindFirstChild("TowerReplicator")
	if rep then
		if rep:GetAttribute("Hologram") == true
			or rep:GetAttribute("HideModel") == true
			or rep:GetAttribute("Clone") == true
			or rep:GetAttribute("PathUsed") ~= nil
			or rep:GetAttribute("LevelUsed") ~= nil then
			return true
		end
	end
	return false
end

local function IsOwnedByLocalPlayer(tower, replicator)
	local rep = replicator or (tower and tower:FindFirstChild("TowerReplicator"))
	if not rep then
		return true
	end
	local owner = rep:GetAttribute("OwnerId") or rep:GetAttribute("Owner")
	if owner and players.LocalPlayer and owner ~= players.LocalPlayer.UserId then
		return false
	end
	return true
end

local function MuffleTowerSounds(tower)
	local function clampSound(snd)
		if snd:IsA("Sound") then
			local targetVol = getgenv().config.gunVolume or 0.05
			snd.Volume = targetVol

			snd:GetPropertyChangedSignal("Volume"):Connect(function()
				local currentTarget = getgenv().config.gunVolume or 0.05
				if snd.Volume > currentTarget then
					snd.Volume = currentTarget
				end
			end)
			snd:GetPropertyChangedSignal("Playing"):Connect(function()
				local currentTarget = getgenv().config.gunVolume or 0.05
				if snd.Playing and snd.Volume > currentTarget then
					snd.Volume = currentTarget
				end
			end)
		end
	end

	for _, desc in ipairs(tower:GetDescendants()) do
		clampSound(desc)
	end
	tower.DescendantAdded:Connect(clampSound)
end

getgenv().StartHooks = function(Tower)
	if not Tower or not Tower.Parent then
		return
	end
	local initialRep = Tower:FindFirstChild("TowerReplicator")
	if not IsOwnedByLocalPlayer(Tower, initialRep) then
		return
	end

	MuffleTowerSounds(Tower)

	if getgenv().RunningTowers[Tower] then
		pcall(function()
			task.cancel(getgenv().RunningTowers[Tower])
		end)
		getgenv().RunningTowers[Tower] = nil
	end

	local executor = ResolveExecutorProfile()
	local success, err = pcall(function()
		task.spawn(function()
			local args = { "Troops", "Abilities", "Activate", { Troop = Tower, Name = "FPS", Data = { enabled = true } } }
			rs:WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
		end)

		local Replicator = Tower:WaitForChild("TowerReplicator", 5)
		if not Replicator or not IsOwnedByLocalPlayer(Tower, Replicator) then
			return
		end
		local ReloadRemote = rs:WaitForChild("Network"):WaitForChild("GatlingGun"):WaitForChild("RE:Reload")
		local BulletHitRemote = rs:WaitForChild("Network"):WaitForChild("GatlingGun"):FindFirstChild("RE:BulletHit")

		if BulletHitRemote and BulletHitRemote:IsA("RemoteEvent") and not getgenv().BulletHitCleaner then
			getgenv().BulletHitCleaner = BulletHitRemote.OnClientEvent:Connect(function() end)
		end

		local ggchannel = require(rs.Resources.Universal.NewNetwork).Channel("GatlingGun")
		local transport = BuildGatlingFireTransport(ggchannel)
		local gganim = require(rs.Content.Tower["Gatling Gun"].Animator)
		gganim._fireGun = function() end

		if executor.isVolt then
			warn(string.format("[Gatlin] Advanced hook online for %s", executor.name))
		end

		local cleanupConnection
		cleanupConnection = Tower.AncestryChanged:Connect(function(_, parent)
			if not parent then
				StopSpecificHook(Tower)
				if cleanupConnection then
					cleanupConnection:Disconnect()
				end
			end
		end)

		local lockState = { model = nil, untilTick = 0 }
		local shotPatternCounter = 0

		local muscleTask = task.spawn(function()
			while true do
				if not Replicator or not Replicator.Parent then
					StopSpecificHook(Tower)
					break
				end

				local loopDelay = 0.038
				local ok, loopErr = xpcall(function()
					local cfg = getgenv().config
					local ignoreRange = cfg.unlimitedRange == true
					loopDelay = 1 / math.max(1, tonumber(cfg.baseFireRate) or 26)
					local canHitLead = CanTowerHitLead(Tower)

					if cfg.autofire then

					local isReloading = IsGatlingReloading(Tower)
					local currentAmmo = Replicator:GetAttribute("Ammo")
					if isReloading or (currentAmmo and currentAmmo <= 0) then
						ClearTargetESP()
						ClearBulletLines(Tower)
						if currentAmmo and currentAmmo <= 0 and not Replicator:GetAttribute("Reloading") then
							ReloadRemote:FireServer()
						end
						task.wait(0.05)
					else
						if Replicator:GetAttribute("FPS") ~= true and (not lockState.lastFpsAttempt or os.clock() - lockState.lastFpsAttempt > 2) then
							lockState.lastFpsAttempt = os.clock()
							task.spawn(function()
								local args = { "Troops", "Abilities", "Activate", { Troop = Tower, Name = "FPS", Data = { enabled = true } } }
								rs:WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
							end)
						end

						local targetList = GetSortedTargets(Tower)
						if #targetList > 0 then
							local hasUmbra = false
							local hasTrickster = false
							local hasVoidPortal = false
							for _, t in ipairs(targetList) do
								if t.IsUmbra then
									hasUmbra = true
								end
								if t.IsTrickster then
									hasTrickster = true
								end
								if t.IsVoidPortal then
									hasVoidPortal = true
								end
							end

							if cfg.umbraPriority ~= false and hasUmbra then
								local onlyUmbra = {}
								for _, t in ipairs(targetList) do
									if t.IsUmbra then
										table.insert(onlyUmbra, t)
									end
								end
								if #onlyUmbra > 0 then
									targetList = onlyUmbra
								end
							elseif cfg.tricksterPriority ~= false and hasTrickster then
								local onlyTricksters = {}
								for _, t in ipairs(targetList) do
									if t.IsTrickster then
										table.insert(onlyTricksters, t)
									end
								end
								if #onlyTricksters > 0 then
									targetList = onlyTricksters
								end
							elseif cfg.portalPriority ~= false and hasVoidPortal then
								local onlyPortals = {}
								for _, t in ipairs(targetList) do
									if t.IsVoidPortal or t.IsEye then
										table.insert(onlyPortals, t)
									end
								end
								if #onlyPortals > 0 then
									targetList = onlyPortals
								end
							end

							if cfg.lockOnTarget and lockState.model and os.clock() <= lockState.untilTick then
								local lockRep = GetReplicator(lockState.model)
								local lockIsUmbra = IsUmbraTarget(lockState.model, lockRep)
								local lockIsTrickster = IsTricksterTarget(lockState.model, lockRep)
								local lockIsPortal = IsVoidPortalTarget(lockState.model, lockRep) or IsEyeTarget(lockState.model, lockRep)
								if IsTargetDead(lockState.model, lockRep)
									or (IsEnemyLead(lockRep, lockState.model) and not (cfg and cfg.shootLead == true))
									or (cfg.umbraPriority ~= false and hasUmbra and not lockIsUmbra)
									or (cfg.tricksterPriority ~= false and hasTrickster and not lockIsTrickster and not lockIsUmbra)
									or (cfg.portalPriority ~= false and hasVoidPortal and not lockIsPortal and not lockIsTrickster and not lockIsUmbra) then
									lockState.model = nil
									lockState.untilTick = 0
								else
									for i, tData in ipairs(targetList) do
										if tData.Model == lockState.model and i > 1 then
											table.remove(targetList, i)
											table.insert(targetList, 1, tData)
											break
										end
									end
								end
							end

							local baseDamage = GetTowerDamagePerShot(Replicator)
							local topTarget = targetList[1]
							local topIsShielded = topTarget and (
								ModelHasShield(topTarget.Model)
								or (topTarget.Model and string.find(string.lower(topTarget.Model.Name), "vindicator", 1, true) ~= nil)
								or topTarget.IsUmbra
								or topTarget.IsCorpse
								or topTarget.IsVoidPortal
								or topTarget.IsCrystal
								or topTarget.IsEye
								or topTarget.IsTrickster
								or IsUmbraTarget(topTarget.Model, topTarget.Replicator)
								or IsEyeTarget(topTarget.Model, topTarget.Replicator)
								or IsCorpseTarget(topTarget.Model, topTarget.Replicator)
								or IsTricksterTarget(topTarget.Model, topTarget.Replicator)
							)
							local topDefense = topIsShielded and 0 or (tonumber(topTarget and topTarget.Defense) or 0)
							local topDmgMult = topDefense > 0 and (1 / (1 + (topDefense / 100))) or 1
							local topEffectiveDamage = topIsShielded and baseDamage or math.max(1, math.floor(baseDamage * topDmgMult))
							local maxBudget = GetDynamicShotBudget(currentAmmo, topTarget, topEffectiveDamage)
							local shotsFired = 0
							local burstSize = math.clamp(math.floor(cfg.burstSize or 4), 1, 8)
							local towerRange = GetTowerRange(Replicator)
							local rangePadding = cfg.rangePadding or 3

							local effectiveMax = (cfg.smartTargeting == false) and 1 or math.clamp(math.floor(tonumber(cfg.maxTargets or cfg.maxTarget) or 5), 1, 5)
							if (cfg.umbraPriority ~= false and hasUmbra) or (cfg.tricksterPriority ~= false and hasTrickster) or (cfg.portalPriority ~= false and hasVoidPortal) then
								effectiveMax = 1
							end
							local activeTargets = {}

							for _, targetData in ipairs(targetList) do
								if #activeTargets >= effectiveMax then
									break
								end

								local targetModel = targetData.Model
								if not targetModel or not targetModel.Parent or not targetModel:IsDescendantOf(workspace) then
									if lockState.model == targetModel then
										lockState.model = nil
										lockState.untilTick = 0
									end
									continue
								end

								local targetPos = GetTargetPosition(targetData.HRP, targetModel)
								if not targetPos then
									if lockState.model == targetModel then
										lockState.model = nil
										lockState.untilTick = 0
									end
									continue
								end
								if (not ignoreRange) and towerRange and (targetPos - towerPos).Magnitude > (towerRange + rangePadding) then
									continue
								end

								if IsTargetDead(targetModel, targetData.Replicator, targetData.NPC)
									or (IsEnemyLead(targetData.Replicator, targetModel, targetData.NPC) and not (cfg and cfg.shootLead == true)) then
									if lockState.model == targetModel then
										lockState.model = nil
										lockState.untilTick = 0
									end
									continue
								end

								local liveHp, liveShield, _, liveDefense, liveRep = get_stats(targetModel, targetData.Replicator)
								if liveRep then
									targetData.Replicator = liveRep
								end
								local hp = (liveHp or 0) + (liveShield or 0)
								if hp <= 0 and (targetData.IsUmbra or targetData.IsCorpse or targetData.IsCrystal or targetData.IsVoidPortal or targetData.IsEye) then
									local fallbackHp = ReadNumericStat(targetModel, HEALTH_STAT_KEYS, true)
										or ReadNumericStat(targetModel, MAX_HEALTH_STAT_KEYS, true)
										or (targetData.Replicator and ReadNumericStat(targetData.Replicator, HEALTH_STAT_KEYS, true))
									if type(fallbackHp) == "number" and fallbackHp > 0 then
										hp = fallbackHp
									end
								end
								if hp <= 0 then
									if lockState.model == targetModel then
										lockState.model = nil
										lockState.untilTick = 0
									end
									continue
								end

								local isShielded = ModelHasShield(targetModel)
									or (targetModel and string.find(string.lower(targetModel.Name), "vindicator", 1, true) ~= nil)
									or targetData.IsUmbra
									or targetData.IsCorpse
									or targetData.IsVoidPortal
									or targetData.IsCrystal
									or targetData.IsEye
									or targetData.IsTrickster
									or IsUmbraTarget(targetModel, targetData.Replicator)
									or IsEyeTarget(targetModel, targetData.Replicator)
									or IsCorpseTarget(targetModel, targetData.Replicator)
									or IsTricksterTarget(targetModel, targetData.Replicator)
								local defense = isShielded and 0 or (tonumber(liveDefense) or tonumber(targetData.Defense) or 0)
								local defenseMult = defense > 0 and (1 / (1 + (defense / 100))) or 1
								local effectiveDmg = isShielded and baseDamage or math.max(1, math.floor(baseDamage * defenseMult))
								if not isShielded and cfg.shootImmune == false and effectiveDmg <= 0 then
									if lockState.model == targetModel then
										lockState.model = nil
										lockState.untilTick = 0
									end
									continue
								end
								local isExemptPending = targetData.IsUmbra or targetData.IsVoidPortal or targetData.IsSpecial or targetData.IsEye or targetData.IsCorpse or targetData.IsTrickster or isShielded or IsUmbraTarget(targetModel, targetData.Replicator) or IsEyeTarget(targetModel, targetData.Replicator) or IsCorpseTarget(targetModel, targetData.Replicator) or IsTricksterTarget(targetModel, targetData.Replicator)
								local pendingDamage = (cfg.autoCaliber and not isExemptPending) and GetPendingDamage(targetModel) or 0
								local effectiveHp = math.max(0, hp - pendingDamage)
								if effectiveHp <= 0 then
									if lockState.model == targetModel then
										lockState.model = nil
										lockState.untilTick = 0
									end
									continue
								end

								targetData.EffectiveDamage = effectiveDmg
								targetData.LiveHP = hp
								targetData.IsShielded = isShielded
								table.insert(activeTargets, targetData)
							end

							if #activeTargets > 0 then
								local targetIndex = 1

								while shotsFired < maxBudget and #activeTargets > 0 do
									local burstCount = math.min(burstSize, maxBudget - shotsFired)
									local firedThisBurst = 0

									for _ = 1, burstCount do
										if #activeTargets == 0 then
											break
										end

										if targetIndex > #activeTargets then
											targetIndex = 1
										end
										local targetData = activeTargets[targetIndex]
										local targetModel = targetData.Model

										local isDead = (not targetModel)
											or (not targetModel.Parent)
											or (not targetModel:IsDescendantOf(workspace))
											or IsTargetDead(targetModel, targetData.Replicator, targetData.NPC)
											or (IsEnemyLead(targetData.Replicator, targetModel, targetData.NPC) and not (cfg and cfg.shootLead == true))

										if not isDead then
											local checkHp, checkShield = get_stats(targetModel, targetData.Replicator)
											local currentHp = (checkHp or 0) + (checkShield or 0)
											if currentHp <= 0 and (targetData.IsUmbra or targetData.IsCorpse or targetData.IsCrystal or targetData.IsVoidPortal or targetData.IsEye) then
												local fallbackHp = ReadNumericStat(targetModel, HEALTH_STAT_KEYS, true)
													or ReadNumericStat(targetModel, MAX_HEALTH_STAT_KEYS, true)
													or (targetData.Replicator and ReadNumericStat(targetData.Replicator, HEALTH_STAT_KEYS, true))
												if type(fallbackHp) == "number" and fallbackHp > 0 then
													currentHp = fallbackHp
												end
											end
											local isShielded = (targetData.IsShielded == true)
												or ModelHasShield(targetModel)
												or (targetModel and string.find(string.lower(targetModel.Name), "vindicator", 1, true) ~= nil)
												or targetData.IsUmbra
												or targetData.IsCorpse
												or targetData.IsVoidPortal
												or targetData.IsCrystal
												or targetData.IsEye
												or IsUmbraTarget(targetModel, targetData.Replicator)
												or IsEyeTarget(targetModel, targetData.Replicator)
												or IsCorpseTarget(targetModel, targetData.Replicator)
											local isExemptPending = targetData.IsUmbra or targetData.IsVoidPortal or targetData.IsSpecial or targetData.IsEye or targetData.IsCorpse or targetData.IsTrickster or isShielded or IsUmbraTarget(targetModel, targetData.Replicator) or IsEyeTarget(targetModel, targetData.Replicator) or IsCorpseTarget(targetModel, targetData.Replicator) or IsTricksterTarget(targetModel, targetData.Replicator)
											local currentPending = (cfg.autoCaliber and not isExemptPending) and GetPendingDamage(targetModel) or 0
											if currentHp <= 0 or (currentHp - currentPending) <= 0 then
												isDead = true
											end
										end

										if isDead then
											if lockState.model == targetModel then
												lockState.model = nil
												lockState.untilTick = 0
											end
											table.remove(activeTargets, targetIndex)
											if #activeTargets == 0 then
												break
											end
											if targetIndex > #activeTargets then
												targetIndex = 1
											end
											targetData = activeTargets[targetIndex]
											targetModel = targetData.Model
										end

										local shotTowerHrp = Tower:FindFirstChild("HumanoidRootPart")
										local shotTowerPos = shotTowerHrp and shotTowerHrp.Position or towerPos
										local barrel = Tower:FindFirstChild("Barrel", true)
										local shotOrigin = (barrel and barrel:IsA("BasePart") and barrel.Position) or (shotTowerPos + Vector3.new(0, 1.8, 0))
										local centerPos = GetTargetPosition(targetData.HRP, targetModel)
										local isUmbra = targetData.IsUmbra or IsUmbraTarget(targetModel, targetData.Replicator)
										if isUmbra then
											if cfg and cfg.umbraAimLegs ~= false then
												local legPos = GetUmbraLegPosition(targetModel)
												if legPos then
													centerPos = legPos
												end
											end
											if not centerPos then
												local umbraPart = GetUmbraAimPart(targetModel)
												if umbraPart and umbraPart:IsA("BasePart") then
													centerPos = umbraPart.Position
												end
											end
										end
										local isEye = targetData.IsEye or IsEyeTarget(targetModel, targetData.Replicator)
										if isEye then
											local hitbox = targetModel:FindFirstChild("Hitbox", true)
											if hitbox and hitbox:IsA("BasePart") then
												centerPos = hitbox.Position
											end
										end
										local isBreaker = targetData.IsBreaker or IsBreakerTarget(targetModel, targetData.Replicator)
										if isBreaker then
											local breakerHitbox = GetBreakerAimPart(targetModel)
											if breakerHitbox and breakerHitbox:IsA("BasePart") then
												centerPos = breakerHitbox.Position
											end
										end
										local guardianHitbox = (targetData.IsGuardian or IsGuardianTarget(targetModel, targetData.Replicator))
											and (targetModel:FindFirstChild("Hitbox", true) or targetModel:FindFirstChild("HumanoidRootPart", true) or targetModel.PrimaryPart)
										if guardianHitbox and guardianHitbox:IsA("BasePart") then
											centerPos = guardianHitbox.Position
										end
										if not centerPos then
											table.remove(activeTargets, targetIndex)
											if #activeTargets == 0 then
												break
											end
											if targetIndex > #activeTargets then
												targetIndex = 1
											end
											targetData = activeTargets[targetIndex]
											targetModel = targetData.Model
											centerPos = GetTargetPosition(targetData.HRP, targetModel)
											if not centerPos then
												break
											end
										end

										local firePos
										firePos, shotPatternCounter = ComputeAdaptiveFirePosition(
											cfg,
											shotPatternCounter,
											shotOrigin,
											targetData,
											targetModel,
											centerPos,
											Replicator
										)
										if not firePos then
											break
										end

										local rayFirePos = GetDirectRaycastPosition(shotOrigin, targetModel, firePos, Tower)
										if rayFirePos then
											firePos = rayFirePos
										end

										transport:Aim(firePos)
										pcall(function()
											if gganim and type(gganim._aim) == "function" then
												gganim:_aim(firePos)
											end
										end)

										-- Penetration extension: extend bullet through target along ray vector to guarantee server hit registration
										local toTarget = firePos - shotOrigin
										local serverFirePos = firePos
										if toTarget.Magnitude > 0.5 then
											local extendDist = isUmbra and 35 or 15
											serverFirePos = firePos + (toTarget.Unit * extendDist)
										end

										if not transport:Fire(serverFirePos) then
											break
										end

										local isExemptAddPending = targetData.IsUmbra or targetData.IsVoidPortal or targetData.IsSpecial or targetData.IsEye or targetData.IsCorpse or targetData.IsTrickster or targetData.IsShielded or IsUmbraTarget(targetModel, targetData.Replicator) or IsEyeTarget(targetModel, targetData.Replicator) or IsCorpseTarget(targetModel, targetData.Replicator) or IsTricksterTarget(targetModel, targetData.Replicator)
										if cfg.autoCaliber and (targetData.EffectiveDamage or 0) > 0 and not isExemptAddPending then
											AddPendingDamage(targetModel, targetData.EffectiveDamage)
										end

										local visualPos = GetTargetVisualPosition(targetModel, firePos)
										SpawnBulletLine(Tower, Replicator, visualPos, targetModel)

										shotsFired = shotsFired + 1
										firedThisBurst = firedThisBurst + 1

										if cfg.lockOnTarget and targetModel then
											lockState.model = targetModel
											lockState.untilTick = os.clock() + (cfg.lockGraceTime or 0.2)
										end

										targetIndex = targetIndex + 1
										if targetIndex > #activeTargets then
											targetIndex = 1
										end

										if shotsFired >= maxBudget then
											break
										end
									end

									if firedThisBurst <= 0 then
										break
									end

									if shotsFired < maxBudget and #activeTargets > 0 then
										if cfg.autoCaliber then
											task.wait(math.clamp(tonumber(cfg.autoCaliberStrongWait) or 0.006, 0, 0.02))
										elseif burstSize <= 1 then
											task.wait()
										end
									end
								end
							end
							loopDelay = GetDynamicLoopDelay(topTarget, topEffectiveDamage, shotsFired, maxBudget)
						else
							loopDelay = 1 / math.max(1, tonumber(cfg.minFireRate) or 14)
						end
					end
				end
			end, function(err)
				return tostring(err) .. "\n" .. debug.traceback()
			end)

				if not ok then
					warn("[AutoGatling Loop Error]: " .. tostring(loopErr))
					task.wait(0.05)
				else
					task.wait(loopDelay)
				end
			end
		end)

		getgenv().RunningTowers[Tower] = muscleTask
	end)

	if not success then
		warn("Hook Error: " .. tostring(err))
		StopSpecificHook(Tower)
	end
end

local towersFolder = workspace:WaitForChild("Towers")
if towersFolder then
	local function checkTower(Tower)
		task.spawn(function()
			local Replicator = Tower:WaitForChild("TowerReplicator", 10)
			if not Replicator then
				return
			end
			task.wait(0.1)
			if not IsOwnedByLocalPlayer(Tower, Replicator) then
				return
			end
			if string.find(string.lower(Replicator:GetAttribute("Name") or ""), "gatling") then
				if not IsOwnedByLocalPlayer(Tower, Replicator) then
					return
				end
				getgenv().StartHooks(Tower)
			end
		end)
	end
	towersFolder.ChildAdded:Connect(checkTower)
	for _, t in pairs(towersFolder:GetChildren()) do
		checkTower(t)
	end
end
