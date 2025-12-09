local Library = {}
Library.__index = Library

function Library:CreateWindow(config)
    local Window = require(script.core.window)
    return Window.new(config)
end

return Library
