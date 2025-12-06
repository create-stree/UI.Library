-- load library
local StreeHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/create-stree/STREE-HUB/main/UI.Libry"))()

-- Create window
local Window = StreeHub:CreateWindow({
    Title = "Stree Hub",
    SubTitle = "Premium Cheat Menu with Icons",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 500),
    Theme = "Dark",
    Acrylic = true
})

-- Add tabs
local MainTab = Window:AddTab("Main")
local VisualsTab = Window:AddTab("Visuals")
local MiscTab = Window:AddTab("Misc")

-- Add sections with icons
local CombatSection = MainTab:AddSection("Combat")
local MovementSection = MainTab:AddSection("Movement")

-- Add elements with icons
CombatSection:AddToggle({
    Title = "Aimbot",
    Description = "Auto aim at enemies",
    Default = false,
    Icon = "target",  -- Uses lucide-target
    Callback = function(value)
        print("Aimbot:", value)
    end
})

CombatSection:AddSlider({
    Title = "Aimbot FOV",
    Description = "Field of view for aimbot",
    Default = 50,
    Min = 1,
    Max = 360,
    Rounding = 0,
    Icon = "crosshair",  -- Uses lucide-crosshair
    Callback = function(value)
        print("FOV set to:", value)
    end
})

MovementSection:AddToggle({
    Title = "Speed Hack",
    Description = "Increase movement speed",
    Default = false,
    Icon = "zap",  -- Uses lucide-zap
    Callback = function(value)
        print("Speed Hack:", value)
    end
})

-- Button with icon
MiscTab:AddSection("Utilities"):AddButton({
    Title = "Open Image Viewer",
    Description = "View custom image",
    Icon = "image",  -- Uses lucide-image
    Callback = function()
        StreeHub:OpenImageWindow({
            ImageId = "113067683358494",
            Title = "Stree Hub - Logo",
            Size = UDim2.fromOffset(500, 400),
            Position = UDim2.new(0.5, -250, 0.5, -200)
        })
    end
})

-- Dropdown with icon
MiscTab:AddSection("Settings"):AddDropdown({
    Title = "Theme Selector",
    Description = "Choose UI theme",
    Values = {"Dark", "Light", "Darker", "Rose", "Aqua", "Amethyst"},
    Default = "Dark",
    Icon = "palette",  -- Uses lucide-palette
    Callback = function(value)
        StreeHub:SetTheme(value)
    end
})

-- Input with icon
MiscTab:AddSection("Config"):AddInput({
    Title = "Player Name",
    Description = "Enter target player name",
    Default = "",
    Placeholder = "Enter name...",
    Icon = "user",  -- Uses lucide-user
    Callback = function(value)
        print("Player name:", value)
    end
})

-- Paragraph with icon
MiscTab:AddSection("Info"):AddParagraph({
    Title = "Welcome to Stree Hub",
    Content = "This is a premium cheat menu with full icon support!",
    Icon = "info"  -- Uses lucide-info
})

-- Notifications with icons
task.spawn(function()
    task.wait(2)
    StreeHub:Notify({
        Title = "Stree Hub",
        Content = "Welcome to the menu!",
        SubContent = "Enjoy your experience",
        Icon = "party-popper",  -- Uses lucide-party-popper
        Duration = 5
    })
    
    task.wait(3)
    StreeHub:Notify({
        Title = "Icon Support",
        Content = "All Lucide icons available!",
        Icon = "check-circle",  -- Uses lucide-check-circle
        Duration = 5
    })
end)

-- Get icon asset ID
local iconId = StreeHub:GetIcon("activity")
print("Activity icon ID:", iconId)

-- Get all available icons
local allIcons = StreeHub:GetAvailableIcons()
print("Total icons available:", #allIcons)

-- Open icon preview
MiscTab:AddSection("Debug"):AddButton({
    Title = "Show Icon Preview",
    Description = "View all available icons",
    Icon = "eye",
    Callback = function()
        StreeHub:CreateIconPreview()
    end
})
