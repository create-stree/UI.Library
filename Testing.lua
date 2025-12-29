-- Simpan script ini sebagai contoh penggunaannya
local Stree = loadstring(game:HttpGet("https://raw.githubusercontent.com/create-stree/UI.Library/refs/heads/main/Example.txt"))()

-- Membuat Window GUI
local Window = Stree:Window({
    Title = "Stree Library Example",
    Footer = "v2.0",
    Color = Color3.fromRGB(0, 255, 0), -- Hijau neon
    ["Tab Width"] = 130,
    Version = 1.0,
    Image = "9542022979" -- ID gambar untuk toggle button
})

-- Tab 1: Main Features
local MainTab = Window:AddTab({
    Name = "Main",
    Icon = "player"
})

local MainSection = MainTab:AddSection("Main Features", true)

-- Toggle Button
local ToggleFeature = MainSection:AddToggle({
    Title = "Auto Farm",
    Title2 = "Automatically farm resources",
    Content = "Turn this on to automatically collect resources in the game",
    Default = false,
    Callback = function(value)
        print("Auto Farm:", value)
        if value then
            -- Mulai auto farm
            Stree:MakeNotify({
                Title = "Stree Library",
                Description = "Auto Farm",
                Content = "Auto Farm has been enabled!",
                Color = Color3.fromRGB(0, 255, 0),
                Delay = 3
            })
        else
            -- Stop auto farm
            Stree:MakeNotify({
                Title = "Stree Library",
                Description = "Auto Farm",
                Content = "Auto Farm has been disabled!",
                Color = Color3.fromRGB(255, 100, 100),
                Delay = 3
            })
        end
    end
})

-- Slider
local WalkSpeedSlider = MainSection:AddSlider({
    Title = "Walk Speed",
    Content = "Adjust your character's walk speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
        print("Walk Speed set to:", value)
    end
})

-- Input Field
local TeleportInput = MainSection:AddInput({
    Title = "Teleport to Player",
    Content = "Enter a player name to teleport to",
    Default = "",
    Callback = function(value)
        local targetPlayer = game.Players:FindFirstChild(value)
        if targetPlayer and targetPlayer.Character then
            game.Players.LocalPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
            Notify("Teleported to " .. value, 3)
        else
            Notify("Player not found: " .. value, 3, Color3.fromRGB(255, 100, 100))
        end
    end
})

-- Divider
MainSection:AddDivider()

-- Button
MainSection:AddButton({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end,
    SubTitle = "Server Hop",
    SubCallback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})

-- Tab 2: Settings
local SettingsTab = Window:AddTab({
    Name = "Settings",
    Icon = "settings"
})

local ConfigSection = SettingsTab:AddSection("Configuration", true)

-- Dropdown Single Selection
local ThemeDropdown = ConfigSection:AddDropdown({
    Title = "UI Theme",
    Content = "Select a theme for the UI",
    Options = {"Dark", "Light", "Neon", "Transparent"},
    Default = "Dark",
    Callback = function(value)
        print("Theme selected:", value)
        Notify("Theme changed to: " .. value, 3)
    end
})

-- Dropdown Multi Selection
local FeaturesDropdown = ConfigSection:AddDropdown({
    Title = "Enabled Features",
    Content = "Select multiple features to enable",
    Multi = true,
    Options = {"ESP", "Aimbot", "Auto Click", "No Clip", "Fly"},
    Default = {"ESP", "Auto Click"},
    Callback = function(values)
        print("Enabled features:")
        for _, v in ipairs(values) do
            print("  - " .. v)
        end
    end
})

-- Panel dengan input
local KeybindPanel = ConfigSection:AddPanel({
    Title = "Keybind Settings",
    Content = "Set your custom keybinds",
    Placeholder = "Enter key (e.g., 'F', 'G', 'H')",
    Default = "F",
    Button = "Save Keybind",
    Callback = function(input)
        Notify("Keybind saved: " .. input, 3)
        print("Keybind set to:", input)
    end,
    SubButton = "Reset",
    SubCallback = function()
        Notify("Keybind reset to default", 3)
    end
})

-- Tab 3: Information
local InfoTab = Window:AddTab({
    Name = "Info",
    Icon = "info"
})

local AboutSection = InfoTab:AddSection("About", false)
local HelpSection = InfoTab:AddSection("Help", false)

-- Paragraph dengan icon
local AboutParagraph = AboutSection:AddParagraph({
    Title = "Stree Library",
    Content = "A powerful Roblox UI library with green neon theme. Created for easy script development.",
    Icon = "star"
})

-- Button di dalam paragraph
AboutSection:AddParagraph({
    Title = "Discord Server",
    Content = "Join our Discord community for updates and support!",
    Icon = "discord",
    ButtonText = "Join Discord",
    ButtonCallback = function()
        setclipboard("https://discord.gg/stree")
        Notify("Discord link copied to clipboard!", 3)
    end
})

-- Sub Section
HelpSection:AddSubSection("How to Use")

-- Multiple paragraphs
HelpSection:AddParagraph({
    Title = "Toggle Features",
    Content = "Click on toggle buttons to enable/disable features. Settings are automatically saved."
})

HelpSection:AddParagraph({
    Title = "Sliders",
    Content = "Drag the slider circle or click on the slider bar to adjust values. You can also type numbers in the input box."
})

HelpSection:AddParagraph({
    Title = "Dropdowns",
    Content = "Click on dropdown to open selection menu. For multi-select dropdowns, you can choose multiple options."
})

-- Tab 4: Farming
local FarmTab = Window:AddTab({
    Name = "Farming",
    Icon = "sword"
})

local AutoFarmSection = FarmTab:AddSection("Auto Farm Settings", true)

-- Multiple toggles
local AutoCollectToggle = AutoFarmSection:AddToggle({
    Title = "Auto Collect",
    Content = "Automatically collect items around you",
    Default = true,
    Callback = function(value)
        print("Auto Collect:", value)
    end
})

local AutoSellToggle = AutoFarmSection:AddSection("Auto Sell", true)

AutoSellToggle:AddToggle({
    Title = "Auto Sell Items",
    Content = "Automatically sell collected items",
    Default = false,
    Callback = function(value)
        print("Auto Sell:", value)
    end
})

AutoSellToggle:AddSlider({
    Title = "Sell Delay",
    Content = "Delay between each sell action (seconds)",
    Min = 1,
    Max = 60,
    Default = 5,
    Increment = 1,
    Callback = function(value)
        print("Sell Delay:", value)
    end
})

-- Tab 5: Player
local PlayerTab = Window:AddTab({
    Name = "Player",
    Icon = "user"
})

local CharacterSection = PlayerTab:AddSection("Character Mods", true)

-- Jump Power slider
CharacterSection:AddSlider({
    Title = "Jump Power",
    Content = "Adjust your character's jump power",
    Min = 50,
    Max = 500,
    Default = 50,
    Increment = 10,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
        print("Jump Power:", value)
    end
})

-- Hip Height slider
CharacterSection:AddSlider({
    Title = "Hip Height",
    Content = "Adjust your character's hip height",
    Min = 0,
    Max = 100,
    Default = 0,
    Increment = 1,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.HipHeight = value
        end
        print("Hip Height:", value)
    end
})

-- Load saved configurations
LoadConfigElements()

-- Contoh penggunaan notifikasi
spawn(function()
    wait(2)
    Notify("Welcome to Stree Library!", 5)
    
    wait(3)
    Notify("UI Loaded Successfully", 4, Color3.fromRGB(0, 255, 0), "Stree Library", "Ready")
    
    wait(5)
    Notify("Remember to save your settings!", 6, Color3.fromRGB(255, 200, 0), "Reminder", "Settings")
end)

-- Contoh mengupdate dropdown setelah beberapa waktu
wait(10)
ThemeDropdown:AddOption("Midnight")
ThemeDropdown:AddOption("Sunset")
ThemeDropdown:AddOption("Ocean")

FeaturesDropdown:AddOption("Speed Hack")
FeaturesDropdown:AddOption("Infinite Jump")

-- Contoh mengupdate paragraph
wait(15)
AboutParagraph:SetContent("Stree Library v2.0 - Updated with new features and improvements! More customization options available.")

print("Stree Library Example Loaded!")
    Description = "View all available icons",
    Icon = "eye",
    Callback = function()
        StreeHub:CreateIconPreview()
    end
})
