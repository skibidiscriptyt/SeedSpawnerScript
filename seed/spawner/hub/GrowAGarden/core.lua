--// Obfuscated-like variable names (still somewhat readable for editability)
local a = game:GetService("CoreGui")
local b = game:GetService("RunService")

-- Local data storage
local file = "SeedSpawnerInventory.json"
local inv = isfile(file) and game:GetService("HttpService"):JSONDecode(readfile(file)) or {}

-- Save inventory
local function save()
	writefile(file, game:GetService("HttpService"):JSONEncode(inv))
end

-- UI
local function main()
	local g = Instance.new("ScreenGui", a)
	g.Name = "SeedSpawnerGUI"

	local f = Instance.new("Frame", g)
	f.Size = UDim2.new(0, 300, 0, 150)
	f.Position = UDim2.new(0.5, -150, 0.5, -75)
	f.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	f.BorderSizePixel = 0
	f.Active = true
	f.Draggable = true

	local t = Instance.new("TextLabel", f)
	t.Size = UDim2.new(1, 0, 0, 30)
	t.BackgroundTransparency = 1
	t.Text = "FREE SEED HUB"
	t.TextColor3 = Color3.new(1, 1, 1)
	t.Font = Enum.Font.SourceSansBold
	t.TextScaled = true

	local s = Instance.new("TextBox", f)
	s.PlaceholderText = "Enter seed name"
	s.Size = UDim2.new(0.8, 0, 0, 30)
	s.Position = UDim2.new(0.1, 0, 0, 40)
	s.ClearTextOnFocus = false
	s.Text = ""

	local a = Instance.new("TextBox", f)
	a.PlaceholderText = "Enter amount"
	a.Size = UDim2.new(0.8, 0, 0, 30)
	a.Position = UDim2.new(0.1, 0, 0, 80)
	a.ClearTextOnFocus = false
	a.Text = ""

	local btn = Instance.new("TextButton", f)
	btn.Text = "GET"
	btn.Size = UDim2.new(0.4, 0, 0, 30)
	btn.Position = UDim2.new(0.3, 0, 0, 120)
	btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

	btn.MouseButton1Click:Connect(function()
		local seed = s.Text:lower()
		local amt = tonumber(a.Text)

		if seed == "" or not amt or amt <= 0 then
			warn("Enter a valid seed name and amount!")
			return
		end

		inv[seed] = (inv[seed] or 0) + amt
		save()

		print("Added " .. amt .. " " .. seed .. "(s) to inventory.")
	end)
end

-- Loading GUI
local l = Instance.new("ScreenGui", a)
l.Name = "SeedSpawnerLoader"

local f = Instance.new("Frame", l)
f.Size = UDim2.new(0, 400, 0, 100)
f.Position = UDim2.new(0.5, -200, 0.5, -50)
f.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
f.BorderSizePixel = 0

local lbl = Instance.new("TextLabel", f)
lbl.Size = UDim2.new(1, 0, 0.5, 0)
lbl.Position = UDim2.new(0, 0, 0, 0)
lbl.Text = "Loading... 0%"
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.BackgroundTransparency = 1
lbl.TextScaled = true

local bb = Instance.new("Frame", f)
bb.Size = UDim2.new(0.9, 0, 0.2, 0)
bb.Position = UDim2.new(0.05, 0, 0.7, 0)
bb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local pb = Instance.new("Frame", bb)
pb.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
pb.Size = UDim2.new(0, 0, 1, 0)

task.spawn(function()
	for i = 1, 100 do
		pb.Size = UDim2.new(i / 100, 0, 1, 0)
		lbl.Text = "Loading... " .. i .. "%"
		wait(0.3) -- 30 sec total
	end
	l:Destroy()
	main()
end)
