pcall(function()
    getgenv().blackFigure:Disconnect()
    getgenv().blackFigure = nil
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Animator = Character:FindFirstChildWhichIsA("Animator", true)

-- right = 10480793962
-- left = 10480796021
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://10480796021"

local AnimationTrack = Animator:LoadAnimation(Animation)

getgenv().blackFigure = RunService.RenderStepped:Connect(function()
    AnimationTrack:Play(0.1, 1, 0) -- last parameter = speed
end)
