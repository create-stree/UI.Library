local Button = {}

function Button.new(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 32)
    Btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 36)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.TextColor3 = Color3.fromRGB(0, 255, 0)
    Btn.Text = text

    Btn.MouseButton1Click:Connect(callback)
end

return Button
