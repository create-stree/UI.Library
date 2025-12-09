local Toggle = {}

function Toggle.new(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 32)
    Btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 36)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.TextColor3 = Color3.fromRGB(0, 255, 0)

    local state = false
    Btn.Text = text .. " [OFF]"

    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = text .. (state and " [ON]" or " [OFF]")
        callback(state)
    end)
end

return Toggle
