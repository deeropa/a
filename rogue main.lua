        local _scriptOk, _scriptErr = xpcall(function()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeropa/a/refs/heads/main/notificationsystem.lua"))()
local TweenSpeed = 200

local tween_s = game:GetService("TweenService")
local lp = game.Players.LocalPlayer
local wrksp = game.Workspace

if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...) return ... end
end
LPH_NO_VIRTUALIZE(function()
    local lp = game:GetService("Players").LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local success, err = pcall(function()
        repeat task.wait() until lp.Character
        local RunService = game:GetService("RunService")
        local scriptContextError = game:GetService("ScriptContext").Error
        local call
        for i, v in next, getconnections(scriptContextError) do
            v:Disable()
        end
        call = hookmetamethod(game, '__namecall', newcclosure(function(Self, ...)
            if not checkcaller() then
                local method = getnamecallmethod()
                local args = {...}
                if Self == RunService and method == 'IsStudio' then
                    return true
                end
                if Self == scriptContextError and method == 'Connect' then
                    -- Return a fake connection object so game code doesn't error
                    return {
                        Connected = false,
                        Disconnect = function() end,
                        disconnect = function() end,
                    }
                end
                if (Self == lp.Character or Self == workspace or Self == game) and (method == "GetChildren" or method == "GetDescendants") then
                    local real_result = call(Self, ...)
                    local spoofed = {}
                    for i, v in ipairs(real_result) do
                        pcall(function()
                            if not v:IsA("Highlight") and not v:IsA("BillboardGui") and not v:IsA("Folder") and not v:IsA("BodyVelocity") and not v:IsA("BodyGyro") then
                                table.insert(spoofed, v)
                            end
                        end)
                    end
                    return spoofed
                end
            end
            return call(Self, ...)
        end))
        local OldCoroutineWrap
        OldCoroutineWrap = hookfunction(coroutine.wrap, function(Self, ...)
            if not checkcaller() then
                local info = debug.getinfo(Self)
                if info and info.source and info.source:match("Input") then
                    local args = {...}
                    local constants = getconstants(Self)
                    if constants[5] and typeof(constants[5]) == "string" and constants[5]:match("CHECK PASSED:") then
                        return OldCoroutineWrap(Self, ...)
                    end
                    if constants[1] and typeof(constants[1]) == "string" and constants[2] and typeof(constants[2]) == "string" and (constants[1]:match("scr") and constants[2]:match("Parent")) then
                        game:GetService("Players").LocalPlayer:Kick("KIKI Hub Ban Prevented (You can rejoin)")
                        return coroutine.yield()
                    end
                end
            end
            return OldCoroutineWrap(Self, ...)
        end)
        getgenv().SAntiCheatBypass = true
    end)
    if not success then
        lp:Kick("Failed to Disable Anti-Cheat please rejoin")
        warn(success, err)
        return
    end
end)()
          
local scriptContext = game:GetService("ScriptContext")
local logService = game:GetService("LogService")

task.spawn(function()
    if not isfolder("KikiHubPaths") then 
        makefolder("KikiHubPaths")
    end

    if not isfolder("KikiHubAssets") then 
        makefolder("KikiHubAssets")
    end

    if not isfile("KikiHubAssets/ModeratorJoin.mp3") then
        pcall(function() writefile("KikiHubAssets/ModeratorJoin.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/ModeratorJoin.mp3")) end)
    end

    if not isfile("KikiHubAssets/IlluJoin.mp3") then
        pcall(function() writefile("KikiHubAssets/IlluJoin.mp3", game:HttpGet("https://raw.githubusercontent.com/deeropa/a/refs/heads/main/Illu.mp3")) end)
    end

    if not isfile("KikiHubAssets/ObserveEquip.mp3") then
        pcall(function() writefile("KikiHubAssets/ObserveEquip.mp3", game:HttpGet("https://raw.githubusercontent.com/deeropa/a/refs/heads/main/Illuequip.mp3")) end)
    end
end)

-- Generic playSound function: plays a local mp3 file as a Sound
-- Caches getcustomasset IDs so repeated calls are fast
local _soundCache = {}
local function playSound(filePath, volume)
    pcall(function()
        if not isfile(filePath) then return end
        
        local soundId = _soundCache[filePath]
        if not soundId then
            soundId = getcustomasset(filePath)
            _soundCache[filePath] = soundId
        end
        if not soundId then return end
        
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = volume or 2.5
        sound.Parent = game:GetService("CoreGui")
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 10)
    end)
end

for _, connection in pairs(getconnections(scriptContext.Error)) do
    connection:Disable()
end
for _, connection in pairs(getconnections(logService.MessageOut)) do
    connection:Disable()
end


-- Artifact Notifier
local foundParts = {}
local Debris = game:GetService("Debris")

-- Download artifact notification sound to KikiHubAssets
if not isfile("KikiHubAssets/Artifact.mp3") then
    pcall(function()
        writefile("KikiHubAssets/Artifact.mp3", game:HttpGet("https://raw.githubusercontent.com/deeropa/a/refs/heads/main/Artifact.mp3"))
    end)
end

local ArtifactSoundID = nil
pcall(function()
    ArtifactSoundID = getcustomasset("KikiHubAssets/Artifact.mp3")
end)

local function playArtifactSound()
    if not ArtifactSoundID then return end
    local sound = Instance.new("Sound")
    sound.SoundId = ArtifactSoundID
    sound.Volume = 2.5
    sound.Parent = workspace
    sound:Play()
    Debris:AddItem(sound, 5)
end

-- Check if object is an artifact and return its name
local function GetLabelName(obj)
    local p = obj.Parent
    if not p then return nil end
    if not (p:IsA("Part") or p:IsA("UnionOperation")) then return nil end

    local color = p.Color
    local attachment = p:FindFirstChild("Attachment")
    local particle = p:FindFirstChildWhichIsA("ParticleEmitter", true)

    if p:IsA("Part") then
        if color == Color3.fromRGB(128, 187, 219) then return "Fairfrozen", true end

        if p:FindFirstChild("OrbParticle") and p.OrbParticle.Texture == "rbxassetid://20443483" then
            return "Ice Essence", true
        end

        if particle and particle.Color and particle.Color.Keypoints and particle.Color.Keypoints[1].Value == Color3.new(1, 0.8, 0) then
            return "Phoenix Down", true
        end

        if attachment and attachment:FindFirstChild("ParticleEmitter") then
            local pe = attachment.ParticleEmitter
            if pe.Texture == "rbxassetid://1536547385" then
                if game.PlaceId == 3541987450 then return "Phoenix Flower", true end
                if pe.Color.Keypoints and pe.Color.Keypoints[1].Value == Color3.new(0, 1, 0.207843) then
                    return "Azael Horn", true
                end
                return "Mysterious Artifact", true
            end
        end

    elseif p:IsA("UnionOperation") then
        if color == Color3.fromRGB(248, 248, 248) and not p.UsePartColor then return "Lannis Amulet", true end
        if color == Color3.fromRGB(29, 46, 58) then return "Night Stone", true end
        if color == Color3.fromRGB(163, 162, 165) then return "Amulet Of The White King", true end
    end

    return nil
end

-- Checks part for artifact and shows notification
local function checkPartForArtifact(obj)
    if foundParts[obj] then return end
    local success, name, isArtifact = pcall(GetLabelName, obj)
    if not success then warn("[ArtifactNotifier] Check error:", name) return end
    if name then
        foundParts[obj] = true
        task.spawn(function()
            local ok, err = pcall(playArtifactSound)
            if not ok then warn("[ArtifactNotifier] Sound error:", err) end
            local ok2, err2 = pcall(notify, "Artifact Found: " .. name, Color3.fromRGB(255, 215, 0), 8)
            if not ok2 then warn("[ArtifactNotifier] Notify error:", err2) end
        end)
    end
end

-- Scan existing artifacts in the workspace
local function scanExistingParts()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            if not (workspace:FindFirstChild("Thrown") and obj:IsDescendantOf(workspace.Thrown)) then
                checkPartForArtifact(obj)
            end
        end
    end
end

-- Start scanning after everything loads
task.spawn(function()
    repeat task.wait() until game.Players.LocalPlayer and workspace.CurrentCamera
    task.wait(2)
    local ok, err = pcall(scanExistingParts)
    if not ok then warn("[ArtifactNotifier] Initial scan error:", err) end
end)

-- Watch for new artifacts being added
workspace.DescendantAdded:Connect(function(obj)
    local ok, err = pcall(function()
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            if not (workspace:FindFirstChild("Thrown") and obj:IsDescendantOf(workspace.Thrown)) then
                checkPartForArtifact(obj)
            end
        end
    end)
    if not ok then warn("[ArtifactNotifier] DescendantAdded error:", err) end
end)

local Window = Fluent:CreateWindow({
    Title = "KIKI Hub V." .. 2.0,
    SubTitle = "By KIKI, Wowzers, BloxyHDD",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    GeneralTab = Window:AddTab({ Title = "Main", Icon = "" }),
    PlayerTab = Window:AddTab({ Title = "Player", Icon = "" }),
    RageTab = Window:AddTab({ Title = "Blatant", Icon = "" }),
    EspTab = Window:AddTab({ Title = "Trinket & Esp", Icon = "" }),
    MiscTab = Window:AddTab({ Title = "Miscellaneous", Icon = "" }),
    BotsTab = Window:AddTab({ Title = "Bots", Icon = "" }),
    AutomationTab = Window:AddTab({ Title = "Automation", Icon = "" }),
    ExploitsTab = Window:AddTab({ Title = "Exploits", Icon = "" }),

    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    
}

local Options = Fluent.Options

do
    local PossibleContent = {
        "KIKI, Wowzer and Bloxy wish you a merry christmas.",
        "Hey did you know that this script was for Richest Minion at first?",
        "The name KIKI Hub was created because KIKI had no creativity",
        "M2 on leaderboard to spectate",
        "Bloxy has an youtube channel with lua tutorials check it out: BloxyHDD on youtube",
        "At one point script was almost discontinued because of a lack of motivation",
        "Wowzer is a really good coder",
        "Did you know ? The illu sound is made by Wowzer",
        "Happy Exploiting: ".. game.Players.LocalPlayer.Name
    }
    
    Fluent:Notify({
        Title = "KIKI Hub Loaded! (Fun Facts Below)",
        Content = PossibleContent[math.random(#PossibleContent)],
        SubContent = nil,
        Duration = 10
    })
    
    setfpscap(500)

    local _Player = game.Players.LocalPlayer
    local FrameLIST = _Player.PlayerGui:WaitForChild("LeaderboardGui").MainFrame.ScrollingFrame

    local open = false
    local previous_p

    local Play = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local user = Instance.new("TextLabel")
    local Artifact = Instance.new("TextLabel")
    local health = Instance.new("Frame")
    local Frame_2 = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local inv = Instance.new("TextLabel")
    local class = Instance.new("TextLabel")

    Frame.Visible = false

    Play.Name = "Play"
    Play.Parent = game:GetService("CoreGui")

    Frame.Parent = Play
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(18, 0, 25)
    Frame.BackgroundTransparency = 0.500
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.795792878, 0, 0.253740638, 0)
    Frame.Size = UDim2.new(0.136569574, 0, 0.471571118, 0)

    user.Name = "user"
    user.Parent = Frame
    user.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    user.BackgroundTransparency = 1.000
    user.BorderColor3 = Color3.fromRGB(0, 0, 0)
    user.BorderSizePixel = 0
    user.Size = UDim2.new(1, 0, 0.0904284492, 0)
    user.Font = Enum.Font.Fantasy
    user.Text = "username"
    user.TextColor3 = Color3.fromRGB(247, 247, 247)
    user.TextScaled = true
    user.TextSize = 14.000
    user.TextWrapped = true

    Artifact.Name = "Artifact"
    Artifact.Parent = Frame
    Artifact.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Artifact.BackgroundTransparency = 1.000
    Artifact.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Artifact.BorderSizePixel = 0
    Artifact.Position = UDim2.new(0, 0, 0.0904284492, 0)
    Artifact.Size = UDim2.new(1, 0, 0.0555261746, 0)
    Artifact.Font = Enum.Font.Fantasy
    Artifact.Text = "Artifact: "
    Artifact.TextColor3 = Color3.fromRGB(247, 247, 247)
    Artifact.TextScaled = true
    Artifact.TextSize = 14.000
    Artifact.TextWrapped = true

    class.Name = "class"
    class.Parent = Frame
    class.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    class.BackgroundTransparency = 1.000
    class.BorderColor3 = Color3.fromRGB(0, 0, 0)
    class.BorderSizePixel = 0
    class.Position = UDim2.new(0, 0, 0.168481728, 0)
    class.Size = UDim2.new(1, 0, 0.0555261746, 0)
    class.Font = Enum.Font.Fantasy
    class.Text = "Class: "
    class.TextColor3 = Color3.fromRGB(247, 247, 247)
    class.TextScaled = true
    class.TextSize = 14.000
    class.TextWrapped = true

    health.Name = "health"
    health.Parent = Frame
    health.BackgroundColor3 = Color3.fromRGB(54, 58, 54)
    health.BorderColor3 = Color3.fromRGB(0, 0, 0)
    health.BorderSizePixel = 0
    health.Position = UDim2.new(0, 0, 0.909571528, 0)
    health.Size = UDim2.new(1, 0, 0.0898995176, 0)

    Frame_2.Parent = health
    Frame_2.BackgroundColor3 = Color3.fromRGB(21, 130, 13)
    Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Size = UDim2.new(1, 0, 1, 0)

    TextLabel.Parent = health
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.Fantasy
    TextLabel.Text = "55/100"
    TextLabel.TextColor3 = Color3.fromRGB(198, 255, 207)
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true

    inv.Name = "inv"
    inv.Parent = Frame
    inv.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    inv.BackgroundTransparency = 1.000
    inv.BorderColor3 = Color3.fromRGB(0, 0, 0)
    inv.BorderSizePixel = 0
    inv.Position = UDim2.new(0.0236966833, 0, 0.22474879, 0)
    inv.Size = UDim2.new(0.947867274, 0, 0.668958127, 0)
    inv.Font = Enum.Font.Fantasy
    inv.TextColor3 = Color3.fromRGB(255, 255, 255)
    inv.TextScaled = true
    inv.TextSize = 14.000
    inv.TextWrapped = true

    function getInv(player)
        local itemCounts = {}
        pcall(function()
            if player.Character and player:FindFirstChild("Backpack") then
                local items = player.Backpack:GetChildren()
                for _, item in pairs(items) do
                    if item:IsA("Tool") then
                        local itemName = item.Name
                        if itemCounts[itemName] then
                            itemCounts[itemName] = itemCounts[itemName] + 1
                        else
                            itemCounts[itemName] = 1
                        end
                    end
                end
            end
        end)

        local content = "Items in Backpack: "
        for itemName, itemCount in pairs(itemCounts) do
            if itemCount > 1 then
                content = content .. itemCount .. "x " .. itemName .. ", "
            else
                content = content .. itemName .. ", "
            end
        end

        inv.Text = content
        return content
    end

    local UltraAbilities = {
        ["Lightning Drop"] = "Dragon Sage",
        ["Axe Kick"] = "Oni",
        ["Observe"] = "Illusionist",
        ["Perflora"] = "Druid",
        ["Secare"] = "Necromancer",
        ["Elegant Slash"] = "Whisperer",
        ["Joyous Dance"] = "Bard",
        ["Grapple"] = "Shinobi",
        ["Shadow Fan"] = "Faceless",
        ["Dragon Awakening"] = "Dragon Slayer",
        ["Chain Pull"] = "Deep Knight",
        ["Hyper Body"] = "Sigil Knight Commander",
        ["Dark Eruption"] = "Dark Sigil",
        ["Hammer"] = "Lapidarist",
        ["Katana"] = "Ronin",
        ["Abyssal Scream"] = "Abysswalker",
        ["Puncture"] = "Vanguard"
    }

    function showInv(plrName)
        pcall(function()
            local player
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character ~= nil and (string.lower(v.Character.Name) == string.lower(string.gsub(tostring(plrName), "[^%w%s_]+", ""))) then
                    player = v
                    break
                end
            end
            if not player then return end

            if player == previous_p then
                Frame.Visible = false
                previous_p = nil
                return
            else
                if previous_p then
                    Frame.Visible = false
                end
                Frame.Visible = true
            end

            user.Text = plrName
            local artifactText = "Artifacts: "
            if player.Character and player.Character.Artifacts then
                for i, v in pairs(player.Character.Artifacts:GetChildren()) do
                    artifactText = artifactText .. v.Name .. " "
                end
            end
            Artifact.Text = artifactText

            local playerClass = "N/A"
            for ability, className in pairs(UltraAbilities) do
                if player.Character:FindFirstChild(ability) or (player.Backpack and player.Backpack:FindFirstChild(ability)) then
                    playerClass = className
                    break
                end
            end

            class.Text = "Class: " .. playerClass
            health.TextLabel.Text = math.floor(player.Character.Humanoid.Health) .. "/" .. math.floor(player.Character.Humanoid.MaxHealth)
            health.Frame.Size = UDim2.fromScale((player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth), 1)

            inv.Text = getInv(player)
            previous_p = player
        end)
    end

    local Player = game.Players.LocalPlayer
    local LeaderboardFrame = Player.PlayerGui:WaitForChild("LeaderboardGui").MainFrame.ScrollingFrame
    local Camera = game.Workspace.CurrentCamera
    local spectating = false

    function Spectate(plrName)
        pcall(function()
            local player
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character ~= nil and (string.lower(v.Character.Name) == string.lower(string.gsub(tostring(plrName), "[^%w%s_]+", ""))) then
                    player = v
                    break
                end
            end

            if spectating == false then
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    Camera.CameraSubject = player.Character.Humanoid
                    spectating = true
                end
            else
                if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Camera.CameraSubject = Player.Character.Humanoid
                    spectating = false
                end
            end
        end)
    end

    local hookedInputs = {}

    function init2()
        -- No cleanup needed since we don't inject children anymore
    end

    function init()
        pcall(function()
            for _, ch in pairs(game.Workspace.Live:GetChildren()) do
                ch.Archivable = true
            end

            for _, obj in pairs(LeaderboardFrame:GetChildren()) do
                if obj:IsA("TextLabel") and not hookedInputs[obj] then
                    hookedInputs[obj] = true
                    obj.Active = true
                    obj.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local plrName = obj.Text:gsub("%s+", "")
                            showInv(plrName)
                        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                            local plrName = obj.Text:gsub("%s+", "")
                            Spectate(plrName)
                        end
                    end)
                end
            end
        end)
    end

    -- Color-code leaderboard labels by player type
    local ULTRA_COLOR = Color3.fromRGB(255, 60, 60)       -- Red for Ultras
    local ILLUSIONIST_COLOR = Color3.fromRGB(80, 120, 255) -- Blue for Illusionists
    local FRESHIE_COLOR = Color3.fromRGB(255, 255, 255)   -- White for Freshies
    local OFFLINE_COLOR = Color3.fromRGB(120, 120, 120)   -- Gray for offline

    function getPlayerClassFromCharacter(character)
        if not character then return nil end
        for ability, className in pairs(UltraAbilities) do
            if character:FindFirstChild(ability) then
                return className
            end
        end
        -- Also check if any player owns this character and check their backpack
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character == character and player:FindFirstChild("Backpack") then
                for ability, className in pairs(UltraAbilities) do
                    if player.Backpack:FindFirstChild(ability) then
                        return className
                    end
                end
            end
        end
        return "Freshie"
    end

    -- Color caching system
    local settingColor = {}   -- guard: true while WE are changing color
    local cachedColor = {}    -- cached color per label object
    local cachedName = {}     -- cached original in-game name per label
    local hookedLabels = {}

    -- Find character by name in workspace.Live
    function findCharacterByName(name)
        local liveFolder = workspace:FindFirstChild("Live")
        if not liveFolder then return nil end

        for _, playerFolder in pairs(liveFolder:GetChildren()) do
            if playerFolder.Name:sub(1, 1) ~= "." then
                -- Match by Roblox username
                if playerFolder.Name == name then
                    for _, child in pairs(playerFolder:GetChildren()) do
                        if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
                            return child
                        end
                    end
                end
                -- Match by in-game name
                for _, child in pairs(playerFolder:GetChildren()) do
                    if child:IsA("Model") and child.Name == name and child:FindFirstChildOfClass("Humanoid") then
                        return child
                    end
                end
            end
        end
        return nil
    end

    -- Determine color from a name and cache it
    function determineColor(name)
        local character = findCharacterByName(name)
        if character then
            local playerClass = "Freshie"
            for ability, className in pairs(UltraAbilities) do
                if character:FindFirstChild(ability) then
                    playerClass = className
                    break
                end
            end
            if playerClass == "Freshie" then
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr.Character == character.Parent or plr.Character == character then
                        if plr:FindFirstChild("Backpack") then
                            for ability, className in pairs(UltraAbilities) do
                                if plr.Backpack:FindFirstChild(ability) then
                                    playerClass = className
                                    break
                                end
                            end
                        end
                        break
                    end
                end
            end
            if playerClass == "Illusionist" then
                return ILLUSIONIST_COLOR
            elseif playerClass ~= "Freshie" then
                return ULTRA_COLOR
            else
                return FRESHIE_COLOR
            end
        end
        return OFFLINE_COLOR
    end

    -- Calculate and cache color for a label (uses current text as the name)
    function calculateColor(obj)
        pcall(function()
            if not obj:IsA("TextLabel") then return end
            local labelName = obj.Text:gsub("^%s+", ""):gsub("%s+$", "")
            local color = determineColor(labelName)

            -- Only cache name if this looks like an in-game name (matched successfully)
            if color ~= OFFLINE_COLOR then
                cachedName[obj] = labelName
            end
            cachedColor[obj] = color

            settingColor[obj] = true
            obj.TextColor3 = color
            settingColor[obj] = nil
        end)
    end

    -- Recalculate using the CACHED name (not current text)
    function recalculateFromCache(obj)
        pcall(function()
            if not obj:IsA("TextLabel") then return end
            local name = cachedName[obj]
            if not name then return end

            local color = determineColor(name)
            cachedColor[obj] = color

            settingColor[obj] = true
            obj.TextColor3 = color
            settingColor[obj] = nil
        end)
    end

    -- Re-apply cached color without recalculating
    function applyCache(obj)
        if cachedColor[obj] then
            settingColor[obj] = true
            obj.TextColor3 = cachedColor[obj]
            settingColor[obj] = nil
        end
    end

    function hookLabel(obj)
        if not obj:IsA("TextLabel") or hookedLabels[obj] then return end
        hookedLabels[obj] = true
        calculateColor(obj)
        -- When GAME changes color (hover), just re-apply our cached color
        obj:GetPropertyChangedSignal("TextColor3"):Connect(function()
            if settingColor[obj] then return end
            task.defer(function() applyCache(obj) end)
        end)
    end

    init2()
    task.wait(0.25)
    init()

    -- Hook all existing labels
    for _, obj in pairs(LeaderboardFrame:GetChildren()) do
        hookLabel(obj)
    end
    -- Hook new labels as they're added
    LeaderboardFrame.ChildAdded:Connect(function(obj)
        task.wait(0.1)
        init()
        hookLabel(obj)
    end)

    -- Background refresh: use cached name if available, otherwise retry with current text
    task.spawn(function()
        while task.wait(3) do
            for _, obj in pairs(LeaderboardFrame:GetChildren()) do
                if obj:IsA("TextLabel") then
                    if cachedName[obj] then
                        recalculateFromCache(obj)
                    else
                        calculateColor(obj) -- retry for labels that failed to match initially
                    end
                end
            end
        end
    end)


--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// GUI Setup
local Proximity = Instance.new("ScreenGui")
Proximity.Name = "Proximity"
Proximity.Parent = PlayerGui
Proximity.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = Proximity
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.386, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 364, 0, 100)
MainFrame.Visible = false

local ProxLabel = Instance.new("TextLabel")
ProxLabel.Name = "ProxLabel"
ProxLabel.Parent = MainFrame
ProxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProxLabel.BackgroundTransparency = 1.000
ProxLabel.BorderSizePixel = 0
ProxLabel.Size = UDim2.new(1, 0, 1, 0)
ProxLabel.Font = Enum.Font.Code
ProxLabel.Text = ""
ProxLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
ProxLabel.TextSize = 25.000

--// Fake name extractor
local function getFakeName(character)
    if not character then return nil end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Model") and child:FindFirstChild("FakeHumanoid") and child:FindFirstChild("Head") then
            return child.Name
        end
    end
    return nil
end

--// Wait for UI framework to be ready
task.spawn(function()
    repeat task.wait() until Tabs and Tabs.GeneralTab

    local ToggleState = true

    local Toggle = Tabs.GeneralTab:AddToggle("Proximity", {
        Title = "Player Proximity",
        Default = true
    })

    Toggle:OnChanged(function(value)
        ToggleState = value
        if not value then
            MainFrame.Visible = false
        end
    end)

    local lastProxUpdate = 0
    RunService.RenderStepped:Connect(function()
        if not ToggleState then return end
        if (tick() - lastProxUpdate) < 0.1 then return end
        lastProxUpdate = tick()

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local localHRP = character and character:FindFirstChild("HumanoidRootPart")
        if not localHRP then return end

        local closestPlayer = nil
        local closestDistance = 700

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local otherHRP = player.Character.HumanoidRootPart
                local distance = (localHRP.Position - otherHRP.Position).Magnitude
                if distance <= closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end

        if closestPlayer then
            local fakeName = getFakeName(closestPlayer.Character)
            local displayName = fakeName or closestPlayer.Name
            ProxLabel.Text = string.format("%s is %.1f studs away", displayName, closestDistance)
            MainFrame.Visible = true
        else
            MainFrame.Visible = false
        end
    end)
end)




    local plr = game:GetService("Players").LocalPlayer.Character
    
    local healthConnections = {}

    local function applyHealthDistance(v, toggleValue)
        if v ~= plr then
            local z = v:FindFirstChildWhichIsA("Humanoid")
            if z then
                z.HealthDisplayType = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
                if v:FindFirstChild("MonsterInfo") then
                    z.NameDisplayDistance = 0
                end
                z.HealthDisplayDistance = toggleValue and 35 or 0
                z.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Subject
            end
        end
    end

    local function setPlayerHealthDistance(toggleValue)
        -- Apply to existing
        for i, v in pairs(workspace.Live:GetChildren()) do
            applyHealthDistance(v, toggleValue)
        end
        
        -- Disconnect old connection if it exists
        if healthConnections["LiveAdded"] then
            healthConnections["LiveAdded"]:Disconnect()
            healthConnections["LiveAdded"] = nil
        end
        
        -- Connect to new instances if toggled on
        if toggleValue then
            healthConnections["LiveAdded"] = workspace.Live.ChildAdded:Connect(function(v)
                -- Wait a tiny bit for the humanoid to load in the new character
                task.wait(0.1)
                applyHealthDistance(v, true)
            end)
        end
    end

    local Toggle = Tabs.GeneralTab:AddToggle("HealerEdictTog", {Title = "Show Healthbars", Default = false })
    
     Toggle:OnChanged(function()
       setPlayerHealthDistance(Options.HealerEdictTog.Value)
    end)





    local Toggle = Tabs.GeneralTab:AddToggle("ModNotifyTog", {Title = "Notification on Mod Join", Default = true})
    notify("Checking for Moderators...", Color3.fromRGB(255, 180, 0), 4.5)
    
    local staff = {
        "Nuttoons", "Selanto12", "lulux44", "LucidZero", "NotASeraph",
        "jassbux", "fun135090", "Divinos", "pugrat447", "huuc", "baneH1",
        "Orchamy", "ZaeoMR", "Potioncake", "Sayaphic", "Noah5254",
        "Seoi_Ha", "Torrera", "v_sheep", "Voidsealer", "2Squids",
        "pyfrog", "crazywealthyman", "warycoolio", "marvindot", "Taelyia",
        "SuperEashan", "lleirbag", "Lord_Dusk", "bluetetraninja",
        "killer67564564643", "0OAmnesiaO0", "SlrCIover", "WinterFIare",
        "WorkyCIock", "LunarKaiser", "Kark1n0s", "HateKait", "Frostdraw",
        "iltria", "yomamagamer1", "Etrn_al", "Thunder878712817",
        "TheNotDave", "Yuukisnoob", "fiod1", "GIovoc", "f_fatexyz",
        "Ragenbiter (KIKI Hub Owner)"
    }
    
    -- Helper: get in-game name from workspace.Live character model
    local function getInGameName(player)
        local liveFolder = workspace:FindFirstChild("Live")
        if liveFolder then
            local playerFolder = liveFolder:FindFirstChild(player.Name)
            if playerFolder then
                for _, child in pairs(playerFolder:GetChildren()) do
                    if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
                        return child.Name
                    end
                end
            end
        end
        return player.Name -- fallback to roblox name
    end

    local function checkIsMod(player)
        if not Options.ModNotifyTog.Value then return end
        
        if table.find(staff, player.Name) then
            playSound("KikiHubAssets/ModeratorJoin.mp3")
            local ingame = getInGameName(player)
            notify("Moderator in Your Server! " .. ingame, Color3.fromRGB(255, 60, 60), 30)
        end
    end
    
    -- Check players already in the server
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        checkIsMod(player)
    end
    
    -- Check new players joining
    game:GetService("Players").PlayerAdded:Connect(checkIsMod)
       
local illus = {}
local notifierEnabled = false

local IlluToggle = Tabs.GeneralTab:AddToggle("Illu", { Title = "Illusionist Notifier", Default = true })

IlluToggle:OnChanged(function()
    notifierEnabled = Options.Illu.Value
end)

local function handlePlayer(plr)
    -- Check if Observe is already in Backpack
    local backpack = plr:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChild("Observe") and not table.find(illus, plr) then
        table.insert(illus, plr)

        playSound("KikiHubAssets/IlluJoin.mp3")

        notify("Illusionist in Your Server! " .. getInGameName(plr), Color3.fromRGB(80, 120, 255), 15)
    end

    -- Listen for tool added to Backpack
    if backpack then
        backpack.ChildAdded:Connect(function(item)
            if item.Name == "Observe" and not table.find(illus, plr) and notifierEnabled then
                table.insert(illus, plr)

                    playSound("KikiHubAssets/IlluJoin.mp3")

                notify("Illusionist in Your Server! " .. getInGameName(plr), Color3.fromRGB(80, 120, 255), 15)
            end
        end)
    end

    -- Listen for tool being equipped (moved to Character)
    plr.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(item)
            if item.Name == "Observe" then
                    playSound("KikiHubAssets/ObserveEquip.mp3")

                notify("Illusionist Equipped Observe! " .. getInGameName(plr), Color3.fromRGB(0, 200, 255), 10)
            end
        end)
    end)

    -- Also check current character immediately (if loaded)
    if plr.Character then
        for _, item in ipairs(plr.Character:GetChildren()) do
            if item.Name == "Observe" then
                notify("Illusionist Equipped Observe! " .. getInGameName(plr), Color3.fromRGB(0, 200, 255), 10)
            end
        end
    end
end

-- Handle existing players
for _, plr in pairs(game.Players:GetPlayers()) do
    handlePlayer(plr)
end

-- Handle new players
game.Players.PlayerAdded:Connect(handlePlayer)


   local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local chatGui

local function createLogger()
    if chatGui then return end
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    chatGui = Instance.new("ScreenGui")
    chatGui.Name = "ChatLog"
    chatGui.Parent = playerGui
    chatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    chatGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.fromOffset(400, 220)
    frame.Position = UDim2.fromScale(0.5, 0.5) - UDim2.fromOffset(200, 110)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = chatGui
    frame.Draggable = true
    frame.Active = true

    local scrolling = Instance.new("ScrollingFrame")
    scrolling.Size = UDim2.new(1, 0, 1, 0)
    scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrolling.ScrollBarThickness = 6
    scrolling.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    scrolling.BorderSizePixel = 0
    scrolling.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = scrolling

    local function addMsg(name, text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -6, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.SourceSans
        label.TextSize = 18
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextWrapped = true
        label.AutomaticSize = Enum.AutomaticSize.Y
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Text = "(" .. name .. "): " .. text
        label.Parent = scrolling
    end

    TextChatService.MessageReceived:Connect(function(msg)
        if msg.TextSource then
            local p = Players:GetPlayerByUserId(msg.TextSource.UserId)
            if p then
                addMsg(p.Name, msg.Text)
            end
        end
    end)
end

local function removeLogger()
    if chatGui then
        chatGui:Destroy()
        chatGui = nil
    end
end

local toggle = Tabs.GeneralTab:AddToggle("showLogger", {
    Title = "Show Chat Logger",
    Default = false
})

toggle:OnChanged(function(enabled)
    if enabled then
        createLogger()
    else
        removeLogger()
    end
end)


            
            local mt = getrawmetatable(game)
            local nofailbard = false
            setreadonly(mt, false)
            
            local namecall = mt.__namecall
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
            
                if method == "FireServer" and tostring(self) == "BardError" and nofailbard == true then
                   return
                end
                return namecall(self, table.unpack(args))
            end)

local NoFailBardTog = Tabs.GeneralTab:AddToggle("NoFailBard", { Title = "No Fail Bard", Default = false })

    NoFailBardTog:OnChanged(function()
        nofailbard = Options.NoFailBard.Value
    end)

    local AutoBard = false
    local AutoBardTog = Tabs.GeneralTab:AddToggle("AutoBard", { Title = "Auto Bard", Default = false })
    local ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BardGui")
    if ui then
    ui.ChildAdded:Connect(function(v)
        if v.Name == "Button" and AutoBard == true then
            task.wait(0.90)
        firesignal(v.MouseButton1Click)
    
        end
    end)
    else 
        spawn(function()
        pcall(function()
            local ui = game.Players.LocalPlayer.PlayerGui:WaitForChild("BardGui")
            ui.ChildAdded:Connect(function(v)
                if v.Name == "Button" and AutoBard == true then
                    task.wait(0.90)
                firesignal(v.MouseButton1Click)
            
                end
            end)
        end)
        end)
    end 
    AutoBardTog:OnChanged(function()
    AutoBard = Options.AutoBard.Value
    
    end)
    game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(ui)
        if ui.Name == "BardGui" then 
            ui.ChildAdded:Connect(function(v)
                if v.Name == "Button" and AutoBard == true then
                    task.wait(0.90)
                firesignal(v.MouseButton1Click)
            
                end
            end)
        end
    end)

local HideBardGuiTog = Tabs.GeneralTab:AddToggle("HideBardGui", { Title = "Hide Bard Gui", Default = false })

HideBardGuiTog:OnChanged(function()
    if Options.HideBardGui.Value == true then
        game.Players.LocalPlayer.PlayerGui.BardGui.Enabled = false
    else
        game.Players.LocalPlayer.PlayerGui.BardGui.Enabled = true
    end
end)
--]]
Tabs.GeneralTab:AddButton({
    Title = "Instant Log",
    Description = "Instantly leaves the game.",
    Callback = function()
        game.Players.LocalPlayer:Kick("Instant Logged")
    end
})
local InstantLogKeybind = Tabs.GeneralTab:AddKeybind("InstantLog", {
    Title = "Instant Log (Keybind)",
    Mode = "Toggle", 
    Default = "PageUp", 

    Callback = function(Value)
    game.Players.LocalPlayer:Kick("Instant Logged (Keybind)")
    end,
})
Tabs.GeneralTab:AddButton({
    Title = "Reset",
    Description = "Resets your character",
    Callback = function()
        Window:Dialog({
            Title = "Reset Confirmation",
            Content = "Are you sure that you want to reset?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        game.Players.LocalPlayer.Character.Humanoid.Health = 0
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        
                    end
                }
            }
        })
    end
})

local fakeCharActive = false
local fakeCharConn = nil
local fakeCharTrack = nil  -- store animation track so we can stop it
local upthingy = function()
    pcall(function()
        local newanim = Instance.new("Animation")
        newanim.AnimationId = "rbxassetid://2986649587"
        local a = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(newanim)
        a.Priority = Enum.AnimationPriority.Action4
        a:Play()
        task.wait(1.75)
        a:AdjustSpeed(0)
        fakeCharActive = true
        fakeCharTrack = a

        if fakeCharConn then fakeCharConn:Disconnect() end
        fakeCharConn = game.RunService.RenderStepped:Connect(function()
        
        if game.Players.LocalPlayer.Character and fakeCharActive == true and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        if not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then 
        local hlight = Instance.new("Highlight")
        hlight.Parent = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        hlight.Adornee = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        hlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        
        hlight.Enabled = true
        hlight.Enabled = false
        hlight.Enabled = true
        game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
        end
        for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do 
        if v:IsA("BasePart") then 
        v.CanCollide = false
        end
        end
        end
        end)
        end)
    end
    local sidethingy = function()
        pcall(function()
            local newanim = Instance.new("Animation")
            newanim.AnimationId = "rbxassetid://2981752529"
            local a = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(newanim)
            a.Priority = Enum.AnimationPriority.Action4
            a:Play()
            fakeCharActive = true
            fakeCharTrack = a

            if fakeCharConn then fakeCharConn:Disconnect() end
            fakeCharConn = game.RunService.RenderStepped:Connect(function()
            
            if game.Players.LocalPlayer.Character and fakeCharActive == true and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
            if not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then 
            local hlight = Instance.new("Highlight")
            hlight.Parent = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            hlight.Adornee = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            hlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            
            hlight.Enabled = true
            hlight.Enabled = false
            hlight.Enabled = true
            game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0
            end
            for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do 
            if v:IsA("BasePart") then 
            v.CanCollide = false
            end
            end
            end
            end)
            end)
    end

local DropdownFake = Tabs.RageTab:AddDropdown("Dropdown", {
    Title = "Fake Character Offset",
    Values = {"Default", "UP (Scroom GodMode)", "Side (HitBox Moved/Invisible)"},
    Multi = false
})
DropdownFake:SetValue(nil)
Tabs.RageTab:AddButton({
    Title = "Disable Fake Character Offset",
    Description = "Disables the animation and highlight without resetting",
    Callback = function()
        fakeCharActive = false
        if fakeCharConn then fakeCharConn:Disconnect() fakeCharConn = nil end
        
        -- Stop the saved animation track directly
        if fakeCharTrack then
            pcall(function() fakeCharTrack:Stop(0) end)
            fakeCharTrack = nil
        end
        
        local char = game.Players.LocalPlayer.Character
        if not char then return end
        
        -- Remove Highlight from HRP
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, h in pairs(hrp:GetChildren()) do
                if h:IsA("Highlight") then h:Destroy() end
            end
            hrp.Transparency = 1
        end
    end
})
DropdownFake:OnChanged(function(Value)
if Value == "UP (Scroom GodMode)" then
    upthingy()
elseif Value == "Side (HitBox Moved/Invisible)" then
    sidethingy()
end
end)
local SpaceValue = 0
local BackAttachSlider = Tabs.RageTab:AddSlider("BackAttachSpaceSlider", {
    Title = "Back Attach Space",
    Description = "How far/close you attach to the back.",
    Default = 2,
    Min = -10,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        SpaceValue = Value
    end
})
local Attached = false 
            
            Tabs.RageTab:AddButton({
                Title = "Attach To Back (Press X)",
                Description = "Attaches to players back (Point with your mouse cursor)",
                Callback = function()
                pcall(function()
               local UIS = game:GetService("UserInputService")
               local Player = game:GetService("Players").LocalPlayer
               local Mouse = Player:GetMouse()
               local t2
               
               UIS.InputBegan:Connect(function(i, t)
                   if i.KeyCode == Enum.KeyCode.X and not t then
                       local target = Mouse.Target
                       if target ~= nil and target.Parent:FindFirstChild("Humanoid") and not t then
                           t2 = true
                           if (Player.Character.Head.Position - target.Parent.Head.Position).Magnitude < 100  and t2 then
                               while task.wait() do
                                   Player.Character.HumanoidRootPart.CFrame = target.Parent.HumanoidRootPart.CFrame * CFrame.new(0,0,SpaceValue)
                                   if t2 == false then
                                       break
                                   end
                               end
                           end
                       else
                           t2 = false
                           target = nil
                       end
                   end
               end)
            end)
            end
            })
          
            local NoStun = false
local NoStunToggle = Tabs.RageTab:AddToggle("NoStunOpt", { Title = "No-Stun", Default = false })

local unwantedNames = {
    Stun = true,
    NoJump = true,
    Action = true,
    HeavyAttack = true,
    LightAttack = true,
    Casting = true,
    ClimbCoolDown = true
}

local noStunConn = nil
local noStunCharConn = nil

local function hookNoStunCharacter(character)
    if noStunConn then noStunConn:Disconnect() end
    noStunConn = character.ChildAdded:Connect(function(child)
        if NoStun and unwantedNames[child.Name] then
            task.wait()
            child:Destroy()
        end
    end)
end

NoStunToggle:OnChanged(function()
    NoStun = Options.NoStunOpt.Value

    if NoStun then
        if game.Players.LocalPlayer.Character then
            hookNoStunCharacter(game.Players.LocalPlayer.Character)
        end
        if not noStunCharConn then
            noStunCharConn = game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
                if NoStun then
                    hookNoStunCharacter(character)
                end
            end)
        end
    else
        if noStunConn then
            noStunConn:Disconnect()
            noStunConn = nil
        end
        if noStunCharConn then
            noStunCharConn:Disconnect()
            noStunCharConn = nil
        end
    end
end)



local flySpeed = 50
local fallSpeed = 25
local flyEnabled = false
local FlySpeedSlider = Tabs.PlayerTab:AddSlider("FlySpeed", {
    Title = "Fly Speed",
    Description = "How fast you fly",
    Default = 50,
    Min = 10,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        flySpeed = Value
    end
})

local FlySpeedSlider = Tabs.PlayerTab:AddSlider("FallSpeed", {
    Title = "Fall Speed",
    Description = "How fast you fall down",
    Default = 25,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        fallSpeed = Value
    end
})

local FlyToggle = Tabs.PlayerTab:AddToggle("FlyOpt", { Title = "Fly", Default = false })
FlyToggle:OnChanged(function()
flyEnabled = Options.FlyOpt.Value
end)
local FlyKeybind = Tabs.PlayerTab:AddKeybind("Fly", {
    Title = "Fly (Keybind)",
    Mode = "Toggle", 
    Default = "F2", 

    Callback = function(Value)
    flyEnabled = not flyEnabled
    Options.FlyOpt:SetValue(flyEnabled)
    end,
})


game:GetService("RunService").RenderStepped:Connect(function()
    local char = game:GetService("Players").LocalPlayer.Character
    local velocity = Vector3.new()
    if flyEnabled then
        local lookVector = (game:GetService("Workspace").CurrentCamera.Focus.p - game:GetService("Workspace").CurrentCamera.CFrame.p).Unit
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + Vector3.new(0, flySpeed, 0)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            velocity = velocity + lookVector * flySpeed
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            velocity = velocity - lookVector * flySpeed
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            velocity = velocity - Vector3.new(-lookVector.Z, 0, lookVector.X) * flySpeed
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            velocity = velocity + Vector3.new(-lookVector.Z, 0, lookVector.X) * flySpeed
        end
    velocity = velocity - Vector3.new(0, fallSpeed, 0)
    if char and char:FindFirstChild("HumanoidRootPart") ~= nil then
    char.HumanoidRootPart.Velocity = velocity
        end
    end
end)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Player
local LocalPlayer = Players.LocalPlayer

-- Noclip Settings
local noclipEnabled = false
local moveSpeed = 150
local savedJumpPower = nil

-- ANTI-RUBBERBAND: Destroy ClipBack values from server
-- The server creates ClipBack (Vector3Value) in Live folder to teleport you back
-- Destroying it before CharacterHandler reads it prevents the rubber-band
local _liveChar = nil

local function killAllClipBacks()
    if not _liveChar or not _liveChar.Parent then return end
    for _, child in pairs(_liveChar:GetChildren()) do
        if child.Name == "ClipBack" then
            pcall(function() child:Destroy() end)
        end
    end
end

local function hookLiveFolder()
    local live = workspace:FindFirstChild("Live")
    if not live then return end
    _liveChar = live:FindFirstChild(LocalPlayer.Name)
    if not _liveChar then return end

    killAllClipBacks()

    _liveChar.ChildAdded:Connect(function(child)
        if child.Name == "ClipBack" and noclipEnabled then
            pcall(function() child:Destroy() end)
        end
    end)
end

task.spawn(hookLiveFolder)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    hookLiveFolder()
end)

-- Per-frame cleanup
RunService.Stepped:Connect(function()
    if noclipEnabled and _liveChar and _liveChar.Parent then
        killAllClipBacks()
    end
end)

-- BodyVelocity for noclip movement (Project Rain technique)
-- Deferred creation: only created when noclip is first enabled
local _noclipBV = nil

local function getNoclipBV()
    if _noclipBV then return _noclipBV end
    _noclipBV = Instance.new("BodyVelocity")
    _noclipBV.Name = "NoclipBV"
    _noclipBV.P = 20000
    _noclipBV.MaxForce = Vector3.new(1e10, 1e10, 1e10)
    pcall(function()
        game:GetService("CollectionService"):AddTag(_noclipBV, "AllowedBM")
    end)
    return _noclipBV
end

-- Region3 smart noclip: track modified world parts
local _noclipModifiedParts = {}

local function restoreNoclipParts()
    for part, data in pairs(_noclipModifiedParts) do
        pcall(function()
            if part and part.Parent then
                part.CanCollide = data.CanCollide
                part.Transparency = data.Transparency
            end
        end)
    end
    _noclipModifiedParts = {}
end

local function doRegion3Noclip(rootPart)
    -- Scan a region around the player and disable nearby world collisions
    local pos = rootPart.Position
    local regionSize = Vector3.new(6, 6, 6)
    local region = Region3.new(pos - regionSize, pos + regionSize)
    
    local ignoreList = {LocalPlayer.Character}
    local parts = workspace:FindPartsInRegion3WithIgnoreList(region, ignoreList, 200)
    
    local currentParts = {}
    for _, part in ipairs(parts) do
        if part.CanCollide then
            currentParts[part] = true
            if not _noclipModifiedParts[part] then
                _noclipModifiedParts[part] = {
                    CanCollide = part.CanCollide,
                    Transparency = part.Transparency
                }
            end
            part.CanCollide = false
            -- Slight transparency to show passable parts
            if part.Transparency < 0.5 then
                part.Transparency = math.max(part.Transparency, 0.6)
            end
        end
    end
    
    -- Restore parts that are no longer near the player
    for part, data in pairs(_noclipModifiedParts) do
        if not currentParts[part] then
            pcall(function()
                if part and part.Parent then
                    part.CanCollide = data.CanCollide
                    part.Transparency = data.Transparency
                end
            end)
            _noclipModifiedParts[part] = nil
        end
    end
end

-- Noclip bypass + Region3 collision on Stepped (before physics)
RunService.Stepped:Connect(function()
    local character = LocalPlayer.Character
    if noclipEnabled and character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if savedJumpPower == nil then
                savedJumpPower = humanoid.JumpPower
            end
            humanoid.JumpPower = 0
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        -- Keep character parts non-collidable
        for _, v in ipairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
        -- Smart Region3 noclip for world parts
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            doRegion3Noclip(rootPart)
        end
    elseif savedJumpPower ~= nil then
        local character2 = LocalPlayer.Character
        if character2 then
            local humanoid = character2:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = savedJumpPower
            end
        end
        savedJumpPower = nil
        restoreNoclipParts()
    end
end)

-- BodyVelocity noclip movement on RenderStepped
RunService.RenderStepped:Connect(function(dt)
    local char = LocalPlayer.Character
    if noclipEnabled and char then
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if rootPart then
            local bv = getNoclipBV()
            -- Attach BodyVelocity if not already
            if bv.Parent ~= rootPart then
                bv.Parent = rootPart
            end
            
            local cam = workspace.CurrentCamera
            local lookVector = cam.CFrame.LookVector
            local rightVector = cam.CFrame.RightVector
            local moveDir = Vector3.new()

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDir = moveDir + lookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDir = moveDir - lookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDir = moveDir - rightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDir = moveDir + rightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDir = moveDir - Vector3.new(0, 1, 0)
            end

            if moveDir.Magnitude > 0 then
                bv.Velocity = moveDir.Unit * moveSpeed
            else
                bv.Velocity = Vector3.new(0, 0, 0)
            end
            
            -- Zero out any other velocities
            rootPart.Velocity = Vector3.new(0, 0, 0)
            
            -- Override any other BodyVelocities from the game
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BodyVelocity") and v ~= bv then
                    v.MaxForce = Vector3.new(1e10, 1e10, 1e10)
                    v.Velocity = bv.Velocity
                end
            end
        end
    else
        -- Remove BodyVelocity when not noclipping
        if _noclipBV and _noclipBV.Parent then
            _noclipBV.Parent = nil
        end
    end
end)

-- Death Reset
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.Died:Connect(function()
            noclipEnabled = false
            if Options and Options.Noclip then
                Options.Noclip:SetValue(false)
            end
        end)
    end
end

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- UI Integration
local playerTab = Tabs.PlayerTab

playerTab:AddToggle("Noclip", {
    Title = "Noclip",
    Default = false
}):OnChanged(function()
    noclipEnabled = Options.Noclip.Value
end)

playerTab:AddKeybind("NoclipKey", {
    Title = "Toggle Noclip",
    Mode = "Toggle",
    Default = "F3",
    Callback = function()
        noclipEnabled = not noclipEnabled
        if Options and Options.Noclip then
            Options.Noclip:SetValue(noclipEnabled)
        end
    end
})

playerTab:AddSlider("NoclipSpeed", {
    Title = "Noclip Speed",
    Default = 150,
    Min = 50,
    Max = 300,
    Rounding = 0,
	Callback = function(val)
		moveSpeed = val
	end
})

-- ============================================
-- INSTA MINE: When you click with a pickaxe,
-- rapidly cycle all pickaxes and click each one
-- ============================================
local instaMineEnabled = false
local instaMineDelay = 0.05
local instaMining = false  -- prevent re-entry

local function getUniquePickaxes()
    local pickaxes = {}
    local seenIDs = {}
    
    -- Check backpack
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Pickaxe" then
            local idVal = tool:FindFirstChild("ID")
            if idVal then
                local id = idVal.Value
                if not seenIDs[id] then
                    seenIDs[id] = true
                    table.insert(pickaxes, tool)
                end
            end
        end
    end
    
    -- Check character (currently equipped)
    local char = LocalPlayer.Character
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "Pickaxe" then
                local idVal = tool:FindFirstChild("ID")
                if idVal then
                    local id = idVal.Value
                    if not seenIDs[id] then
                        seenIDs[id] = true
                        table.insert(pickaxes, tool)
                    end
                end
            end
        end
    end
    
    return pickaxes
end

-- Hook mouse click: when you click with a pickaxe + instamine on,
-- cycle through all other pickaxes and click each
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not instaMineEnabled then return end
    if instaMining then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    
    -- Check if we have a pickaxe equipped
    local char = LocalPlayer.Character
    if not char then return end
    local currentTool = char:FindFirstChildOfClass("Tool")
    if not currentTool or currentTool.Name ~= "Pickaxe" then return end
    
    -- Get all other unique pickaxes
    local pickaxes = getUniquePickaxes()
    if #pickaxes <= 1 then return end  -- need more than 1 pickaxe
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Remember which pickaxe we started with
    local originalPickID = currentTool:FindFirstChild("ID") and currentTool.ID.Value or nil
    
    instaMining = true
    
    task.spawn(function()
        -- The user's normal click already handled the first pickaxe
        -- Now rapidly equip and click the remaining ones
        for _, pick in ipairs(pickaxes) do
            if not instaMineEnabled then break end
            
            -- Skip the one we already clicked with
            local pickID = pick:FindFirstChild("ID") and pick.ID.Value or nil
            if pickID ~= originalPickID then
                pcall(function()
                    humanoid:EquipTool(pick)
                end)
                task.wait(instaMineDelay)
                
                -- Use the tool's Activated event by simulating click
                pcall(function()
                    pick:Activate()
                end)
                task.wait(instaMineDelay)
                
                pcall(function()
                    pick:Deactivate()
                end)
            end
        end
        
        -- Re-equip original pickaxe
        for _, pick in ipairs(pickaxes) do
            local pickID = pick:FindFirstChild("ID") and pick.ID.Value or nil
            if pickID == originalPickID then
                pcall(function()
                    humanoid:EquipTool(pick)
                end)
                break
            end
        end
        
        instaMining = false
    end)
end)

-- UI
playerTab:AddToggle("InstaMine", {
    Title = "Insta Mine",
    Default = false
}):OnChanged(function()
    instaMineEnabled = Options.InstaMine.Value
end)

playerTab:AddKeybind("InstaMineKey", {
    Title = "Toggle Insta Mine",
    Mode = "Toggle",
    Default = "F4",
    Callback = function()
        instaMineEnabled = not instaMineEnabled
        if Options and Options.InstaMine then
            Options.InstaMine:SetValue(instaMineEnabled)
        end
    end
})

playerTab:AddSlider("MineSpeed", {
    Title = "Mine Delay",
    Default = 0.05,
    Min = 0.01,
    Max = 0.2,
    Rounding = 2,
    Callback = function(val)
        instaMineDelay = val
    end
})

local isMoving = false
local speed = 1

local SpeedSlider = Tabs.PlayerTab:AddSlider("SpeedSlid", {
    Title = "Speed",
    Default = 1,
    Min = 1,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        speed = Value
    end
})

local CFrameSpeedToggle = Tabs.PlayerTab:AddToggle("CFrameSpeedTog", { Title = "CFrame Speed", Default = false })
CFrameSpeedToggle:OnChanged(function()
isMoving = Options.CFrameSpeedTog.Value
end)

local CFrameSpeedKeybind = Tabs.PlayerTab:AddKeybind("CFrameSpeedKb", {
    Title = "CFrame Speed (Keybind)",
    Mode = "Toggle", 
    Default = "F4", 

    Callback = function(Value)
    isMoving = not isMoving
    Options.CFrameSpeedTog:SetValue(isMoving)
    end,
})
     
game:GetService("RunService").RenderStepped:Connect(function()
    if isMoving then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local moveDirection = character.Humanoid.MoveDirection
            local movementVector = moveDirection * (speed / 100) 
            character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + movementVector
            character.HumanoidRootPart.Velocity = Vector3.new(0, character.HumanoidRootPart.Velocity.Y, 0)
        end
    end
end)
local knockedownership = false
function equiptoolwithhandle()
    local foundtool = nil

    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Backpack then
        for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if tool:FindFirstChild("Handle") then
                foundtool = tool

                break 
            end
        end

        if foundtool then
            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            task.wait(0.1) 

            game.Players.LocalPlayer.Character.Humanoid:EquipTool(foundtool)
            task.spawn(function()

            while not foundtool:IsDescendantOf(game.Players.LocalPlayer.Character) do
                task.wait(0.1)
            end

            task.wait(0.1)
            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            

            end)
        else

        end
    end
end 
local KnockedOwnerShipToggle = Tabs.PlayerTab:AddToggle("KnockedOwerneShip", { Title = "Knocked Ownership", Default = false })
KnockedOwnerShipToggle:OnChanged(function()
knockedownership = Options.KnockedOwerneShip.Value
if knockedownership then
    task.spawn(function()
while knockedownership do
        task.wait()
        local knocked = false

        if game.Players.LocalPlayer.Character then
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part:FindFirstChild("Bone") then
                    knocked = true

                end
            end
        end

        if knocked then
            equiptoolwithhandle()
        end

        
    end
    task.wait(0.1)
end)
end
end)

local LoopGain = false
local LoopGainOrderlyTog = Tabs.PlayerTab:AddToggle("LPGO", { Title = "Loop Gain Orderly", Default = false })
LoopGainOrderlyTog:OnChanged(function()
    LoopGain = Options.LPGO.Value
    if LoopGain == true and game.Players.LocalPlayer.Backpack:FindFirstChild("Tespian Elixir") then 
        local tespfarm = true 
        task.spawn(function()
            while LoopGain do 
                
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then 
                    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    hum:UnequipTools()
                    hum:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Tespian Elixir"))

                    task.wait(0.7)

                    game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, true, game, 0)
                    task.wait(0.2)
                    game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, false, game, 0)
                    task.wait(0.7)

                    hum.Health = 0
                end
                task.wait(8)
            end
        end)
    else
        tespfarm = false
    end
end)

    getgenv().DesiredAmt = 50
    local ManaChargeAmtSlider = Tabs.PlayerTab:AddSlider("ManaChargeAmt", {
        Title = "Mana Charge Amount",
        Description = "Percentage to charge mana with Auto Mana Charge",
        Default = 50,
        Min = 1,
        Max = 100,
        Rounding = 0,
        Callback = function(Value)
            getgenv().DesiredAmt = Value
        end
    })
    local ACGMana = false
    local _manaChargeRemote = nil
    local _manaCharging = false
    local _useVIMFallback = false

    -- canUseMana: safety checks before charging (from Aztup)
    local CollectionService = game:GetService("CollectionService")
    local function canUseMana()
        local character = LocalPlayer.Character
        if not character then return false end
        if character:FindFirstChild("Grabbed") then return false end
        if character:FindFirstChild("Climbing") then return false end
        if character:FindFirstChild("ClimbCoolDown") then return false end
        if character:FindFirstChild("ManaStop") then return false end
        if character:FindFirstChild("SpellBlocking") then return false end
        if character:FindFirstChild("ActiveCast") then return false end
        if character:FindFirstChild("Stun") then return false end
        if character:FindFirstChildOfClass("ForceField") then return false end
        if CollectionService:HasTag(character, "Knocked") then return false end
        if CollectionService:HasTag(character, "Unconscious") then return false end
        return true
    end

    -- Try to resolve mana charge remote via getKey (Aztup technique)
    local function resolveManaRemote()
        local ok, result = pcall(function()
            local getKey = nil
            for i, v in next, getgc(true) do
                if typeof(v) == "table" and rawget(v, "getKey") then
                    getKey = rawget(v, "getKey")
                    break
                end
            end
            if getKey then
                local success, remote = pcall(getKey, "Charge", "apricot")
                if success and remote then
                    return remote
                end
            end
            return nil
        end)
        return ok and result or nil
    end

    -- Attempt getKey resolution
    task.spawn(function()
        task.wait(2) -- wait for game to be ready
        _manaChargeRemote = resolveManaRemote()
        if _manaChargeRemote then
            print("[Auto Mana] Resolved mana remote via getKey")
        else
            _useVIMFallback = true
            print("[Auto Mana] getKey unavailable, using VIM fallback")
        end
    end)

    local vim = game:GetService('VirtualInputManager')
    local isHoldingG = false

    local function startManaCharge()
        if _manaCharging then return end
        if not canUseMana() then return end
        _manaCharging = true

        if _manaChargeRemote then
            pcall(function()
                _manaChargeRemote.FireServer(_manaChargeRemote, true)
            end)
        else
            if not isHoldingG then
                isHoldingG = true
                vim:SendKeyEvent(true, "G", false, game)
            end
        end
    end

    local function stopManaCharge()
        if not _manaCharging then return end
        _manaCharging = false

        if _manaChargeRemote then
            pcall(function()
                _manaChargeRemote.FireServer(_manaChargeRemote, false)
            end)
        else
            if isHoldingG then
                isHoldingG = false
                vim:SendKeyEvent(false, "G", false, game)
            end
        end
    end

    task.spawn(function()
        while task.wait(0.2) do
            if ACGMana then
                local liveFolder = workspace:FindFirstChild("Live")
                if liveFolder then
                    local liveChar = liveFolder:FindFirstChild(game.Players.LocalPlayer.Name)
                    if liveChar then
                        local manaVal = liveChar:FindFirstChild("Mana")
                        if manaVal and manaVal:IsA("NumberValue") then
                            if manaVal.Value < getgenv().DesiredAmt and canUseMana() then
                                startManaCharge()
                            else
                                stopManaCharge()
                            end
                        end
                    end
                end
            else
                stopManaCharge()
            end
        end
    end)
local ACGToggle = Tabs.PlayerTab:AddToggle("ACG", { Title = "Auto Charge Mana", Default = false })
ACGToggle:OnChanged(function()
    ACGMana = Options.ACG.Value
    if not ACGMana then
        stopManaCharge()
    end
end)

local showMana = false
local showManaToggle = Tabs.MiscTab:AddToggle("ShowManaPercentage", { Title = "Show Mana Percentage", Default = false })

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ManaGui"
screenGui.Enabled = false
screenGui.Parent = game:GetService("CoreGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 150, 0, 30)
textLabel.Position = UDim2.new(0.000100001911, -30, 0.439999968, 10)
textLabel.Text = "0%"
textLabel.FontSize = Enum.FontSize.Size18
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(128, 0, 128)
textLabel.Parent = screenGui

showManaToggle:OnChanged(function()
    showMana = Options.ShowManaPercentage.Value
    if showMana then
        screenGui.Enabled = true
        while showMana do
            local player = game.Players.LocalPlayer
            if player and player.Character then
                local manaValue = player.Character:FindFirstChild("Mana")
                if manaValue then
                    textLabel.Text = math.floor(manaValue.Value) .. "%"
                else
                    textLabel.Text = "N/A"
                end
            else
                textLabel.Text = "N/A"
            end
            task.wait()
        end
    else
        screenGui.Enabled = false
        textLabel.Text = "N/A"
    end
end)


Tabs.MiscTab:AddButton({
    Title = "Remove Orderly Barriers",
    Description = "Removes orderly barriers so you can go through them when you're chaotic.",
    Callback = function()
        for i, v in pairs(game.workspace:GetDescendants()) do
            if v.Name == "OrderField" then
                v:Destroy()
            end
        end
    end
})

                
-- ============= TRINKET & ESP TAB =============
local TrinketEsp = false
local TrinketEspColor = Color3.new(1, 1, 1)
local ArtifactEspColor = Color3.new(1, 1, 1)

local Meshes = {
    ["rbxassetid://5196776695"] = "Ring",
    ["rbxassetid://5204003946"] = "Goblet",
    ["rbxassetid://5196782997"] = "Old Ring",
    ["rbxassetid://5204453430"] = "Scroll",
    ["rbxassetid://5196551436"] = "Amulet",
    ["rbxassetid://5196577540"] = "Old Amulet",
    ["rbxassetid://4103271893"] = "Candy",
    ["rbxassetid://4027112893"] = "Bound Book"
}

-- Tracked ESP objects: { obj, label, bottom, isArtifact }
local trackedESP = {}

local function WTS(pos)
    local cam = workspace.CurrentCamera
    local screenPos, visible = cam:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), visible, screenPos.Z
end
	
local function GetLabelName(obj)
    local p = obj.Parent

    -- LOST SUNSHINE (Simple color check)
    if p and p:IsA("Part") then
        if p.Color == Color3.fromRGB(248, 195, 62) then
            return "Lost Sunshine", false
        end
    end

    -- Original ESP detection logic
    local color = p.Color
    local mesh = p:FindFirstChildWhichIsA("SpecialMesh")
    local attachment = p:FindFirstChild("Attachment")
    local particle = p:FindFirstChildWhichIsA("ParticleEmitter", true)

    if p:IsA("Part") then
        if p:FindFirstChild("OrbParticle") and color == Color3.fromRGB(89, 34, 89) then return "???", false end
        if color == Color3.fromRGB(128, 187, 219) then return "Fairfrozen", true end
        if color == Color3.fromRGB(164, 187, 190) then return "Diamond", false end
        if color == Color3.fromRGB(0, 184, 49) then return "Emerald", false end
        if color == Color3.fromRGB(16, 42, 220) then return "Sapphire", false end
        if color == Color3.fromRGB(255, 0, 0) then return "Ruby", false end
        if p:FindFirstChild("OrbParticle") and p.OrbParticle.Texture == "rbxassetid://20443483" then return "Ice Essence", true end
        if particle and particle.Color.Keypoints[1].Value == Color3.new(1, 0.8, 0) then return "Phoenix Down", true end
        if attachment and attachment:FindFirstChild("ParticleEmitter") then
            local pe = attachment.ParticleEmitter
            if pe.Texture == "rbxassetid://1536547385" then
                if game.PlaceId == 3541987450 then return "Phoenix Flower", true end
                if pe.Color.Keypoints[1].Value == Color3.new(0, 1, 0.207843) then return "Azael Horn", true end
                return "Mysterious Artifact", true
            end
        end
        if p.Material == Enum.Material.Glass and color == Color3.fromRGB(248, 248, 248) and mesh then return "Opal", false end
        return "Unregistered Artifact", true
    elseif p:IsA("UnionOperation") then
        if color == Color3.fromRGB(248, 248, 248) and not p.UsePartColor then return "Lannis Amulet", true end
        if color == Color3.fromRGB(29, 46, 58) then return "Night Stone", true end
        if color == Color3.fromRGB(163, 162, 165) then return "Amulet Of The White King", true end
        if color == Color3.fromRGB(111, 113, 125) then return "Idol Of Forgotten", false end
    elseif p:IsA("MeshPart") then
        -- Marshmallow detection
        if p.MeshId == "rbxassetid://122777605672182" and p.BrickColor == BrickColor.new(Color3.fromRGB(237, 234, 234)) then
            return "Marshmallow", false
        end

        if Meshes[p.MeshId] then
            return Meshes[p.MeshId], false
        end
    end

    if mesh and Meshes[mesh.MeshId] then
        return Meshes[mesh.MeshId], false
    end

    return nil
end


local function CreateESP(obj)
    -- Prevent duplicates
    for _, entry in ipairs(trackedESP) do
        if entry.obj == obj then return end
    end

    local labelName, isArtifact = GetLabelName(obj)
    if not labelName then return end

    local label = Drawing.new("Text")
    label.Text = labelName
    label.Color = isArtifact and ArtifactEspColor or TrinketEspColor
    label.Size = 15
    label.Outline, label.Center, label.Font = true, true, 0

    local bottom = Drawing.new("Text")
    bottom.Size = 12
    bottom.Outline, bottom.Center, bottom.Font = true, true, 0
    bottom.Color = Color3.fromRGB(50, 50, 50)

    table.insert(trackedESP, {
        obj = obj,
        label = label,
        bottom = bottom,
        isArtifact = isArtifact
    })
end

-- Single render loop for ALL tracked ESP objects
local espRenderConn = nil
local espChildAddedConn = nil

local function startESPRenderLoop()
    if espRenderConn then return end
    espRenderConn = game:GetService("RunService").RenderStepped:Connect(function()
        if not getgenv().ESPTOGGLE1 then
            for _, entry in ipairs(trackedESP) do
                entry.label.Visible = false
                entry.bottom.Visible = false
            end
            return
        end

        local i = 1
        while i <= #trackedESP do
            local entry = trackedESP[i]
            if not entry.obj:IsDescendantOf(workspace) then
                -- Clean up removed objects
                entry.label:Remove()
                entry.bottom:Remove()
                table.remove(trackedESP, i)
            else
                -- Update color
                entry.label.Color = entry.isArtifact and ArtifactEspColor or TrinketEspColor
                -- Update position
                local pos, visible, dist = WTS(entry.obj.Position)
                if visible then
                    entry.label.Position = pos
                    entry.label.Visible = true
                    entry.bottom.Position = pos + Vector2.new(0, 15)
                    entry.bottom.Text = string.format("Distance: [%d]", dist)
                    entry.bottom.Visible = true
                else
                    entry.label.Visible = false
                    entry.bottom.Visible = false
                end
                i = i + 1
            end
        end
    end)
end

local function EnableESP()
    for _, conn in ipairs(getconnections(game:GetService("ScriptContext").Error)) do conn:Disable() end
    getgenv().ESPTOGGLE1 = true

    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BasePart") then
            for _, desc in pairs(v:GetDescendants()) do
                if desc:IsA("ClickDetector") then
                    CreateESP(desc.Parent)
                end
            end
        end
    end

    if not espChildAddedConn then
        espChildAddedConn = workspace.ChildAdded:Connect(function(v)
            if v:IsA("BasePart") then
                for _, desc in pairs(v:GetDescendants()) do
                    if desc:IsA("ClickDetector") then
                        CreateESP(desc.Parent)
                    end
                end
            end
        end)
    end

    startESPRenderLoop()
end

local function DisableESP()
    getgenv().ESPTOGGLE1 = false
end

local TrinketEspToggle = Tabs.EspTab:AddToggle("TEsp", { Title = "Trinket Esp", Default = false })
TrinketEspToggle:OnChanged(function()
    TrinketEsp = Options.TEsp.Value
    if TrinketEsp then EnableESP() else DisableESP() end
end)

Tabs.EspTab:AddColorpicker("TESPColorpicker", {
    Title = "Trinket Esp Color", Default = Color3.new(1, 1, 1)
}):OnChanged(function(color) TrinketEspColor = color end)

Tabs.EspTab:AddColorpicker("AESPColorpicker", {
    Title = "Artifact Esp Color", Default = Color3.new(1, 1, 1)
}):OnChanged(function(color) ArtifactEspColor = color end)


                    local AutoBagPickUp = false
local AutoBagPickUpToggle = Tabs.EspTab:AddToggle("ABGPickUp", { Title = "Auto Bag Pick Up", Default = false })
AutoBagPickUpToggle:OnChanged(function()
AutoBagPickUp = Options.ABGPickUp.Value
if AutoBagPickUp then
    task.spawn(function()
        local player = game.Players.LocalPlayer
        local humanoidRootPart = player.Character.HumanoidRootPart
        local offset = Vector3.new(0, -1, 0) 
        local maxDistance = 20

        while AutoBagPickUp do
            task.wait(0.1)

            for _, bag in ipairs(workspace.Thrown:GetChildren()) do
                if (bag.Name == "ToolBag" or bag.Name == "MoneyBag") and (humanoidRootPart.Position - bag.Position).Magnitude <= maxDistance then
                    bag.Position = humanoidRootPart.Position + offset
                end
            end
        end
    end)
end
end)
local AutoPickup = false
task.spawn(function()
    while task.wait(0.1) do 
    if AutoPickup then 
        local success, error = pcall(function()
            for i, v in pairs(wrksp:GetChildren()) do
                if AutoPickup and (v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part")) then
                    for i2, v2 in pairs(v:GetDescendants()) do
                        if v2:IsA("ClickDetector") and v2.MaxActivationDistance == 10 then
    
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 10 then
                                fireclickdetector(v2)
                            end
                        end
                    end
                end
            end
        end)
    end
    end
    end)
    
local AutoTrinketPickUp = Tabs.EspTab:AddToggle("AutoTrinketPUP", { Title = "Auto Trinket Pick Up", Default = false })
AutoTrinketPickUp:OnChanged(function()
AutoPickup = Options.AutoTrinketPUP.Value
end)
pcall(function()
    local ingfolder = nil
    local autoingpickup = false
local AutoIngredientPickUpToggle = Tabs.EspTab:AddToggle("AutoIngPickUp", { Title = "Auto Ingredient Pick Up", Default = false })
AutoIngredientPickUpToggle:OnChanged(function()
autoingpickup = Options.AutoIngPickUp.Value
for i, v in pairs(game.Workspace:GetChildren()) do 
    if v:IsA("UnionOperation") and v:FindFirstChild("ClickDetector") then
    ingfolder = v 
    end
    end
    
    task.spawn(function()
    pcall(function()
    while task.wait(0.5) do 
    if ingfolder then
        for i, v in pairs(ingfolder:GetChildren()) do 
        if autoingpickup == true and v:IsA("UnionOperation") and v:FindFirstChild("ClickDetector") and v:FindFirstChild("ClickDetector").MaxActivationDistance == 10 and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and  (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).Magnitude < 10 then 
        fireclickdetector(v.ClickDetector)
        end
        end
    end
    end
    end)
    end)
end)
end)

local Lighting = game:GetService("Lighting")
local FullbrightNoFogVar = false

-- Store original lighting settings
local NormalLightingSettings = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient
}

-- Function to apply fullbright or normal settings
local function applyLightingSettings(fullbright)
    if fullbright then
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 786543
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
    else
        for prop, value in pairs(NormalLightingSettings) do
            Lighting[prop] = value
        end
    end
end

-- Toggle handler
local FullBrightToggle = Tabs.PlayerTab:AddToggle("FullbrightNoFog", { Title = "FullBright/NoFog", Default = false })
FullBrightToggle:OnChanged(function()
    FullbrightNoFogVar = Options.FullbrightNoFog.Value
    applyLightingSettings(FullbrightNoFogVar)
end)

-- Monitor for external lighting changes only once
Lighting.Changed:Connect(function()
    if FullbrightNoFogVar then
        applyLightingSettings(true)
    end
end)

local nofall = false
local Player = Players.LocalPlayer
local Character = Player.Character

local hook = hookfunction or detour_function

local old
old = hook(Instance.new("RemoteEvent").FireServer, function(self,...)
    local args = {...}
    
    if nofall == true and Player.Character ~= nil and Player.Character:FindFirstChild("CharacterHandler") and Player.Character.CharacterHandler:FindFirstChild("Remotes") and self.Parent == Player.Character.CharacterHandler.Remotes then
        if #args == 2 and typeof(args[2]) == "table" then
            return nil
        end
    end

    return old(self,...)
end)

local NoFallToggle = Tabs.PlayerTab:AddToggle("NoFallOPT", { Title = "No-Fall", Default = false })
NoFallToggle:OnChanged(function()
nofall = Options.NoFallOPT.Value
end)


local AntiMentalInjuries = false
local mentalConn = nil
local mentalCharConn = nil
local mental_injuries = {
Hallucinations = true,
PsychoInjury = true,
AttackExcept = true,
Whispering = true,
Quivering = true,
NoControl = true,
Careless = true,
Maniacal = true,
Fearful = true
}

local function hookMentalCharacter(character)
    if mentalConn then mentalConn:Disconnect() end
    mentalConn = character.ChildAdded:Connect(function(child)
        if mental_injuries[child.Name] then
            child:Destroy()
        end
    end)
    for _, child in ipairs(character:GetChildren()) do
        if mental_injuries[child.Name] then
            child:Destroy()
        end
    end
end

local AntiMentalInjuriesToggle = Tabs.PlayerTab:AddToggle("AMI", { Title = "Anti Mental Injuries", Default = false })
AntiMentalInjuriesToggle:OnChanged(function()
AntiMentalInjuries = Options.AMI.Value
if mentalConn then mentalConn:Disconnect() mentalConn = nil end
if mentalCharConn then mentalCharConn:Disconnect() mentalCharConn = nil end
if AntiMentalInjuries then
    if game.Players.LocalPlayer.Character then
        hookMentalCharacter(game.Players.LocalPlayer.Character)
    end
    mentalCharConn = game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
        hookMentalCharacter(character)
    end)
end
end)


local CollectionService = game:GetService("CollectionService")

local KBSEnabled = false

-- Excluded part names stored in a set for fast lookup
local excludedNames = {
    OrderField = true,
    SolanBall = true,
    SolansGate = true,
    TeleportOut = true,
    BaalField = true,
    Elevator = true,
    MageField = true,
    TeleportIn = true
}

-- Helper function to identify valid killbrick parts
local function isKillbrickCandidate(part)
    return part:IsA("BasePart") and part:FindFirstChild("TouchInterest") and not excludedNames[part.Name]
end

local KBSToggle = Tabs.PlayerTab:AddToggle("KBS", { Title = "No Killbricks", Default = false })

KBSToggle:OnChanged(function()
    KBSEnabled = Options.KBS.Value

    local kbs = {}

    -- Collect all valid killbrick parts
    for _, v in ipairs(game.Workspace:GetDescendants()) do
        if isKillbrickCandidate(v) then
            table.insert(kbs, v)
        end
    end

    -- Toggle their CanTouch property
    for _, v in ipairs(kbs) do
        v.CanTouch = not KBSEnabled
    end
end)




local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/deeropa/a/refs/heads/main/esp.lua'))()
Sense.teamSettings.enemy.enabled = false
Sense.teamSettings.enemy.box = true
Sense.teamSettings.enemy.healthBar = true
Sense.teamSettings.enemy.distance = true
Sense.teamSettings.enemy.name = true
Sense.teamSettings.enemy.weapon = true
Sense.teamSettings.enemy.boxColor[1] = Color3.new(0, 0.25, 0.75)
Sense.Load()

local PlayerEspTog = Tabs.EspTab:AddToggle("PlayerEsp", { Title = "Player Esp", Default = false })
PlayerEspTog:OnChanged(function()
Sense.teamSettings.enemy.enabled = Options.PlayerEsp.Value
end)

local TracersTog = Tabs.EspTab:AddToggle("Tracers", { Title = "Tracers", Default = false })
TracersTog:OnChanged(function()
Sense.teamSettings.enemy.tracer = Options.Tracers.Value
end)

local ArrowsTog = Tabs.EspTab:AddToggle("Arrow", { Title = "Arrows", Default = false })
ArrowsTog:OnChanged(function()
Sense.teamSettings.enemy.offScreenArrow = Options.Arrow.Value
end)

local ChamsTog = Tabs.EspTab:AddToggle("Chams", { Title = "Chams", Default = false })
ChamsTog:OnChanged(function()
Sense.teamSettings.enemy.chams = Options.Chams.Value
end)


local crock = workspace.MonsterSpawns.Triggers.CastleRockSnake:FindFirstChild("LastSpawned")
local dsunken = workspace.MonsterSpawns.Triggers.evileye1:FindFirstChild("LastSpawned")
local tundra2 = workspace.MonsterSpawns.Triggers.MazeSnakes:FindFirstChild("LastSpawned")
Tabs.EspTab:AddButton({
    Title = "Show Loot Times",
    Description = "Shows you the last time that Castle Rock, Sunken, Tundra 2 was looted.",
    Callback = function()
        Fluent:Notify({
            Title = "Last Looted:",
            Content = "Castle Rock: ".. tostring(math.floor((os.time() - crock.Value) / 60)).. " Minutes Ago" .. "\nSunken: " .. tostring(math.floor((os.time() - dsunken.Value) / 60)).. " Minutes Ago".. "\nTundra 2: " .. tostring(math.floor((os.time() - tundra2.Value) / 60)).. " Minutes Ago",
            Duration = 8
        })
    end
})





local function simpleServerHop()
    local gui = Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not gui then return end

    -- Return to menu first
    ReturnToMenu()

    -- Wait for StartMenu and PublicServers to load
    repeat task.wait() until gui:FindFirstChild("StartMenu") and gui.StartMenu:FindFirstChild("PublicServers")
    
    local publicServers = gui.StartMenu.PublicServers
    publicServers.Visible = true

    local scrollFrame = publicServers:FindFirstChild("ScrollingFrame")
    if not scrollFrame then return end

    -- Find the first server with a Join button and fire it
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChild("Join") then
            local joinButton = child:FindFirstChild("Join")
            if joinButton then
                for _, conn in ipairs(getconnections(joinButton.MouseButton1Click)) do
                    conn:Fire()
                end
                break
            end
        end
    end
end

Tabs.PlayerTab:AddButton({
    Title = "Server Hop",
    Description = "Return to menu and join the first available server",
    Callback = simpleServerHop
})




-- Button to copy current JobId to clipboard
Tabs.MiscTab:AddButton({
    Title = "Copy JobId",
    Description = "Copies the entered JobId to your clipboard",
    Callback = function()
       setclipboard(game.JobId)
        Fluent:Notify({
        Title = "JobId Copied",
        Content = "You got your jobid bruh",
        SubContent = "SubContent", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
    end
})

-- Store JobId from input
local JobId = ""

-- Input Field
Tabs.MiscTab:AddInput("JobId", {
    Title = "JobId Picker",
    Default = "",
    Placeholder = "Enter JobId here...",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        JobId = Value
    end
})


 


-- Button to FireServer with JobId
Tabs.MiscTab:AddButton({
    Title = "Teleport to JobId",
    Description = "Fires the teleport with your provided JobId",
    Callback = function()
        if JobId and JobId ~= "" then
            game:GetService("ReplicatedStorage")
                :WaitForChild("Requests")
                :WaitForChild("JoinPublicServer")
                :FireServer(JobId)
        else
            Fluent:Notify({
                Title = "Error",
                Content = "Please enter a JobId first.",
                SubTitle = "Missing Input",
                Duration = 3
            })
        end
    end
})


-- Inventory Silver Value Calculator
Tabs.MiscTab:AddButton({
    Title = "Calculate Inventory Value",
    Description = "Calculates total silver value of all items in your backpack",
    Callback = function()
        pcall(function()
            local totalSilver = 0
            local itemCount = 0
            local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
            local character = game.Players.LocalPlayer.Character

            -- Check Backpack tools
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local sv = tool:FindFirstChild("SilverValue")
                        if sv and sv:IsA("IntValue") then
                            totalSilver = totalSilver + sv.Value
                            itemCount = itemCount + 1
                        end
                    end
                end
            end

            -- Check currently equipped tools
            if character then
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") then
                        local sv = tool:FindFirstChild("SilverValue")
                        if sv and sv:IsA("IntValue") then
                            totalSilver = totalSilver + sv.Value
                            itemCount = itemCount + 1
                        end
                    end
                end
            end

            notify("Inventory Value: " .. totalSilver .. " Silver (" .. itemCount .. " items)", Color3.fromRGB(192, 192, 192), 8)
        end)
    end
})

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the Fluent over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)


end
-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

        

end, function(err)
    print("[KIKI Hub Error] " .. tostring(err))
    return err
end)
if not _scriptOk then
    print("[KIKI Hub] Script encountered an error - check above for details.")
end
