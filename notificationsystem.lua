-- Custom Notification System
-- Load via: loadstring(game:HttpGet("raw_url"))() or dofile()
-- Usage: notify("Title text here", Color3.fromRGB(0, 255, 128), 5)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Container
local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "CustomNotifications"
NotificationGui.ResetOnSpawn = false
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationGui.DisplayOrder = 999

-- Try CoreGui first (persists through resets), fall back to PlayerGui
pcall(function()
    NotificationGui.Parent = game:GetService("CoreGui")
end)
if not NotificationGui.Parent then
    NotificationGui.Parent = PlayerGui
end

local Container = Instance.new("Frame")
Container.Name = "NotifContainer"
Container.Parent = NotificationGui
Container.BackgroundTransparency = 1
Container.AnchorPoint = Vector2.new(0, 0)
Container.Position = UDim2.new(0, 16, 0, 16)
Container.Size = UDim2.new(0, 400, 0.6, 0)

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.VerticalAlignment = Enum.VerticalAlignment.Top
Layout.Padding = UDim.new(0, 6)

-- Notification counter for ordering (newest at bottom)
local notifOrder = 0

local function notify(text, accentColor, duration)
    accentColor = accentColor or Color3.fromRGB(0, 200, 255)
    duration = duration or 4

    notifOrder = notifOrder + 1

    -- Main notification frame
    local Notif = Instance.new("Frame")
    Notif.Name = "Notif_" .. notifOrder
    Notif.Parent = Container
    Notif.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Notif.BackgroundTransparency = 0.15
    Notif.BorderSizePixel = 0
    Notif.Size = UDim2.new(1, 0, 0, 0) -- start collapsed
    Notif.ClipsDescendants = true
    Notif.LayoutOrder = notifOrder

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Notif

    -- Accent bar on left
    local AccentBar = Instance.new("Frame")
    AccentBar.Name = "Accent"
    AccentBar.Parent = Notif
    AccentBar.BackgroundColor3 = accentColor
    AccentBar.BorderSizePixel = 0
    AccentBar.Size = UDim2.new(0, 4, 1, 0)

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 4)
    AccentCorner.Parent = AccentBar

    -- Text label
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
    Label.TextTransparency = 1 -- start invisible

    -- Slide in: expand height
    local expandTween = TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 0, 36)
    })
    expandTween:Play()

    -- Fade in text
    task.delay(0.15, function()
        local fadeIn = TweenService:Create(Label, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            TextTransparency = 0
        })
        fadeIn:Play()
    end)

    -- Fade out and collapse after duration
    task.delay(duration, function()
        -- Fade out text
        local fadeOut = TweenService:Create(Label, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            TextTransparency = 1
        })
        fadeOut:Play()

        -- Fade accent
        local accentFade = TweenService:Create(AccentBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        accentFade:Play()

        -- Fade background
        local bgFade = TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        bgFade:Play()

        task.wait(0.3)

        -- Collapse height smoothly
        local collapse = TweenService:Create(Notif, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(1, 0, 0, 0)
        })
        collapse:Play()
        collapse.Completed:Wait()

        Notif:Destroy()
    end)

    return Notif
end

-- Make it globally accessible
getgenv().notify = notify

return notify
