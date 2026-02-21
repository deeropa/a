-- Custom Notification System
-- Load via: loadstring(game:HttpGet("raw_url"))() or dofile()
-- Usage: notify("Title text here", Color3.fromRGB(0, 255, 128), 5)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Reuse existing GUI or create new (CoreGui only to avoid anticheat)
local NotificationGui = getgenv().__notifGui
if not NotificationGui or not NotificationGui.Parent then
    NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "CustomNotifications"
    NotificationGui.ResetOnSpawn = false
    NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotificationGui.DisplayOrder = 999
    NotificationGui.Parent = game:GetService("CoreGui")
    getgenv().__notifGui = NotificationGui
end

-- Track active notifications (persist across re-executions)
local NOTIF_HEIGHT = 36
local NOTIF_GAP = 6
if not getgenv().__activeNotifs then
    getgenv().__activeNotifs = {}
end
local activeNotifs = getgenv().__activeNotifs

local function repositionAll()
    for i, notif in ipairs(activeNotifs) do
        local targetY = (i - 1) * (NOTIF_HEIGHT + NOTIF_GAP)
        TweenService:Create(notif, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 16, 0, 16 + targetY)
        }):Play()
    end
end

local function removeFromList(notif)
    for i, n in ipairs(activeNotifs) do
        if n == notif then
            table.remove(activeNotifs, i)
            break
        end
    end
    repositionAll()
end

local function notify(text, accentColor, duration)
    accentColor = accentColor or Color3.fromRGB(0, 200, 255)
    duration = duration or 4

    local yPos = #activeNotifs * (NOTIF_HEIGHT + NOTIF_GAP)

    -- Main notification (TextButton for click support)
    local Notif = Instance.new("TextButton")
    Notif.Name = "Notif_" .. tostring(tick())
    Notif.Parent = NotificationGui
    Notif.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Notif.BackgroundTransparency = 1
    Notif.BorderSizePixel = 0
    Notif.Position = UDim2.new(0, 16, 0, 16 + yPos)
    Notif.Size = UDim2.new(0, 400, 0, NOTIF_HEIGHT)
    Notif.ClipsDescendants = true
    Notif.Text = ""
    Notif.AutoButtonColor = false

    table.insert(activeNotifs, Notif)

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Notif

    -- Accent bar
    local AccentBar = Instance.new("Frame")
    AccentBar.Name = "Accent"
    AccentBar.Parent = Notif
    AccentBar.BackgroundColor3 = accentColor
    AccentBar.BackgroundTransparency = 1
    AccentBar.BorderSizePixel = 0
    AccentBar.Size = UDim2.new(0, 4, 1, 0)

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 4)
    AccentCorner.Parent = AccentBar

    -- Text
    local Label = Instance.new("TextLabel")
    Label.Name = "Text"
    Label.Parent = Notif
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.Size = UDim2.new(1, -20, 1, 0)
    Label.Font = Enum.Font.GothamMedium
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 235)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.TextTransparency = 1

    -- Dismiss
    local dismissed = false
    local function dismissNotif()
        if dismissed then return end
        dismissed = true

        TweenService:Create(Label, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { TextTransparency = 1 }):Play()
        TweenService:Create(AccentBar, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { BackgroundTransparency = 1 }):Play()
        TweenService:Create(Notif, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { BackgroundTransparency = 1 }):Play()

        task.wait(0.25)
        removeFromList(Notif)
        Notif:Destroy()
    end

    Notif.MouseButton1Click:Connect(dismissNotif)

    -- Fade in
    TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { BackgroundTransparency = 0.15 }):Play()
    TweenService:Create(AccentBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(Label, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { TextTransparency = 0 }):Play()

    -- Auto-dismiss
    task.delay(duration, dismissNotif)

    return Notif
end

getgenv().notify = notify

return notify
