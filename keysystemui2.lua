--// Welcome! this is actually for devs and not exploiters but i'll let it pass. :D
--// Creating object for the ui.
local function Create(className, properties, children)
	local object = Instance.new(className)
	for property, value in pairs(properties or {}) do
		object[property] = value
	end
	for _, child in pairs(children or {}) do
		child.Parent = object
	end
	return object
end

local screenGui = Create("ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = game.CoreGui })
local blurEffect = Create("BlurEffect", { Size = 25, Parent = game.Lighting })

local function CreateRoundedFrame(properties, cornerRadius, children)
	return Create("Frame", properties, {
		Create("UICorner", { CornerRadius = UDim.new(0, cornerRadius) }),
		unpack(children or {}),
	})
end

local keyUi = CreateRoundedFrame({
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(0, 460, 0, 320),
	Parent = screenGui,
}, 4, {
	Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(0, 150, 100),
		Thickness = 2,
	}),
})

-- Make the UI draggable
--// set keyUi.Draggable to false if you dont want dragging.
keyUi.Active = true
keyUi.Draggable = true

Create("TextLabel", {
	Text = "Your Title Here", -- Your script title here.
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 18,
	BackgroundTransparency = 1,
	Position = UDim2.new(0.5, -100, 0.1, 0),
	Size = UDim2.new(0, 200, 0, 40),
	Parent = keyUi,
})

Create("TextLabel", {
	Text = "Your Label Here", -- Very nice label for info.
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(178, 178, 178),
	TextSize = 14,
	BackgroundTransparency = 1,
	Position = UDim2.new(0.5, -100, 0.2, 0),
	Size = UDim2.new(0, 200, 0, 40),
	Parent = keyUi,
})

--// The keysystem here needs to be accurate. (PLS MAKE UR OWN KEY NOT THE EXAMPLE BELOW.)
local correctKey = "secretKey123" 
local keyInput = Create("TextBox", {
	Font = Enum.Font.Gotham,
	PlaceholderText = "Enter your key...",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundColor3 = Color3.fromRGB(55, 55, 55),
	Size = UDim2.new(1, -30, 0, 40),
	Position = UDim2.new(0, 15, 0.3, 0),
	Parent = keyUi,
}, {
	Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
	Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(0, 150, 100),
		Thickness = 2,
	}),
})

local function GetKey() --// use dc or any external web or app for this.
	setclipboard("put ur url")
	print("Key URL copied to clipboard.")
end

local function ExecuteScript()
	local scriptToExecute = function()
		print("Script executed successfully.")
	end
	scriptToExecute()
end

local function Continue()
	local userInput = keyInput.Text
	if userInput == correctKey then
		blurEffect:Destroy()
		keyUi:TweenPosition(UDim2.new(0.5, 0, 0, -400), "Out", "Quad", 0.5, true)
		wait(0.5)
		keyUi:Destroy()
		ExecuteScript()
	else
		local notifyLabel = Create("TextLabel", {
			Text = "Incorrect key. Please try again.",
			Font = Enum.Font.Gotham,
			TextColor3 = Color3.fromRGB(255, 0, 0),
			TextSize = 14,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, -150, 0.7, 0),
			Size = UDim2.new(0, 300, 0, 30),
			Parent = keyUi,
		})
		notifyLabel.TextTransparency = 0
		notifyLabel:TweenPosition(UDim2.new(0.5, -150, 0.65, 0), "Out", "Quad", 0.5, true)
		for i = 0, 1, 0.1 do
			wait(0.05)
			notifyLabel.TextTransparency = i
		end
		notifyLabel:Destroy()
	end
end

local function CreateStyledButton(text, position, onClick)
	local button = CreateRoundedFrame({
		BackgroundColor3 = Color3.fromRGB(55, 55, 55),
		Size = UDim2.new(0, 120, 0, 30),
		Position = position,
	}, 6)

	local textButton = Create("TextButton", {
		Text = text,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		AutoButtonColor = false,
		Parent = button
	})

	Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(0, 150, 100),
		Thickness = 2,
		Parent = button
	})

	textButton.MouseButton1Click:Connect(onClick)
	button.Parent = keyUi
end

CreateStyledButton("Get Key", UDim2.new(0.5, -130, 0.5, 0), GetKey)
CreateStyledButton("Enter Key", UDim2.new(0.5, 10, 0.5, 0), Continue)

local closeButton = Create("TextButton", {
	Text = "X",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(0, 150, 100),
	TextSize = 20,
	BackgroundTransparency = 1,
	Position = UDim2.new(0.95, -20, 0.05, 0),
	Size = UDim2.new(0, 30, 0, 30),
	Parent = keyUi,
})

closeButton.MouseButton1Click:Connect(function()
	blurEffect:Destroy()
	keyUi:TweenPosition(UDim2.new(0.5, 0, 0, -400), "Out", "Quad", 0.5, true)
	wait(0.5)
	keyUi:Destroy()
end)

Create("UIStroke", {
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	Color = Color3.fromRGB(0, 150, 100),
	Thickness = 2,
	Parent = closeButton
})
