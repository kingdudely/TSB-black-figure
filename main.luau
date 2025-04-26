pcall(function()
    getgenv().blackFigure:Disconnect()
    getgenv().blackFigure = nil
end)

local settings = {
    key = "q",
    speed = 0,
    animations = {
        left = "10480796021",
        right = "10480793962",
    },
    easing = {
        Enum.EasingStyle.Cubic,
        Enum.EasingDirection.Out,
    },
}

local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local HumanoidRootPart = Humanoid.RootPart
local Animator = Humanoid:FindFirstChildWhichIsA("Animator")

local function playAnimation(id, speed)
    local animation = Instance.new("Animation")
    animation.AnimationId = id:match("rbxassetid://") and id or `rbxassetid://{id}`

    local loaded = Animator:LoadAnimation(animation)
    loaded:Play(0.1, 1, speed or 1)

    return loaded
end

local animationLoop

getgenv().blackFigure = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode[settings.key:upper()] then
            local moveDirection = Humanoid.MoveDirection
            local cameraCFrame = CurrentCamera.CFrame
            local sideMovement = moveDirection:Dot(cameraCFrame.RightVector)

            if math.abs(sideMovement) >= 0.5 then
                if animationLoop then
                    animationLoop:Disconnect()
                    animationLoop = nil
                end

                local direction = math.sign(sideMovement)
                animationLoop = game:GetService("RunService").Heartbeat:Connect(function()
                    playAnimation(direction == -1 and settings.animations.left or settings.animations.right, settings.speed)
                end)
            end
        end
    end
end)
