local Window = {}
Window.__index = Window

function Window.new(config)
    local self = setmetatable({}, Window)

    local Screen = Instance.new("ScreenGui", game.CoreGui)
    Screen.ResetOnSpawn = false

    local Main = Instance.new("Frame", Screen)
    Main.Size = config.Size or UDim2.new(0, 480, 0, 300)
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -240, 0.5, -150)

    -- Neon border
    local UIStroke = Instance.new("UIStroke", Main)
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(0, 255, 0)
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Glow (Frame)
    local Glow = Instance.new("ImageLabel", Main)
    Glow.Image = "rbxassetid://5028857084"
    Glow.Size = UDim2.new(1, 40, 1, 40)
    Glow.Position = UDim2.new(0, -20, 0, -20)
    Glow.ImageColor3 = Color3.fromRGB(0, 255, 0)
    Glow.BackgroundTransparency = 1
    Glow.ImageTransparency = 0.6

    -- Dragging
    local UIS = game:GetService("UserInputService")
    local dragging = false
    local dragPos

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragPos = input.Position
        end
    end)

    Main.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragPos
            Main.Position = UDim2.new(0, Main.Position.X.Offset + delta.X, 0, Main.Position.Y.Offset + delta.Y)
            dragPos = input.Position
        end
    end)

    self.Screen = Screen
    self.Main = Main
    self.Tabs = {}

    function self:CreateTab(name)
        local Tab = require(script.Parent.tab)
        local newTab = Tab.new(self.Main, name)
        table.insert(self.Tabs, newTab)
        return newTab
    end

    return self
end

return Window
