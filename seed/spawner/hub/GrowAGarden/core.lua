--// Services
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

--// Function to load the main Seed Spawner GUI
local function loadMainGUI()
    -- Create main GUI
    local mainGui = Instance.new("ScreenGui", CoreGui)
    mainGui.Name = "SeedSpawnerGUI"

    local frame = Instance.new("Frame", mainGui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true

    -- Title label
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "FREE SEED HUB"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextScaled = true

    -- Seed name input box
    local seedInput = Instance.new("TextBox", frame)
    seedInput.PlaceholderText = "Enter seed name"
    seedInput.Size = UDim2.new(0.8, 0, 0, 30)
    seedInput.Position = UDim2.new(0.1, 0, 0, 40)
    seedInput.ClearTextOnFocus = false
    seedInput.Text = ""

    -- Amount input box
    local amountInput = Instance.new("TextBox", frame)
    amountInput.PlaceholderText = "Enter amount"
    amountInput.Size = UDim2.new(0.8, 0, 0, 30)
    amountInput.Position = UDim2.new(0.1, 0, 0, 80)
    amountInput.ClearTextOnFocus = false
    amountInput.Text = ""

    -- Get button
    local getButton = Instance.new("TextButton", frame)
    getButton.Text = "GET"
    getButton.Size = UDim2.new(0.4, 0, 0, 30)
    getButton.Position = UDim2.new(0.3, 0, 0, 120)
    getButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

    -- Rainbow label
    local rainbowLabel = Instance.new("TextLabel", frame)
    rainbowLabel.Size = UDim2.new(1, 0, 0, 20)
    rainbowLabel.Position = UDim2.new(0, 0, 1, -20)
    rainbowLabel.BackgroundTransparency = 1
    rainbowLabel.Text = "MADE BY: @SkibidiScript"
    rainbowLabel.Font = Enum.Font.SourceSansBold
    rainbowLabel.TextScaled = true

    -- Rainbow text effect variables
    local hue = 0

    -- Rainbow text update loop
    RunService.Heartbeat:Connect(function()
        hue = (hue + 1) % 360
        local color = Color3.fromHSV(hue / 360, 1, 1)
        rainbowLabel.TextColor3 = color
    end)

    -- Seed inventory table (you'll want to save/load this properly in your real script)
    local seedInventory = {}

    -- Add seeds when GET button is clicked
    getButton.MouseButton1Click:Connect(function()
        local seedName = seedInput.Text:lower()
        local amount = tonumber(amountInput.Text)

        if seedName == "" or not amount or amount <= 0 then
            warn("Please enter a valid seed name and amount!")
            return
        end

        -- Add seeds to inventory (persistent saving/loading not included here)
        seedInventory[seedName] = (seedInventory[seedName] or 0) + amount

        print("Added " .. amount .. " " .. seedName .. " seed(s) to inventory.")
        -- Here you would also fire server event or save data to persist inventory
    end)
end

--// Loading GUI Setup
local loadingScreen = Instance.new("ScreenGui", CoreGui)
loadingScreen.Name = "SeedSpawnerLoader"

local frame = Instance.new("Frame", loadingScreen)
frame.Size = UDim2.new(0, 400, 0, 100)
frame.Position = UDim2.new(0.5, -200, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.BorderSizePixel = 0

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0.5, 0)
label.Position = UDim2.new(0, 0, 0, 0)
label.Text = "Loading... 0%"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.TextScaled = true

local barBackground = Instance.new("Frame", frame)
barBackground.Size = UDim2.new(0.9, 0, 0.2, 0)
barBackground.Position = UDim2.new(0.05, 0, 0.7, 0)
barBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local progressBar = Instance.new("Frame", barBackground)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
progressBar.Size = UDim2.new(0, 0, 1, 0)

-- Animate the loading bar for 30 seconds (0.3 seconds per 1%)
task.spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		label.Text = "Loading... " .. i .. "%"
		wait(0.3)
	end

	-- Remove loading screen and load actual GUI
	loadingScreen:Destroy()
	loadMainGUI()
end)
