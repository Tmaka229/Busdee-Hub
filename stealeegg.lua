-- STEAL EGG HUB
-- สำหรับเกม Roblox ของคุณเอง

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- =========================
-- CONFIG
-- =========================

local Eggs = {
    {Name = "Egg A", Price = 500, Weight = 2.5},
    {Name = "Egg B", Price = 350, Weight = 1.8},
    {Name = "Egg C", Price = 100, Weight = 20.9},
}

-- เรียงราคามาก -> น้อย
table.sort(Eggs, function(a, b)
    return a.Price > b.Price
end)

-- =========================
-- GUI
-- =========================

local gui = Instance.new("ScreenGui")
gui.Name = "StealEggHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(350, 430)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Text = "🥚 STEAL EGG HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.Parent = main

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -20, 0, 250)
list.Position = UDim2.fromOffset(10, 65)
list.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
list.BorderSizePixel = 0
list.ScrollBarThickness = 5
list.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local selected = nil
local running = false

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 35)
status.Position = UDim2.fromOffset(10, 320)
status.BackgroundTransparency = 1
status.Text = "Selected: None"
status.TextColor3 = Color3.new(1, 1, 1)
status.TextSize = 17
status.Font = Enum.Font.Gotham
status.Parent = main

-- =========================
-- EGG LIST
-- =========================

for _, egg in ipairs(Eggs) do

    local button = Instance.new("TextButton")

    button.Size = UDim2.new(1, -10, 0, 55)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 16
    button.Font = Enum.Font.GothamMedium

    button.Text = string.format(
        "🥚 %s    $%d    %.1f kg",
        egg.Name,
        egg.Price,
        egg.Weight
    )

    button.Parent = list

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    button.MouseButton1Click:Connect(function()

        selected = egg

        status.Text = string.format(
            "Selected: %s | $%d | %.1f kg",
            egg.Name,
            egg.Price,
            egg.Weight
        )

    end)
end

-- =========================
-- GO
-- =========================

local go = Instance.new("TextButton")
go.Size = UDim2.fromOffset(145, 45)
go.Position = UDim2.fromOffset(10, 370)
go.BackgroundColor3 = Color3.fromRGB(45, 170, 80)
go.Text = "🟢 GO"
go.TextColor3 = Color3.new(1, 1, 1)
go.TextSize = 18
go.Font = Enum.Font.GothamBold
go.Parent = main

local goCorner = Instance.new("UICorner")
goCorner.CornerRadius = UDim.new(0, 8)
goCorner.Parent = go

go.MouseButton1Click:Connect(function()

    if not selected then
        status.Text = "กรุณาเลือกไข่ก่อน"
        return
    end

    running = true

    status.Text = "Running: " .. selected.Name

    -- ต
