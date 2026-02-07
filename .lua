-- [[ Load UI ]]
local StreeHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/create-stree/UI.Library/refs/heads/main/StreeHub.lua"))()

-- [[ load Window ]]
local Window = StreeHub:Window({
    Title   = "StreeHub |",                --- title
    Footer  = "Example",                   --- in right after title
    Images  = "128806139932217",
    Color   = Color3.fromRGB(57, 255, 20),   --- default Hijau Neom Color3.fromRGB(57, 255, 20)
    Theme   = 122376116281975,                  ---- background for theme ui (rbxassetid) - optional
    ThemeTransparency = 0.15,              --- transparency of theme image - optional
    ["Tab Width"] = 120,                   --- width of tabs section - optional
    Version = 1,                           --- version config set as default 1 if u remake / rewrite / big update and change name name in your hub change it to 2 and config will reset
})

--- [[ Notify Function ]]
local function notify(msg, delay, color, title, desc)
    return StreeHub:MakeNotify({
        Title = title or "StreeHub",
        Description = desc or "Notification",
        Content = msg or "Content",
        Color = color or Color3.fromRGB(57, 255, 20),
        Delay = delay or 4
    })
end

--- [[ Or Use Like This ]]
-- StreeHub:MakeNotify({
--     Title = "StreeHub",
--     Description = "Notification",
--     Content = "Contoh notifikasi",
--     Color = Color3.fromRGB(255, 0, 0),
--     Delay = 4
-- })

--- [[ Make tabs ]]
local Tabs = {
    Info = Window:AddTab({ Name = "Info", Icon = "player" }), --- rbxassetid / robloxassetid (decals - texture)
    Main = Window:AddTab({ Name = "Main", Icon = "user" }),
    Settings = Window:AddTab({ Name = "Settings", Icon = "settings" }),
}

-- [[ Make A Section for tab ]]
local X1 = Tabs.Info:AddSection("StreeHub | Section") -- [[ X1 = for load elements section ]]
-- X1 = Tabs.Info:AddSection("StreeHub Section", false) set as default open after load UI
-- X1 = Tabs.Info:AddSection("StreeHub Section", true) set as default always open (cant closed section) after load UI

--- [[ Paragraph ]]
X1:AddParagraph({
    Title = "StreeHub | Community",
    Content = "StreeHub StreeHub StreeHub StreeHub",
    Icon = "star",
})

--- [[ Paragraph with button ]]
X1:AddParagraph({
    Title = "Join Our Discord",
    Content = "Join Us!",
    Icon = "discord",
    ButtonText = "Copy Discord Link",
    ButtonCallback = function()
        local link = "https://discord.gg/streehub"
        if setclipboard then
            setclipboard(link)
            notify("Successfully Copied!")
        end
    end
})

--- [[ Divider ]]
X1:AddDivider()

--- [[ Sub Section ]]
X1:AddSubSection("STREEHUB STREEHUB STREEHUB")

--- [[ Panel Section ]]
local PanelSection = Tabs.Main:AddSection("StreeHub | Panel")

--- [[ Panel with 2 button ]]
PanelSection:AddPanel({
    Title = "StreeHub | Discord",
    -- Content = "Sub Title", --- can use sub title here (optional)
    ButtonText = "Copy Discord Link",
    ButtonCallback = function()
        if setclipboard then
            setclipboard("https://discord.gg/streehub")
            notify("Link Discord telah disalin ke clipboard.")
        else
            notify("Executor tidak mendukung setclipboard.")
        end
    end,
    SubButtonText = "Open Discord",
    SubButtonCallback = function()
        notify("Membuka link Discord...")
        task.spawn(function()
            game:GetService("GuiService"):OpenBrowserWindow("https://discord.gg/streehub")
        end)
    end
})

-- [[ Panel with 1 Button + 1 Input ]]
PanelSection:AddPanel({
    Title = "StreeHub | Utility",
    Placeholder = "Enter text here...",
    ButtonText = "Rejoin Server",
    ButtonCallback = function(inputText)
        notify("Rejoining server... Input was: " .. inputText)
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- [[ Panel with 2 Button + 1 Input ]]
PanelSection:AddPanel({
    Title = "StreeHub | Webhook",
    Placeholder = "https://discord.com/api/webhooks/...",
    ButtonText = "Simpan Webhook",
    ButtonCallback = function(url)
        if url == "" then
            notify("Mohon isi URL webhook terlebih dahulu.")
            return
        end
        _G.StreeHubWebhook = url
        ConfigData.WebhookURL = url
        SaveConfig()
        notify("Webhook telah disimpan.")
    end,
    SubButtonText = "Test Webhook",
    SubButtonCallback = function(url)
        if not _G.StreeHubWebhook or _G.StreeHubWebhook == "" then
            notify("Webhook belum diset.")
            return
        end
        notify("Mengirim test webhook...")
        task.spawn(function()
            local HttpService = game:GetService("HttpService")
            local data = { content = "Test webhook dari StreeHub." }
            pcall(function()
                HttpService:PostAsync(_G.StreeHubWebhook, HttpService:JSONEncode(data))
            end)
        end)
    end
})

-- [[ Button Section ]]
local BtnSection = Tabs.Main:AddSection("StreeHub | Button")

-- [[ Single Button ]]
BtnSection:AddButton({
    Title = "Open Discord",
    Callback = function()
        notify("Membuka Discord...")
        task.spawn(function()
            game:GetService("GuiService"):OpenBrowserWindow("https://discord.gg/streehub")
        end)
    end
})

-- [[ Double Button ]]
BtnSection:AddButton({
    Title = "Rejoin",
    SubTitle = "Server Hop",
    Callback = function()
        notify("Rejoining server...")
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
    SubCallback = function()
        notify("Mencari server baru...")
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Servers = Http:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" ..
            game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, v in pairs(Servers.data) do
            if v.playing < v.maxPlayers then
                TPS:TeleportToPlaceInstance(game.PlaceId, v.id, game.Players.LocalPlayer)
                return
            end
        end
        notify("Tidak ada server kosong ditemukan.")
    end
})

-- [[ Toggle Section ]]
local ToggleSection = Tabs.Main:AddSection("StreeHub | Toggle")

-- [[ Single Toggle ]]
local AutoFishToggle = ToggleSection:AddToggle({
    Title = "Auto Fishing",
    Content = "Aktifkan auto fishing menggunakan StreeHub System.",
    Default = false,
    Callback = function(state)
        if state then
            notify("Auto Fishing diaktifkan.")
            _G.AutoFish = true
        else
            notify("Auto Fishing dimatikan.")
            _G.AutoFish = false
        end
    end
})

-- [[ Toggle with Sub Title ]]
local AutoSellToggle = ToggleSection:AddToggle({
    Title = "Auto Sell",
    Title2 = "Sell All Fish Automatically",
    Content = "Menjual semua ikan setelah menangkapnya.",
    Default = false,
    Callback = function(state)
        if state then
            notify("Auto Sell aktif.")
            _G.AutoSell = true
        else
            notify("Auto Sell nonaktif.")
            _G.AutoSell = false
        end
    end
})

-- [[ Slider Section ]]
local SliderSection = Tabs.Main:AddSection("StreeHub | Slider")

-- [[ Slider for Fishing Delay ]]
local DelaySlider = SliderSection:AddSlider({
    Title = "Fishing Delay",
    Content = "Atur jeda waktu auto fishing.",
    Min = 0.1,
    Max = 5,
    Increment = 0.1,
    Default = 1,
    Callback = function(value)
        _G.Delay = value
        notify("Delay diset ke: " .. tostring(value) .. " detik.")
    end
})

-- [[ Slider for Volume Control ]]
local VolumeSlider = SliderSection:AddSlider({
    Title = "Sound Volume",
    Content = "Sesuaikan volume efek suara StreeHub.",
    Min = 0,
    Max = 100,
    Increment = 5,
    Default = 50,
    Callback = function(value)
        notify("Volume diubah ke: " .. tostring(value) .. "%")
    end
})

-- [[ Slider for Animation Speed ]]
local AnimSpeedSlider = SliderSection:AddSlider({
    Title = "Animation Speed",
    Content = "Atur kecepatan animasi antarmuka StreeHub.",
    Min = 0.5,
    Max = 2,
    Increment = 0.1,
    Default = 1,
    Callback = function(value)
        _G.AnimationSpeed = value
        notify("Kecepatan animasi diset ke: " .. tostring(value) .. "x")
    end
})

-- [[ Input Section ]]
local InputSection = Tabs.Main:AddSection("StreeHub | Input")

-- [[ Input ]]
local UsernameInput = InputSection:AddInput({
    Title = "Username",
    Content = "Masukkan nama pengguna kamu untuk disimpan di konfigurasi.",
    Default = "",
    Callback = function(value)
        _G.StreeHubUsername = value
        notify("Username diset ke: " .. value)
    end
})

-- [[ Dropdown Section ]]
local DropdownSection = Tabs.Main:AddSection("StreeHub | Dropdown")

-- [[ Basic Dropdown ]]
local ThemeDropdown = DropdownSection:AddDropdown({
    Title = "Select Theme",
    Content = "Pilih tema antarmuka untuk StreeHub.",
    Options = { "Celestial", "Seraphin", "Nebula", "Luna" },
    Default = "Celestial",
    Callback = function(value)
        _G.SelectedTheme = value
        notify("Tema diubah ke: " .. value)
    end
})

-- [[ Multi Select Dropdown ]]
local FeaturesDropdown = DropdownSection:AddDropdown({
    Title = "Select Features",
    Content = "Pilih beberapa fitur StreeHub yang ingin diaktifkan.",
    Multi = true,
    Options = { "Auto Fishing", "Auto Sell", "Auto Quest", "Webhook Notification" },
    Default = { "Auto Fishing" },
    Callback = function(selected)
        _G.ActiveFeatures = selected
        notify("Fitur aktif: " .. table.concat(selected, ", "))
    end
})

-- [[ Dynamic Dropdown ]]
local DynamicDropdown = DropdownSection:AddDropdown({
    Title = "Select Bait",
    Content = "Pilih umpan yang akan digunakan.",
    Options = {},
    Default = nil,
    Callback = function(value)
        _G.SelectedBait = value
        notify("Umpan dipilih: " .. value)
    end
})

--- refresh value dropdown use SetValues
task.spawn(function()
    task.wait(1)
    local baitList = { "Common Bait", "Rare Bait", "Mythic Bait", "Divine Bait" }
    DynamicDropdown:SetValues(baitList, "Common Bait")
end)

-- [[ Settings Section ]]
local SettingsSection = Tabs.Settings:AddSection("StreeHub | Settings", true) -- Always open

-- [[ Toggle for UI Settings ]]
SettingsSection:AddToggle({
    Title = "Show Button",
    Content = "Tampilkan tombol StreeHub di layar.",
    Default = true,
    Callback = function(state)
        local button = game:GetService("CoreGui"):FindFirstChild("StreeHubButton")
        if button then
            button.Enabled = state
            notify("Button visibility: " .. (state and "ON" or "OFF"))
        end
    end
})

-- [[ Button to Reset Config ]]
SettingsSection:AddButton({
    Title = "Reset Configuration",
    Callback = function()
        local configPath = "StreeHub/Config/StreeHub_" .. gameName .. ".json"
        if isfile and isfile(configPath) then
            delfile(configPath)
            notify("Configuration has been reset!")
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        else
            notify("No configuration file found!")
        end
    end
})

-- [[ Button to Destroy GUI ]]
SettingsSection:AddButton({
    Title = "Destroy GUI",
    Callback = function()
        Window:DestroyGui()
        notify("GUI has been destroyed!")
    end
})

-- [[ Panel to Change UI Color ]]
SettingsSection:AddPanel({
    Title = "UI Color",
    Placeholder = "255,0,0",
    ButtonText = "Apply Color",
    ButtonCallback = function(colorText)
        local r, g, b = colorText:match("(%d+),%s*(%d+),%s*(%d+)")
        if r and g and b then
            local color = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
            notify("UI Color changed to RGB(" .. r .. "," .. g .. "," .. b .. ")")
            -- Note: Changing UI color dynamically would require modifying the UI elements directly
        else
            notify("Invalid color format! Use: R,G,B (e.g., 255,0,0)")
        end
    end,
    SubButtonText = "Reset Color",
    SubButtonCallback = function()
        notify("UI Color reset to default (Red)")
    end
})

-- [[ Initial Notification ]]
if Window then
    notify("StreeHub loaded successfully!", 3, Color3.fromRGB(0, 255, 0), "StreeHub", "Success")
end

-- [[ Auto Save Config on Leave ]]
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    SaveConfig()
end)

game:BindToClose(function()
    SaveConfig()
end)

-- [[ Config Auto Load ]]
-- This library is auto save / load all element without any additional code
-- If you got bug in saved config, use SaveConfig() manually
