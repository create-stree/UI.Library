local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/create-stree/UI.Library/refs/heads/main/Source.lua"))()

local Window = Library:MakeGui({
    NameHub = "Stree Hub | UI Library",
    Color = Color3.fromRGB(0, 170, 0)
})

local Tab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://139262888943265"
})

local Section = Tab:AddSection("Main Features")

Section:AddParagraph({
    Title = "Information",
    Content = "This is a paragraph."
})

Section:AddButton({
    Title = "Click Me",
    Content = "Runs a function",
    Callback = function()
        print("Button clicked")
    end
})

Section:AddToggle({
    Title = "Toggle Option",
    Content = "Enable or disable",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

Section:AddSlider({
    Title = "WalkSpeed",
    Content = "Adjust your speed",
    Min = 10,
    Max = 50,
    Default = 16,
    Callback = function(value)
        print("Slider:", value)
    end
})

Section:AddInput({
    Title = "Enter Text",
    Content = "Type something",
    Placeholder = "Write here...",
    Callback = function(text)
        print("Text:", text)
    end
})

Section:AddDropdown({
    Title = "Select Mode",
    Content = "Choose an option",
    Multi = false,
    Options = {"Easy", "Medium", "Hard"},
    Default = {},
    Callback = function(selected)
        print("Selected:", selected)
    end
})

Library:MakeNotify({
    Title = "Notification",
    Description = "Alert",
    Content = "This is a message",
    Color = Color3.fromRGB(0, 170, 0),
    Delay = 3
})
