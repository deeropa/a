        pcall(function()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local TweenSpeed = 200


local tween_s = game:GetService("TweenService")
local lp = game.Players.LocalPlayer
local wrksp = game.Workspace
local farm = false
local a = {}
function tween(v)
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local mag = (lp.Character.HumanoidRootPart.Position - v).Magnitude
        local cf = CFrame.new(v)
        local tweenDuration = mag / TweenSpeed
        local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Linear)
        local tweenObject = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
        local Humanoid = lp.Character.Humanoid
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        tweenObject:Play()

        local tweening = true 
        spawn(function()
        while tweening == true do
        if lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character:FindFirstChild("HumanoidRootPart") then 
            Humanoid:ChangeState(3)
        end
        wait(.2)
        end
game:GetService("RunService").RenderStepped:Connect(function()
        if lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character:FindFirstChild("HumanoidRootPart") and tweening == true then 
                lp.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 2, 0)
            end
            end)
    end)
        tweenObject.Completed:Wait()
        tweening = false
        

        wait(1)
        local success, error = pcall(function()
            for i, v in pairs(wrksp:GetChildren()) do
                if v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then
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

function ReturnToMenu()
        game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("ReturnToMenu"):InvokeServer()
end

function ChangeServer()
    --if true then return end
    while wait(5) do
        local servers = game.Players.LocalPlayer.PlayerGui.StartMenu.PublicServers.ScrollingFrame:GetChildren()
        local tbl = servers
        assert(type(tbl) == "table", "First argument must be a table")
        local rng = Random.new()
        for i = #tbl, 2, -1 do
            local j = rng:NextInteger(1, i)
            tbl[i], tbl[j] = tbl[j], tbl[i]
        end
        
        
        --player:Kick()
        
        for i,k in pairs(servers) do
            if k:IsA("Frame") then
                

                --local name = k.Name
    
                    local button = k.Join --path to button here
                    
                    
                    
                    local events = {"MouseButton1Click"}
                    for i,v in pairs(events) do
                        for i,v in pairs(getconnections(button[v])) do
                            v:Fire()
                        end
                    end
                    wait(3)
            
        end
    end
end
end
local PlayerGui = game.Players.LocalPlayer.PlayerGui  

if  _G.AutoLoadPath ~= nil then


    local StartMenu = PlayerGui:WaitForChild("StartMenu", math.huge)
    if StartMenu then
        local PlayButton = StartMenu.Choices:WaitForChild("Play", math.huge)
        if PlayButton and PlayButton:IsA("TextButton") then
            for _, connection in pairs(getconnections(PlayButton.MouseButton1Click)) do
                connection:Fire()
            end
        end
    else
        repeat
            wait()
            StartMenu = PlayerGui:FindFirstChild("StartMenu")
        until StartMenu ~= nil

        local PlayButton = StartMenu.Choices:FindFirstChild("Play")
        if PlayButton and PlayButton:IsA("TextButton") then
            for _, connection in pairs(getconnections(PlayButton.MouseButton1Click)) do
                connection:Fire()
            end
        end
    end
    repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    wait(2)
    local m = {}
    local c = game:GetService("HttpService"):JSONDecode(readfile("KikiHubPaths/".._G.AutoLoadPath..".txt"))
    for i, v in pairs(c) do 
        local decoded = Vector3.new(v[1],v[2],v[3])
        table.insert(m, decoded)
        
    end
    local aj = 0
    for i, v in pairs(m) do
        tween(v)
    end

    wait(3)
    ReturnToMenu()
    wait(1)
    ChangeServer()
    wait() 
end

            if not LPH_OBFUSCATED then
                LPH_NO_VIRTUALIZE = function(...) return ... end;
            end
            LPH_NO_VIRTUALIZE(function()
                
          
            local lp = game:GetService("Players").LocalPlayer
            local ReplicatedStorage = game:GetService'ReplicatedStorage'
            local success,err = pcall(function()
            
                repeat task.wait() until lp.Character
                local RunService = game:GetService("RunService");
                local scriptContextError = game:GetService("ScriptContext").Error
                local call;
                for i, v in next, getconnections(scriptContextError) do
                    v:Disable();
                end
                call = hookmetamethod(game,'__namecall', newcclosure(function(Self,...)
                    if not checkcaller() then
                        --print("worky")
                        local method = getnamecallmethod();
                        local args = {...}
                        if Self == RunService and method == 'IsStudio' then
                            return true;
                        end;
                        if Self == scriptContextError and method == 'Connect' then
                            return coroutine.yield();
                        end    
                    end
                    return call(Self,...)
                end));
                local OldCoroutineWrap
                OldCoroutineWrap = hookfunction(coroutine.wrap, function(Self, ...)
                    if not checkcaller() then
                        if debug.getinfo(Self).source:match("Input") then
                            --print("worky")
                            local args = {...};
                            local constants = getconstants(Self);
                            ---pcall(function()
                             --table.foreach(constants,print);
                            --end)
                            if constants[5] and typeof(constants[5]) == "string" and constants[5]:match("CHECK PASSED:") then
                                return OldCoroutineWrap(Self, ...);
                            end
                            if constants[1] and typeof(constants[1]) == "string" and constants[2] and typeof(constants[2]) == "string"  and (constants[1]:match("scr") and constants[2]:match("Parent")) then
                                game:GetService("Players").LocalPlayer:Kick("KIKI Hub Ban Prevented (You can rejoin)");
                                return coroutine.yield();
                            end
                        end
                    end
            
                    return OldCoroutineWrap(Self, ...)
                end)
                getgenv().SAntiCheatBypass = true
            end)
            if not success then
                lp:Kick("Failed to Disable Anti-Cheat please rejoin");
                warn(success,err);
                return;
            end
            end)();
            
local mt = getrawmetatable(game)
setreadonly(mt, false)


local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and tostring(self) == "Ban" then
       return
    end
    return namecall(self, table.unpack(args))
end)

local mt = getrawmetatable(game)
setreadonly(mt, false)


local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and tostring(self) == "ReportGoogleAnalyticsEvent" then
       return
    end
    return namecall(self, table.unpack(args))
end)

            local scriptContext = game:GetService("ScriptContext")
            local logService = game:GetService("LogService")
            if isfolder("KikiHubPaths") then 

            else 
            makefolder("KikiHubPaths")
            end
            if isfolder("KikiHubAssets") then 

                else 
                makefolder("KikiHubAssets")
                writefile("KikiHubAssets/ModeratorJoin.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/ModeratorJoin.mp3"))
                writefile("KikiHubAssets/IlluJoin.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/IlluJoin.mp3"))
                writefile("KikiHubAssets/ObserveEquip.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/ObserveEquip.mp3"))
                end
            for _, connection in pairs(getconnections(scriptContext.Error)) do
                connection:Disable()
            end
            for _, connection in pairs(getconnections(logService.MessageOut)) do
                connection:Disable()
            end
            local function errorHandler(message, trace)
            local amongus = trace or "haha he tried it"
                print(message.." "..amongus)
            end
            scriptContext.Error:Connect(errorHandler)


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


                    local _Player = game.Players.LocalPlayer;
                    local FrameLIST = _Player.PlayerGui:WaitForChild("LeaderboardGui").MainFrame.ScrollingFrame;
                    
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
                    
                    ----
                    Frame.Visible = false
                    ----
                    
                    
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
                    user.Text = "usernÃ¡me"
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
                    
                    
                    
                    local Player = game.Players.LocalPlayer;
                                        local Frame = Player.PlayerGui:WaitForChild("LeaderboardGui").MainFrame.ScrollingFrame;
                                        local Camera = game.Workspace.CurrentCamera;
                                        
                                        local spectating = false
                                        
                                        
                                        function Spectate(plrName)
                                            pcall(function()
                                        
                                            local player
                                            for _,v in pairs(game.Players:GetPlayers()) do
                                                if v.Character ~= nil and (string.lower(v.Character.Name) == string.lower(string.gsub(tostring(plrName),"[^%w%s_]+",""))) then
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
                                        
                                        function init2()
                                            pcall(function()
                                        
                                            local objects = Frame:GetChildren();
                                            for _, obj in pairs(objects) do
                                                if obj:FindFirstChild("spec") then
                                                    obj:FindFirstChild("spec"):Destroy()
                                                end
                                            end
                                        end)
                                        end
                                        
                                        function init()
                                            pcall(function()
                                            local objects = Frame:GetChildren();
                                            for _, ch in pairs(game.Workspace.Live:GetChildren()) do
                                                ch.Archivable = true
                                            end
                                            
                                            for _, obj in pairs(objects) do
                                                if obj:IsA("TextLabel") then
                                                    if not obj:FindFirstChild("spec") then
                                                        local btn = Instance.new("TextButton", obj)
                                                        btn.Size = UDim2.new(1,0,1,0)
                                                        btn.BackgroundTransparency = 1
                                                        btn.Text = ""
                                                        btn.Name = "spec"
                                                        btn.MouseButton2Click:Connect(function()
                                                            local Camera = game.Workspace.CurrentCamera;
                                                            
                                                            local plrName = btn.Parent.Text
                                                            plrName = plrName:gsub("%s+", "")
                                                            
                                                            Spectate(plrName)
                                                        end);
                                                        btn.MouseButton1Click:Connect(function()
                                                            local plrName = btn.Parent.Text
                                                            plrName = plrName:gsub("%s+", "")
                                                            showInv(plrName)
                                                        end);
                                                    end;
                                                end;
                                            end;
                                        end)
                                        end;
                    
                                        init2()
                                        task.wait(0.25)
                                        init()
                                     Frame.ChildAdded:Connect(init)

 
-- Gui to Lua
-- Version: 3.2

-- Instances:

local Proximity = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProxLabel = Instance.new("TextLabel")

--Properties:

Proximity.Name = "Proximity"
Proximity.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Proximity.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = Proximity
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.386, 0, 0, 0)
MainFrame.Size = UDim2.new(0, 364, 0, 100)
MainFrame.Visible = false -- initially hidden

ProxLabel.Name = "ProxLabel"
ProxLabel.Parent = MainFrame
ProxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProxLabel.BackgroundTransparency = 1.000
ProxLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ProxLabel.BorderSizePixel = 0
ProxLabel.Size = UDim2.new(0, 364, 0, 100)
ProxLabel.Font = Enum.Font.Code
ProxLabel.Text = ""
ProxLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
ProxLabel.TextSize = 25.000

-- Toggle and proximity logic:

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
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

RunService.RenderStepped:Connect(function()
    if not ToggleState then return end
    local closestPlayer = nil
    local closestDistance = 700
    local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localHRP then return end

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
        MainFrame.Visible = true
        ProxLabel.Text = string.format("%s is %.1f studs away from you", closestPlayer.Name, closestDistance)
    else
        MainFrame.Visible = false
    end
end)



    local plr = game:GetService("Players").LocalPlayer.Character
    local function setPlayerHealthDistance(toggleValue)
        for i, v in pairs(workspace.Live:GetChildren()) do
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
    end

    local Toggle = Tabs.GeneralTab:AddToggle("HealerEdictTog", {Title = "Show Healthbars", Default = false })
    
     Toggle:OnChanged(function()
       setPlayerHealthDistance(Options.HealerEdictTog.Value)
    end)





    local Toggle = Tabs.GeneralTab:AddToggle("ModNotifyTog", {Title = "Notification on Mod Join", Default = true})
    Fluent:Notify({
        Title = "Moderator Detection",
        Content = "Checking For Moderators",
        Duration = 4.5
    })
    spawn(function()
        while wait(5) do
            if Options.ModNotifyTog.Value == true then
                local staff = {
                    "Nuttoons",
                    "Selanto12",
                    "lulux44",
                    "LucidZero",
                    "NotASeraph",
                    "jassbux",
                    "fun135090",
                    "Divinos",
                    "pugrat447",
                    "huuc",
                    "baneH1",
                    "Orchamy",
                    "ZaeoMR",
                    "Potioncake",
                    "Sayaphic",
                    "Noah5254",
                    "Seoi_Ha",
                    "Torrera",
                    "v_sheep",
                    "Voidsealer",
                    "2Squids",
                    "pyfrog",
                    "crazywealthyman",
                    "warycoolio",
                    "marvindot",
                    "Taelyia",
                    "SuperEashan",
                    "lleirbag",
                    "Lord_Dusk",
                    "bluetetraninja",
                    "killer67564564643",
                    "0OAmnesiaO0",
                    "SlrCIover",
                    "WinterFIare",
                    "WorkyCIock",
                    "LunarKaiser",
                    "Kark1n0s",
                    "HateKait",
                    "Frostdraw",
                    "iltria",
                    "yomamagamer1",
                    "Etrn_al",
                    "Thunder878712817",
                    "TheNotDave",
                    "Yuukisnoob",
                    "fiod1",
                    "GIovoc",
                    "f_fatexyz",
                    "Ragenbiter (KIKI Hub Owner)"
                }
    
                for _, b in ipairs(staff) do
                    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                        if v.Name == b then
                            local Sound = Instance.new("Sound")
                            Sound.SoundId = "rbxassetid://9120386436"
    
                            if isfile("KikiHubAssets/ModeratorJoin.mp3") then
                                local id = getcustomasset("KikiHubAssets/ModeratorJoin.mp3")
                                local sound = Instance.new("Sound", game:GetService("SoundService"))
                                sound.SoundId = id
                                sound.Looped = false
                                sound:Play()
                            end
    
                            Fluent:Notify({
                                Title = "Moderator in Your Server",
                                Content = "Player: " .. v.Name .. "\nId: " .. v.UserId,
                                Duration = 100,
                            })
                        end
                    end
                end
            end
        end
    end)
       
local illus = {}
local notifierEnabled = false

local IlluToggle = Tabs.GeneralTab:AddToggle("Illu", { Title = "Illusonist Notifer", Default = true })

IlluToggle:OnChanged(function()
    notifierEnabled = Options.Illu.Value
end)

local function handlePlayer(plr)
    -- Check if Observe is already in Backpack
    local backpack = plr:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChild("Observe") and not table.find(illus, plr) then
        table.insert(illus, plr)

        if isfile("KikiHubAssets/IlluJoin.mp3") then
            local id = getcustomasset("KikiHubAssets/IlluJoin.mp3")
            local sound = Instance.new("Sound", game:GetService("SoundService"))
            sound.SoundId = id
            sound.Looped = false
            sound:Play()
        end

        Fluent:Notify({
            Title = "Illusionist in Your Server",
            Content = "Player: " .. plr.Name .. "\nId: " .. plr.UserId,
            Duration = 100,
        })
    end

    -- Listen for tool added to Backpack
    if backpack then
        backpack.ChildAdded:Connect(function(item)
            if item.Name == "Observe" and not table.find(illus, plr) and notifierEnabled then
                table.insert(illus, plr)

                if isfile("KikiHubAssets/IlluJoin.mp3") then
                    local id = getcustomasset("KikiHubAssets/IlluJoin.mp3")
                    local sound = Instance.new("Sound", game:GetService("SoundService"))
                    sound.SoundId = id
                    sound.Looped = false
                    sound:Play()
                end

                Fluent:Notify({
                    Title = "Illusionist in Your Server",
                    Content = "Player: " .. plr.Name .. "\nId: " .. plr.UserId,
                    Duration = 100,
                })
            end
        end)
    end

    -- Listen for tool being equipped (moved to Character)
    plr.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(item)
            if item.Name == "Observe" then
                if isfile("KikiHubAssets/ObserveEquip.mp3") then
                    local id = getcustomasset("KikiHubAssets/ObserveEquip.mp3")
                    local sound = Instance.new("Sound", game:GetService("SoundService"))
                    sound.SoundId = id
                    sound.Looped = false
                    sound:Play()
                end

                Fluent:Notify({
                    Title = "Illusionist Equipped Observe",
                    Content = "Player: " .. plr.Name .. "\nId: " .. plr.UserId,
                    Duration = 25,
                })
            end
        end)
    end)

    -- Also check current character immediately (if loaded)
    if plr.Character then
        for _, item in ipairs(plr.Character:GetChildren()) do
            if item.Name == "Observe" then
                Fluent:Notify({
                    Title = "Illusionist Equipped Observe",
                    Content = "Player: " .. plr.Name .. "\nId: " .. plr.UserId,
                    Duration = 25,
                })
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
            wait(.90)
        firesignal(v.MouseButton1Click)
    
        end
    end)
    else 
        spawn(function()
        pcall(function()
            local ui = game.Players.LocalPlayer.PlayerGui:WaitForChild("BardGui")
            ui.ChildAdded:Connect(function(v)
                if v.Name == "Button" and AutoBard == true then
                    wait(.90)
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
                    wait(.90)
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

local noclip = false
local upthingy = function()
    pcall(function()
        local newanim = Instance.new("Animation")
        newanim.AnimationId = "rbxassetid://2986649587"
        local a = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(newanim)
        a.Priority = Enum.AnimationPriority.Action4
        a:Play()
        wait(1.75)
        a:AdjustSpeed(0)
        noclip = true

        game.RunService.RenderStepped:Connect(function()
        
        if game.Players.LocalPlayer.Character and noclip == true and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
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
            noclip = true

            game.RunService.RenderStepped:Connect(function()
            
            if game.Players.LocalPlayer.Character and noclip == true and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
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
    Description = "Disables the animation Highlight and the noclip",
    Callback = function()
        Window:Dialog({
            Title = "Confirmation",
            Content = "Are you sure this will reset your character.",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        noclip = false
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            game.Players.LocalPlayer.Character.Humanoid.Health = 0
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 1
                        end
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
                               while wait() do
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

local connection

NoStunToggle:OnChanged(function()
    NoStun = Options.NoStunOpt.Value

    if NoStun then
        -- Connect to ChildAdded only once
        if not connection then
            connection = game.Players.LocalPlayer.Character.ChildAdded:Connect(function(child)
                if unwantedNames[child.Name] then
                    task.wait()  -- Optional: Give time for properties to load
                    child:Destroy()
                end
            end)
        end
    else
        -- Disconnect when toggle is off
        if connection then
            connection:Disconnect()
            connection = nil
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local noclipEnabled = false
local moveSpeed = 150
local tweenSpeed = 5

local function enableNoclip(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoid and rootPart then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        for i, v in ipairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end

        local ts = game:GetService("TweenService")
        while noclipEnabled and humanoid and rootPart do
            local newpos = rootPart.CFrame + humanoid.MoveDirection * tweenSpeed
            ts:Create(rootPart, TweenInfo.new(0, Enum.EasingStyle.Linear), {CFrame = newpos}):Play()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait()
        end
    end
end

local function disableNoclip(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoid and rootPart then
        humanoid:ChangeState(Enum.HumanoidStateType.None)
        rootPart.CanCollide = true
    end
end

spawn(function()
    while wait() do
        local character = LocalPlayer.Character
        if character then
            if noclipEnabled then
                enableNoclip(character)
            else
                disableNoclip(character)
            end
        end
    end
end)

local NoclipToggle = Tabs.PlayerTab:AddToggle("Noclip", { Title = "Noclip", Default = false })
NoclipToggle:OnChanged(function()
noclipEnabled = Options.Noclip.Value
end)
local Noclipkeybind = Tabs.PlayerTab:AddKeybind("NoclipKb", {
    Title = "Noclip (Keybind)",
    Mode = "Toggle",
    Default = "F3", 

    Callback = function(Value)
    noclipEnabled = not noclipEnabled
    Options.Noclip:SetValue(noclipEnabled)
    end,
})
local NoclipMoveSpeedSlider = Tabs.PlayerTab:AddSlider("NoclipMoveSpeed", {
    Title = "Move Speed",
    Description = "How fast you move forward.",
    Default = 150,
    Min = 100,
    Max = 275,
    Rounding = 0,
    Callback = function(Value)
        moveSpeed = Value
    end
})
local NoclipTweenSpeedSlider = Tabs.PlayerTab:AddSlider("NoclipTweenSpeed", {
    Title = "Tween Speed",
    Description = "This bypasses the noclip detection recommended to keep at Default.",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        tweenSpeed = Value
    end
})
game:GetService("RunService").RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if noclipEnabled and character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoid and rootPart then
            local direction = humanoid.MoveDirection
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            rootPart.CFrame = rootPart.CFrame + (direction * moveSpeed * game:GetService("RunService").RenderStepped:Wait())
        end
    end
end)

if game.Players.LocalPlayer.Character then
local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
hum.Died:Connect(function()
Options.Noclip:SetValue(false)
noclipEnabled = false
end)
end
game.Players.LocalPlayer.CharacterAdded:Connect(function()
local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
hum.Died:Connect(function()
Options.Noclip:SetValue(false)
noclipEnabled = false
end)
end)


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
            wait(0.1) 

            game.Players.LocalPlayer.Character.Humanoid:EquipTool(foundtool)
            spawn(function()

            while not foundtool:IsDescendantOf(game.Players.LocalPlayer.Character) do
                wait(0.1)
            end

            wait(0.1)
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
    spawn(function()
while knockedownership do
        wait()
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
    wait(.1)
end)
end
end)

local LoopGain = false
local LoopGainOrderlyTog = Tabs.PlayerTab:AddToggle("LPGO", { Title = "Loop Gain Orderly", Default = false })
LoopGainOrderlyTog:OnChanged(function()
    LoopGain = Options.LPGO.Value
    if LoopGain == true and game.Players.LocalPlayer.Backpack:FindFirstChild("Tespian Elixir") then 
        local tespfarm = true 
        spawn(function()
            while LoopGain do 
                
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then 
                    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    hum:UnequipTools()
                    hum:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Tespian Elixir"))

                    wait(0.7)

                    game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, true, game, 0)
                    wait(0.2)
                    game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, false, game, 0)
                    wait(0.7)

                    hum.Health = 0
                end
                wait(8)
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
    local vim = game:GetService('VirtualInputManager')
    local function pressKey(key)
    vim:SendKeyEvent(true, key, false, game)
    end
    
    local function releaseKey(key)
    vim:SendKeyEvent(false, key, false, game)
    end
    
    local holding = false
    spawn(function()
    while wait() do 
    if ACGMana then
    if game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character:FindFirstChildOfClass("ForceField") and game.Players.LocalPlayer.Character:FindFirstChild("Mana") then
        local mana = game.Players.LocalPlayer.Character:FindFirstChild("Mana").Value
        if mana <= getgenv().DesiredAmt then
        pressKey("G")
        else
            releaseKey("G")
        end
    end
    end
end
    end)
local ACGToggle = Tabs.PlayerTab:AddToggle("ACG", { Title = "Auto Charge Mana", Default = false })
ACGToggle:OnChanged(function()
ACGMana = Options.ACG.Value
wait(.5)
releaseKey("G")
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
    showMana = showManaToggle.Value
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
            wait()
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

local labels, artilabels = {}, {}

-- Update label colors dynamically
task.spawn(function()
    while true do
        task.wait(0.2)
        for _, v in pairs(labels) do v.Color = TrinketEspColor end
        for _, v in pairs(artilabels) do v.Color = ArtifactEspColor end
    end
end)

local function WTS(pos)
    local cam = workspace.CurrentCamera
    local screenPos, visible = cam:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), visible, screenPos.Z
end

local function AddLabelToTable(label, isArtifact)
    table.insert(isArtifact and artilabels or labels, label)
end

local function GetLabelName(obj)
    local p = obj.Parent
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
    elseif p:IsA("MeshPart") and Meshes[p.MeshId] then
        return Meshes[p.MeshId], false
    end

    if mesh and Meshes[mesh.MeshId] then
        return Meshes[mesh.MeshId], false
    end

    return nil
end

local function CreateESP(obj)
    local label = Drawing.new("Text")
    local bottom = Drawing.new("Text")
    local labelName, isArtifact = GetLabelName(obj)

    if not labelName then return end

    label.Text = labelName
    label.Color = isArtifact and ArtifactEspColor or TrinketEspColor
    label.Size = 15
    label.Outline, label.Center, label.Font = true, true, 0

    bottom.Size = 12
    bottom.Outline, bottom.Center, bottom.Font = true, true, 0
    bottom.Color = Color3.fromRGB(50, 50, 50)

    AddLabelToTable(label, isArtifact)

    local connection
    local lastRefresh = 0

    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if not getgenv().ESPTOGGLE1 then
            label.Visible, bottom.Visible = false, false
            return
        end

        if (tick() - lastRefresh) >= 0.014 then
            lastRefresh = tick()

            if not obj:IsDescendantOf(workspace) then
                label:Remove()
                bottom:Remove()
                connection:Disconnect()
                return
            end

            local pos, visible, dist = WTS(obj.Position)
            if visible then
                label.Position = pos
                label.Visible = true
                bottom.Position = pos + Vector2.new(0, 15)
                bottom.Text = string.format("Distance: [%d]", dist)
                bottom.Visible = true
            else
                label.Visible = false
                bottom.Visible = false
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

    workspace.ChildAdded:Connect(function(v)
        if v:IsA("BasePart") then
            for _, desc in pairs(v:GetDescendants()) do
                if desc:IsA("ClickDetector") then
                    CreateESP(desc.Parent)
                end
            end
        end
    end)
end

local function DisableESP()
    getgenv().ESPTOGGLE1 = false
end

-- UI Integration
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
                    local bagPickupLoop
local AutoBagPickUpToggle = Tabs.EspTab:AddToggle("ABGPickUp", { Title = "Auto Bag Pick Up", Default = false })
AutoBagPickUpToggle:OnChanged(function()
AutoBagPickUp = Options.ABGPickUp.Value
if AutoBagPickUp then
    bagPickupLoop = spawn(function()
        local player = game.Players.LocalPlayer
        local humanoidRootPart = player.Character.HumanoidRootPart
        local offset = Vector3.new(0, -1, 0) 
        local maxDistance = 20

        while AutoBagPickUp do
            wait()

            for _, bag in ipairs(workspace.Thrown:GetChildren()) do
                if (bag.Name == "ToolBag" or bag.Name == "MoneyBag") and (humanoidRootPart.Position - bag.Position).Magnitude <= maxDistance then
                    bag.Position = humanoidRootPart.Position + offset
                end
            end
        end
    end)
else
    if bagPickupLoop then
        bagPickupLoop:Destroy()
        bagPickupLoop = nil
    end
end
end)
local wrksp = game.workspace
local maxdist = 10 
local AutoPickup = false
spawn(function()
    while wait() do 
    if AutoPickup then 
        local success, error = pcall(function()
            for i, v in pairs(wrksp:GetChildren()) do
                if AutoPickup and v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then
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
    if v:FindFirstChild("UnionOperation") and v:FindFirstChild("UnionOperation"):FindFirstChild("ClickDetector") then
    ingfolder = v 
    end
    end
    
    spawn(function()
    pcall(function()
    while wait(0.5) do 
    for i, v in pairs(ingfolder:GetChildren()) do 
    if autoingpickup == true and v:IsA("UnionOperation") and v:FindFirstChild("ClickDetector") and v:FindFirstChild("ClickDetector").MaxActivationDistance == 10 and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and  (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).Magnitude < 10 then 
    fireclickdetector(v.ClickDetector)
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

local AntiMentalInjuriesToggle = Tabs.PlayerTab:AddToggle("AMI", { Title = "Anti Mental Injuries", Default = false })
AntiMentalInjuriesToggle:OnChanged(function()
AntiMentalInjuries = Options.AMI.Value
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
if AntiMentalInjuries then
spawn(function()
while AntiMentalInjuries do
wait()
local character_children = character:GetChildren()

for index = 1, #character_children do
local child = character_children[index]

if child and mental_injuries[child.Name] then
child:Destroy()
end
end
end
end)
end
end)
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



if game.PlaceId == 3541987450 then
    local CollectorNotifier = false
    local CollectorNotifierTog = Tabs.EspTab:AddToggle("CNotifier", { Title = "Collector Notifier", Default = false })

    local workspace = game:GetService("Workspace")
    local ExitFolder = workspace:FindFirstChild("ExitFolder")

    if not ExitFolder then
        ExitFolder = Instance.new("Folder")
        ExitFolder.Name = "ExitFolder"
        ExitFolder.Parent = workspace

        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Exit") then
                v.Parent = ExitFolder
            end
        end
    end

    CollectorNotifierTog:OnChanged(function()
        CollectorNotifier = Options.CNotifier.Value

        local collectorpos = {
           ["Plains"] = Vector3.new(-1283.07092, 1164.82434, -2338.98315),
           ["Jungle"] = Vector3.new(-2604.67871, 1039.32373, 1475.43689),
           ["Beach"] = Vector3.new(-834.719971, 252.000061, 272.730011),
           ["Desert"] = Vector3.new(-1546.47192, 363.750061, 2620.54663),
        }

        function getClosestCollector(part)
            local closest = nil
            local closestMag = math.huge

            if part:IsA("BasePart") then
                for collectorName, collectorPosition in pairs(collectorpos) do
                    local mag = (part.Position - collectorPosition).Magnitude
                    if mag < closestMag then
                        closest = collectorName
                        closestMag = mag
                    end
                end
            else
                closest = "not a part"
            end

            return closest
        end

        while CollectorNotifier do
            for _, child in ipairs(ExitFolder:GetChildren()) do
                if child:IsA("Part") and child.Transparency == 1 then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Collector Spawned",
                        Text = "Collector Spawned At " .. getClosestCollector(child),
                        Duration = 5,
                    })
                end
            end
            wait(1)
        end
    end)
end

local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/idontknowwhattonamemyself/modified/Lua/new'))()
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




local ToggleStartFarm = Tabs.BotsTab:AddToggle("FarmStart", { Title = "Start Farm", Default = false })
ToggleStartFarm:OnChanged(function()
farm = Options.FarmStart.Value
while farm do
    local aj = 0
    for i, v in pairs(a) do 
        aj = aj + 1
        tween(v)
        
        if aj == #a then 
            wait(1)
            game:GetService("StarterGui"):SetCore("PromptBlockPlayer", game.Players:GetChildren()[2])
            wait(1)
            local blockpos = game:GetService("CoreGui").RobloxGui.PromptDialog.ContainerFrame.ConfirmButton.AbsolutePosition
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(blockpos.X + 5, blockpos.Y + 40, 0, true, game, 0)
            wait(1)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(blockpos.X + 5, blockpos.Y + 40, 0, false, game, 0)
            wait(1)
            ReturnToMenu()
            wait(2)
            ChangeServer()
        end
        
    end
    wait() 
end
end)

Tabs.BotsTab:AddButton({
    Title = "Create Point",
    Description = "Creates a point/s that you will tween trough",
    Callback = function()
        table.insert(a, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
        local PlayerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local Visualizer = Instance.new("Part", game.Workspace)
        Visualizer.Name = "Visualize"  
        Visualizer.Position = PlayerPosition  
        Visualizer.Transparency = 0.5
        Visualizer.Material = Enum.Material.Neon
        Visualizer.Anchored = true
        Visualizer.CanCollide = false
    end
})


local savename = "default"
            
            local InputSavePath = Tabs.BotsTab:AddInput("Input", {
                Title  = "Path Filename",
                Placeholder  = "default",
                Numeric = false, -- Only allows numbers
                Finished = false, -- Only calls callback when you press enter
                Callback = function(Text)
                    savename = Text
                end,
            })
            local ButtonSavePath = Tabs.BotsTab:AddButton({
                Title = "Save Path",
                Description = "Save your path with a name so you can put it in your autoexec or load it later",
                Callback = function()
                    local m = {}
                    for i, v in pairs(a) do 
                        table.insert(m, {v.X, v.Y, v.Z}) 
                    end
                    local tosave = game.HttpService:JSONEncode(m)
                    writefile("KikiHubPaths/"..savename..".txt", tosave)
                end,
            })
            local InputSavePath = Tabs.BotsTab:AddInput("Input", {
                Title  = "Load Path",
                Placeholder  = "default",
                Numeric = false, -- Only allows numbers
                Finished = false, -- Only calls callback when you press enter
                Callback = function(Text)
                    if isfile("KikiHubPaths/"..Text..".txt") then 
                        local m = {}
                        local c = game.HttpService:JSONDecode(readfile("KikiHubPaths/"..Text..".txt"))
                        for i, v in pairs(c) do 
                            table.insert(m, Vector3.new(v[1], v[2], v[3]))
                        end
                        a = m
                    end
                end,
            })
            Tabs.BotsTab:AddButton({
                Title = "Clear Points",
                Description = "Clears your Points",
                Callback = function()
                    Window:Dialog({
                        Title = "Clear Points Confirmation",
                        Content = "Are you sure that you want to clear your points?",
                        Buttons = {
                            {
                                Title = "Confirm",
                                Callback = function()
                                    a = {}
                                    for i, v in pairs(game.Workspace:GetChildren()) do
                                        if v:IsA("Part") and v.Name == "Visualize" then
                                            v:Destroy()
                                        end
                                    end
                                end,
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
            spawn(function()
                while wait() do  
                    local lp = game.Players.LocalPlayer 
                    local char = lp.Character or lp.CharacterAdded:Wait()
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if char and hrp and farm == true then 
                        hrp.Velocity = Vector3.new()
        
                    end 
                end
        end)

        local Potion = "Health Potion"
local potions = {
    ["Health Potion"] = {"Scroom", "Scroom","Lava Flower"},
    ["Tespian Elixir"] = {"Moss Plant", "Moss Plant", "Lava Flower", "Scroom"},
    ["Bone Growth"] = {"Trote", "Uncanny Tentacle", "Strange Tentacle"},
    ["Switch Witch"] = {"Dire Flower", "Glowshroom", "Glowshroom"},
    ["Silver Sun"] = {"Desert Mist", "Freeleaf", "Polar Plant"},
    ["Kingsbane"] ={"Crown Flower", "Vile Seed", "Vile Seed"},
    ["Lordsbane"] = {"Crown Flower", "Crown Flower","Crown Flower"},
    ["Feather Feet"] = {"Creely", "Dire Flower", "Polar Plant"}
}
local potionnames = {
    "Health Potion",
"Tespian Elixir",
"Bone Growth",
"Switch Witch",
"Silver Sun",
    "Kingsbane",
    "Lordsbane",
"Feather Feet"
}
function getcloseststation(stationname)
    local closest = nil
local closestmag = 99999999999999999999

    if workspace:FindFirstChild("Stations") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 

for i, v in pairs(workspace.Stations:GetChildren()) do 
    if v.ClassName == "Model" and v:FindFirstChildOfClass("Part") and v.Name == stationname then 
    local mag = (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChildOfClass("Part").Position).Magnitude
    if mag < closestmag then 
    closestmag = mag
    closest = v
    end
    else print("no primary part")    
end
end
end
return {["Closest"] = closest, ["Distance"] = closestmag}
end
function makepotion(meow) 
    local recipe = potions[Potion]
    local potion = Potion
    print(recipe)
    if recipe then 
        local newrec = table.clone(recipe)
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
        if table.find(newrec, v.Name) and v:FindFirstChild("Quantity") then 
            local quantity = v.Quantity.Value
            repeat wait() quantity = quantity -  1
                 table.remove(newrec, table.find(newrec,v.Name))
                 until not table.find(newrec, v.Name)
            print("Print Removed "..v.Name.." Ingredients Left: "..#newrec)
        end
        end
        for i, v in pairs(newrec) do 
        print(v)
        end
        print(newrec)
        if #newrec == 0 then
            Fluent:Notify({
                Title = "You have the ingredients",
                Content = "cool ?",
                SubContent = nil,
                Duration = 10
            })
            newrec = table.clone(recipe)
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if table.find(newrec, v.Name) then 
                    local quantity = v.Quantity.Value

                    repeat wait()  
                    quantity = quantity -  1 
                    table.remove(newrec, table.find(newrec,v.Name))
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then 
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(v)
                        local rem = v:FindFirstChild("RemoteEvent") 
                        local pot = getcloseststation("AlchemyStation")
                        wait(.1)

                        if rem and type(pot) == "table" and pot.Closest ~= nil and pot.Distance < 10 then 
                        local args = {
                            [1] = pot.Closest.Water.CFrame,
                            [2] = pot.Closest.Water
                        }
                        rem:FireServer(unpack(args))
                        if #newrec == 0 then 
                        fireclickdetector(pot.Closest.Ladle:FindFirstChildOfClass("ClickDetector"))
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
                        end
                    elseif pot.Distance > 10 then 
                        Fluent:Notify({
                            Title = "go closer to pot",
                            Content = "",
                            SubContent = nil,
                            Duration = 10
                        })
                        end

                    end 
                    until not table.find(newrec, v.Name)
                end
                end
        else 
            local missing = ""
            for i, v in pairs(newrec) do 
            missing = missing..v..", "
            end
            Fluent:Notify({
                Title = "ur missing stuff: "..missing,
                Content = "lol broke",
                SubContent = nil,
                Duration = 10
            })
        end
    end
end

local BrewPotionsDropdown = Tabs.AutomationTab:AddDropdown("PotionSelect", {
    Title = "Select Potion",
    Values = potionnames,
    Multi = false
})
BrewPotionsDropdown:OnChanged(function(Value)
Potion = Value
end)

Tabs.AutomationTab:AddButton({
    Title = "Brew Potion",
    Description = "Brews the selected potion.",
    Callback = function()
        print("Trying to brew "..Potion)
        makepotion(Potion)
    end
})

if game.PlaceId ~= 3541987450 then 
function inntp(tpto)
    local textoption = "Sure."
    local yoffset = 75
    local xoffset = 50
    local succ, err = pcall(function()
    local found = nil
    for i, v in pairs(workspace.NPCs:GetChildren()) do 
    if v.Name == "Inn Keeper" and v:FindFirstChild("Location") and v.Location.Value == tpto then
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    
    
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health = 0
            game.Players.LocalPlayer.CharacterAdded:Wait()
            local a = 10
            local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            hrp:GetPropertyChangedSignal("CFrame"):Wait()
            spawn(function()
            while hrp ~= nil and wait() do 
            
            end
            end)
    
    
            game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.HumanoidRootPart.CFrame
            hrp.Anchored = true
    
            print("teleleleleleported")
            local click = true
            game.RunService.RenderStepped:Connect(function()
            if click == true then 
                hrp.Velocity = Vector3.new()
                
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.HumanoidRootPart.CFrame
            end
            end)
            spawn(function()
            while wait() and click == true do 
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.HumanoidRootPart.CFrame
                hrp.Anchored = not hrp.Anchored
                hrp.Velocity = Vector3.new()
                print("anchor")
                fireclickdetector(v.ClickDetector)
                print("click")
                if game.Players.LocalPlayer and game.Players.LocalPlayer.PlayerGui and game.Players.LocalPlayer.PlayerGui:FindFirstChild("DialogueGui") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("DialogueGui"):FindFirstChild("DialogueFrame"):FindFirstChild("Choices") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("DialogueGui"):FindFirstChild("DialogueFrame"):FindFirstChild("Choices"):FindFirstChild(textoption) and game.Players.LocalPlayer.PlayerGui:FindFirstChild("DialogueGui"):FindFirstChild("DialogueFrame"):FindFirstChild("Choices"):FindFirstChild(textoption):FindFirstChild("TextButton") then 
                local buttonpos = game.Players.LocalPlayer.PlayerGui:FindFirstChild("DialogueGui"):FindFirstChild("DialogueFrame"):FindFirstChild("Choices"):FindFirstChild(textoption).TextButton.AbsolutePosition
                game:GetService('VirtualInputManager'):SendMouseButtonEvent(buttonpos.X + xoffset, buttonpos.Y + yoffset, 0, true, game, 0)
                print("button")
                wait()
                game:GetService('VirtualInputManager'):SendMouseButtonEvent(buttonpos.X + xoffset, buttonpos.Y + yoffset, 0, false, game, 0)
                end
            end
            end) 
            wait(1)
            click = false
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health = 0
    
    
        end 
    end
    end
    end)
    print(err)
    end

local TeleportTo = Tabs.ExploitsTab:AddDropdown("Teleport", {
    Title = "Teleport To",
    Values = {"Southern Sanctuary","Castle Sanctuary","Sleeping Snail","Wayside Inn","Alana","Oresfall","Renova","Santorini"},
    Multi = false
})
TeleportTo:OnChanged(function(Value)
inntp(Value)
end)
end
local CandyUi = Instance.new("ScreenGui")
CandyUi.Enabled = false
local xpfarm = false
local Candytable = {"Red"}
local ExpFarm = Tabs.ExploitsTab:AddDropdown("Candy Farm", {
    Title = "Auto Farm EXP",
    Values = {"Red","Blue", "Green", "Orange", "White", "Black"},
    Multi = false
})

ExpFarm:OnChanged(function(Value)
Candytable = {Value}
end)
local ExpFarmToggle = Tabs.ExploitsTab:AddToggle("ExpFarm", {Title = "Start Candy Farm", Default = false })
ExpFarmToggle:OnChanged(function()
  xpfarm = Options.ExpFarm.Value
  CandyUi.Enabled = Options.ExpFarm.Value
  if Options.ExpFarm.Value == true then 
    pcall(function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and #game.Players.LocalPlayer.Backpack:GetChildren() > 1 then
            wait(.3)
            for i, v in pairs(Candytable) do 
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(v.." Candy"))
            game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, true, game, 0)
            wait(.1)
                            game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, false, game, 0)
            end
            wait(.2) 
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health = 0
            candycounter = candycounter + 1
        end
        end)
  end
end)
local real = false
local candycounter = 0
local TextLabel = Instance.new("TextLabel")
CandyUi.Parent = gethui() or game:GetService("CoreGui")
CandyUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TextLabel.Parent = CandyUi
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.415812582, 0, 0.139393941, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Current Candies: null"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 15.000
TextLabel.TextStrokeColor3 = Color3.fromRGB(122, 114, 0)
TextLabel.TextStrokeTransparency = 0.000
spawn(function()
    
    while wait() do 
    pcall(function()
        if real == false and xpfarm == true and CandyUi ~= nil and CandyUi.FindFirstChild and CandyUi:FindFirstChild("TextLabel") and TextLabel ~= nil then
        TextLabel.Text = "Current Candies: "..tostring(candycounter)
        end
    end)
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
if xpfarm == true and real == false then 
    repeat wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and #game.Players.LocalPlayer.Backpack:GetChildren() > 1
    pcall(function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and #game.Players.LocalPlayer.Backpack:GetChildren() > 1 then
            wait(.3)
            for i, v in pairs(Candytable) do 
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(v.." Candy"))
            game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, true, game, 0)
            wait(.1)
                            game:GetService('VirtualInputManager'):SendMouseButtonEvent(50, 100, 0, false, game, 0)
            end
                            wait(.1) 
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health = 0
            candycounter = candycounter + 1
        end
        end)
    elseif real == false and xpfarm == false then
        real = true
        candycounter = 0
        CandyUi:Destroy()
end
end)


Tabs.ExploitsTab:AddParagraph({
    Title = "Instructions",
    Content = "4 Exp Candy = 1 ZScroom\nRed = Sword EXP\nBlue = Spear EXP\nGreen Candy = Dagger EXP\nOrange Candy = Fist EXP\nWhite = Orderly (1)\nBlack = Chaotic (1)"
})


-- Initialize variables
local dayFarmEnabled = false
local kickDistance = 10

-- Replace with the Game's PlaceId to teleport to
local GAME_PLACE_ID = 3016661674

-- Add a toggle for Day Farm
local DayFarmToggle = Tabs.AutomationTab:AddToggle("DayFarmToggle", {
    Title = "Enable Day Farm",
    Default = false
})


DayFarmToggle:OnChanged(function()
    dayFarmEnabled = DayFarmToggle.Value
    print("Day Farm Enabled:", dayFarmEnabled)
end)

-- Add a slider for distance
local DistanceSlider = Tabs.AutomationTab:AddSlider("KickDistance", {
    Title = "Kick Distance",
    Description = "Distance to trigger escape",
    Default = 10,
    Min = 1,
    Max = 1000,
    Rounding = 1,
    Callback = function(Value)
        kickDistance = tonumber(Value) or 10
        print("Kick Distance set to:", kickDistance)
    end
})

-- Function to teleport after kick
local function kickAndTeleport()
    local TeleportService = game:GetService("TeleportService")
    local localPlayer = game.Players.LocalPlayer

    task.spawn(function()
        task.wait(0.5)
        pcall(function()
            TeleportService:Teleport(GAME_PLACE_ID, localPlayer)
        end)
    end)

    localPlayer:Kick("Player too close. Rejoining another server...")
end

-- Function to check player distances
local function checkProximity()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer or not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    local localPosition = localPlayer.Character.HumanoidRootPart.Position

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = player.Character.HumanoidRootPart.Position
            local distance = (localPosition - targetPosition).Magnitude
            if tonumber(distance) <= tonumber(kickDistance) then
                print("Player within kick distance detected. Kicking and teleporting...")
                kickAndTeleport()
                break
            end
        end
    end
end

-- Monitor proximity when Day Farm is enabled
task.spawn(function()
    while true do
        task.wait(1)
        if dayFarmEnabled then
            checkProximity()
        end
    end
end)



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

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Remotes = Character:WaitForChild("CharacterHandler"):WaitForChild("Remotes")

local PlayerTab = Tabs:CreateTab("Player")

PlayerTab:AddButton({
    Title = "Trigger Fall Damage Knockback",
    Description = "Ask confirmation before triggering knockback",
    Callback = function()
        -- Show confirmation dialog FIRST
        Window:Dialog({
            Title = "Confirm Action",
            Content = "Are you sure you want to trigger knockback?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        -- Run the detection and knockback only after confirmation
                        local testArgs = {
                            {0.0063388854709866774, 0.35192488960597823},
                            {}
                        }
                        local knockArgs = {
                            {0.01, 1.1},
                            {}
                        }

                        local fallDamageRemote = nil
                        print("🔍 Searching for fall damage remote...")

                        for _, remote in pairs(Remotes:GetChildren()) do
                            if remote:IsA("RemoteEvent") then
                                local initialHealth = Humanoid.Health
                                local success, err = pcall(function()
                                    remote:FireServer(unpack(testArgs))
                                end)

                                if success then
                                    wait(0.5)
                                    if Humanoid.Health < initialHealth then
                                        fallDamageRemote = remote
                                        print("✅ Fall damage remote found:", remote.Name)
                                        break
                                    else
                                        print("❌ Remote", remote.Name, "did not cause damage.")
                                    end
                                else
                                    print("⚠️ Error firing remote", remote.Name, ":", err)
                                end
                            end
                        end

                        if fallDamageRemote then
                            print("⚡ Triggering knockback with stronger args...")
                            fallDamageRemote:FireServer(unpack(knockArgs))
                            print("✅ Knock triggered successfully.")
                        else
                            warn("❌ Fall damage remote not found.")
                        end
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled knockback trigger.")
                    end
                }
            }
        })
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

            
end)
