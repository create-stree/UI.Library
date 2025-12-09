local Tab = {}
Tab.__index = Tab

function Tab.new(root, name)
    local self = setmetatable({}, Tab)

    local Button = Instance.new("TextButton", root)
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Button.TextColor3 = Color3.fromRGB(0, 255, 0)
    Button.Text = name

    local Frame = Instance.new("Frame", root)
    Frame.Size = UDim2.new(1, -110, 1, -40)
    Frame.Position = UDim2.new(0, 110, 0, 40)
    Frame.BackgroundTransparency = 1
    Frame.Visible = false

    Button.MouseButton1Click:Connect(function()
        for _, v in pairs(root:GetChildren()) do
            if v:IsA("Frame") and v ~= Frame then
                v.Visible = false
            end
        end
        Frame.Visible = true
    end)

    self.Frame = Frame

    function self:Button(text, callback)
        local ButtonEl = require(script.Parent.elements.button)
        ButtonEl.new(self.Frame, text, callback)
    end

    function self:Toggle(text, callback)
        local ToggleEl = require(script.Parent.elements.toggle)
        ToggleEl.new(self.Frame, text, callback)
    end

    function self:Slider(text, min, max, callback)
        local SliderEl = require(script.Parent.elements.slider)
        SliderEl.new(self.Frame, text, min, max, callback)
    end

    return self
end

return Tab
