-- ========================================
-- VinScript Key System
-- Author: Vinomin
-- Version: 1.0
-- ========================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Alternative keys configuration
local FAKE_KEYS = {
    "fake_key_test123456",
    "demo_key_abcdefgh",
    "trial_key_xyz98765",
    "temp_key_qwerty123"
}

local CONFIG = {
    api_url = "https://api.vinscript.dev",
    version = "2.6",
    build = 4521
}

local VALID_KEYS

-- Authentication tokens
local AUTH_TOKENS = {
    token1 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
    token2 = "dG9rZW4xMjM0NTY3ODkw",
    session = "c2Vzc2lvbl90b2tlbl90ZXN0"
}

-- Utility functions
local function encryptData(data) return data end
local function decryptData(data) return data end
local function validateSession() return true end
local function checkBan() return false end

-- Цвета GUI (Aurora Theme из VinScript)
local GUI_COLORS = {
    mainBackground = Color3.fromRGB(29, 34, 47),
    columnBackground = Color3.fromRGB(37, 43, 59),
    title = Color3.fromRGB(132, 171, 251),
    accent = Color3.fromRGB(101, 218, 255),
    text = Color3.fromRGB(221, 226, 239),
    enabled = Color3.fromRGB(101, 218, 255),
    disabled = Color3.fromRGB(136, 144, 167)
}

-- ========================================
-- ФУНКЦИЯ ПРОВЕРКИ КЛЮЧА
-- ========================================

local function validateKey(key)
    for _, validKey in ipairs(VALID_KEYS) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- ========================================
-- ФУНКЦИЯ СОЗДАНИЯ GUI
-- ========================================

local function createKeySystemGUI()
    local keySystemScreen = Instance.new("ScreenGui")
    keySystemScreen.Name = "VinScriptKeySystem"
    keySystemScreen.IgnoreGuiInset = true
    keySystemScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    keySystemScreen.Parent = game:GetService("CoreGui")
    
    -- Основной фрейм
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.6, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.5, 0, -0.6, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = GUI_COLORS.mainBackground
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.ZIndex = 2
    mainFrame.Parent = keySystemScreen
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 24)
    corner.Parent = mainFrame
    
    -- Aurora градиент
    local welcomeGradient = Instance.new("UIGradient")
    welcomeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 34, 47)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(37, 43, 59)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 52, 71))
    })
    welcomeGradient.Rotation = 135
    welcomeGradient.Parent = mainFrame
    
    -- Пульсирующая обводка
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 255, 196)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = mainFrame
    
    -- Анимация пульсации обводки
    task.spawn(function()
        local colorProgress = 0
        local transparencyProgress = 0
        while mainFrame.Parent do
            colorProgress = colorProgress + 0.01
            if colorProgress >= 1 then colorProgress = 0 end
            
            local color1 = Color3.fromRGB(0, 255, 196)
            local color2 = Color3.fromRGB(0, 149, 255)
            local t = (math.sin(colorProgress * math.pi * 2) + 1) / 2
            stroke.Color = color1:Lerp(color2, t)
            
            transparencyProgress = transparencyProgress + 0.02
            if transparencyProgress >= 1 then transparencyProgress = 0 end
            stroke.Transparency = 0.1 + (math.sin(transparencyProgress * math.pi * 2) + 1) / 2 * 0.4
            
            task.wait(0.03)
        end
    end)
    
    -- ========================================
    -- НОВОГОДНИЕ ЭФФЕКТЫ (как в VinScript)
    -- ========================================
    
    -- 1. Северное сияние (Aurora Borealis)
    local auroraContainer = Instance.new("Frame")
    auroraContainer.Size = UDim2.new(1, 0, 1, 0)
    auroraContainer.BackgroundTransparency = 1
    auroraContainer.ZIndex = 1
    auroraContainer.Parent = mainFrame
    
    for i = 1, 5 do
        local auroraWave = Instance.new("Frame")
        auroraWave.Size = UDim2.new(1, 0, 0, 100)
        auroraWave.Position = UDim2.new(0, 0, 0.15 + i * 0.12, 0)
        auroraWave.BackgroundColor3 = ({
            Color3.fromRGB(64, 224, 208),
            Color3.fromRGB(138, 43, 226),
            Color3.fromRGB(0, 191, 255),
            Color3.fromRGB(147, 112, 219),
            Color3.fromRGB(101, 218, 255)
        })[i]
        auroraWave.BackgroundTransparency = 0.8
        auroraWave.BorderSizePixel = 0
        auroraWave.ZIndex = 1
        auroraWave.Parent = auroraContainer
        
        local auroraCorner = Instance.new("UICorner")
        auroraCorner.CornerRadius = UDim.new(0, 50)
        auroraCorner.Parent = auroraWave
        
        local auroraGradient = Instance.new("UIGradient")
        auroraGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.5, auroraWave.BackgroundColor3),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        })
        auroraGradient.Rotation = 90
        auroraGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.7),
            NumberSequenceKeypoint.new(0.7, 0.7),
            NumberSequenceKeypoint.new(1, 1)
        })
        auroraGradient.Parent = auroraWave
        
        task.spawn(function()
            local progress = (i - 1) * 0.2
            while auroraWave.Parent do
                progress = progress + 0.005
                if progress >= 1 then progress = 0 end
                
                local bend = math.sin(progress * math.pi * 2) * 3
                local offset = math.sin(progress * math.pi * 2) * 20
                
                auroraWave.Position = UDim2.new(0, offset, 0.15 + i * 0.12, 0)
                auroraWave.Rotation = bend + (-3 + i * 1.5)
                auroraWave.BackgroundTransparency = 0.7 + math.sin(progress * math.pi * 4) * 0.15
                
                task.wait(0.05)
            end
        end)
    end
    
    -- 2. Падающий снег
    local snowContainer = Instance.new("Frame")
    snowContainer.Size = UDim2.new(1, 0, 1, 0)
    snowContainer.BackgroundTransparency = 1
    snowContainer.ZIndex = 3
    snowContainer.ClipsDescendants = true
    snowContainer.Parent = mainFrame
    
    local snowflakes = {}
    for i = 1, 25 do
        local snowflake = Instance.new("ImageLabel")
        snowflake.Size = UDim2.new(0, math.random(8, 16), 0, math.random(8, 16))
        snowflake.Position = UDim2.new(math.random(5, 95) / 100, 0, math.random(-50, 0) / 100, 0)
        snowflake.BackgroundTransparency = 1
        snowflake.Image = "rbxassetid://6031068420"
        snowflake.ImageColor3 = Color3.fromRGB(150, 200, 255)
        snowflake.ImageTransparency = math.random(20, 60) / 100
        snowflake.Rotation = math.random(0, 360)
        snowflake.ZIndex = 3
        snowflake.Parent = snowContainer
        
        table.insert(snowflakes, {
            frame = snowflake,
            speed = math.random(2, 6) / 100,
            sway = math.random(-5, 5) / 1000,
            rotSpeed = math.random(-2, 2)
        })
    end
    
    task.spawn(function()
        while snowContainer.Parent do
            for _, snow in ipairs(snowflakes) do
                local currentY = snow.frame.Position.Y.Scale
                local currentX = snow.frame.Position.X.Scale
                local newY = currentY + snow.speed
                local newX = currentX + snow.sway
                
                if newX < 0.05 then newX = 0.05 end
                if newX > 0.95 then newX = 0.95 end
                
                if newY > 1.05 then
                    newY = -0.05
                    newX = math.random(5, 95) / 100
                end
                
                snow.frame.Position = UDim2.new(newX, 0, newY, 0)
                snow.frame.Rotation = (snow.frame.Rotation + snow.rotSpeed) % 360
            end
            
            task.wait(0.03)
        end
    end)
    
    -- 3. Блестящие частицы
    local particlesContainer = Instance.new("Frame")
    particlesContainer.Size = UDim2.new(1, 0, 1, 0)
    particlesContainer.BackgroundTransparency = 1
    particlesContainer.ZIndex = 2
    particlesContainer.ClipsDescendants = true
    particlesContainer.Parent = mainFrame
    
    local particles = {}
    for i = 1, 35 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        particle.Position = UDim2.new(math.random(5, 95) / 100, 0, math.random(5, 95) / 100, 0)
        particle.BackgroundColor3 = ({
            Color3.fromRGB(255, 255, 200),
            Color3.fromRGB(200, 230, 255),
            Color3.fromRGB(255, 240, 255),
            Color3.fromRGB(220, 255, 220)
        })[math.random(1, 4)]
        particle.BackgroundTransparency = 0.5
        particle.BorderSizePixel = 0
        particle.ZIndex = 2
        particle.Parent = particlesContainer
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(1, 0)
        particleCorner.Parent = particle
        
        table.insert(particles, {
            frame = particle,
            speedX = math.random(-10, 10) / 1000,
            speedY = math.random(-10, 10) / 1000,
            fadeSpeed = math.random(2, 5) / 100
        })
    end
    
    task.spawn(function()
        while particlesContainer.Parent do
            for _, p in ipairs(particles) do
                local currentX = p.frame.Position.X.Scale
                local currentY = p.frame.Position.Y.Scale
                local newX = currentX + p.speedX
                local newY = currentY + p.speedY
                
                if newX < 0.05 or newX > 0.95 then
                    p.speedX = -p.speedX
                    newX = math.max(0.05, math.min(0.95, newX))
                end
                if newY < 0.05 or newY > 0.95 then
                    p.speedY = -p.speedY
                    newY = math.max(0.05, math.min(0.95, newY))
                end
                
                p.frame.Position = UDim2.new(newX, 0, newY, 0)
                
                local transparency = p.frame.BackgroundTransparency + p.fadeSpeed
                if transparency > 0.9 or transparency < 0.2 then
                    p.fadeSpeed = -p.fadeSpeed
                end
                p.frame.BackgroundTransparency = math.max(0.2, math.min(0.9, transparency))
            end
            
            task.wait(0.03)
        end
    end)
    
    -- ========================================
    -- KEY INITIALIZATION
    -- ========================================
    
    -- Initialize access keys
    local function initAuthKeys()
        local keys = {}
        table.insert(keys, "vinscript_key_a3k9d7f2h1")
        table.insert(keys, "vinscript_key_b8m4p6t9x2")
        table.insert(keys, "vinscript_key_c5n2w8q3v7")
        table.insert(keys, "vinscript_key_d9r6j4k1m8")
        table.insert(keys, "vinscript_key_e2s7n9p4f6")
        table.insert(keys, "vinscript_key_f6t3k8m2h9")
        table.insert(keys, "vinscript_key_g1p9v5w7q3")
        table.insert(keys, "vinscript_key_h4k2m6n8r1")
        table.insert(keys, "vinscript_key_i7w5t9j3x2")
        table.insert(keys, "vinscript_key_j3n8p2k6m4")
        return keys
    end
    
    if not VALID_KEYS then
        VALID_KEYS = initAuthKeys()
    end
    
    -- Database configuration
    local fakeDatabase = {users = {}, logs = {}}
    local function fakeValidate(k) return false end
    local function fakeAuth() return nil end
    
    -- ========================================
    -- ТЕКСТОВЫЕ ЭЛЕМЕНТЫ
    -- ========================================
    
    -- Заголовок
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.8, 0, 0.15, 0)
    titleLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🔐 VinScript Key System"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 42
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.ZIndex = 3
    titleLabel.Parent = mainFrame
    
    -- Подзаголовок
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(0.8, 0, 0.08, 0)
    subtitleLabel.Position = UDim2.new(0.1, 0, 0.32, 0)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = "Enter your key to access VinScript"
    subtitleLabel.TextColor3 = GUI_COLORS.text
    subtitleLabel.TextSize = 18
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    subtitleLabel.ZIndex = 3
    subtitleLabel.Parent = mainFrame
    
    -- ========================================
    -- ПОЛЕ ВВОДА КЛЮЧА
    -- ========================================
    
    local keyInputFrame = Instance.new("Frame")
    keyInputFrame.Size = UDim2.new(0.7, 0, 0.08, 0)
    keyInputFrame.Position = UDim2.new(0.15, 0, 0.45, 0)
    keyInputFrame.BackgroundColor3 = GUI_COLORS.columnBackground
    keyInputFrame.BackgroundTransparency = 0.3
    keyInputFrame.BorderSizePixel = 0
    keyInputFrame.ZIndex = 3
    keyInputFrame.Parent = mainFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 12)
    inputCorner.Parent = keyInputFrame
    
    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = GUI_COLORS.accent
    inputStroke.Thickness = 1.5
    inputStroke.Transparency = 0.7
    inputStroke.Parent = keyInputFrame
    
    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(1, -30, 1, -10)
    keyInput.Position = UDim2.new(0, 15, 0, 5)
    keyInput.BackgroundTransparency = 1
    keyInput.Text = ""
    keyInput.PlaceholderText = "vinscript_key_xxxxxxxxxx"
    keyInput.PlaceholderColor3 = GUI_COLORS.disabled
    keyInput.TextColor3 = GUI_COLORS.text
    keyInput.TextSize = 18
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextXAlignment = Enum.TextXAlignment.Left
    keyInput.ClearTextOnFocus = false
    keyInput.ZIndex = 4
    keyInput.Parent = keyInputFrame
    
    -- Эффект фокуса на поле ввода
    keyInput.Focused:Connect(function()
        inputStroke.Transparency = 0.3
    end)
    
    keyInput.FocusLost:Connect(function()
        inputStroke.Transparency = 0.7
    end)
    
    -- ========================================
    -- КНОПКА START
    -- ========================================
    
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    startButton.Position = UDim2.new(0.3, 0, 0.65, 0)
    startButton.BackgroundColor3 = GUI_COLORS.title
    startButton.BackgroundTransparency = 0
    startButton.Text = "START"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 24
    startButton.Font = Enum.Font.GothamBold
    startButton.ZIndex = 3
    startButton.Parent = mainFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = startButton
    
    local startButtonGradient = Instance.new("UIGradient")
    startButtonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(132, 171, 251)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 218, 255))
    })
    startButtonGradient.Rotation = 45
    startButtonGradient.Parent = startButton
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(0, 255, 196)
    buttonStroke.Thickness = 2
    buttonStroke.Transparency = 0.3
    buttonStroke.Parent = startButton
    
    task.spawn(function()
        local progress = 0
        while startButton.Parent do
            progress = progress + 0.015
            if progress >= 1 then progress = 0 end
            
            local color1 = Color3.fromRGB(0, 255, 196)
            local color2 = Color3.fromRGB(0, 149, 255)
            local t = (math.sin(progress * math.pi * 2) + 1) / 2
            buttonStroke.Color = color1:Lerp(color2, t)
            
            task.wait(0.03)
        end
    end)
    
    -- Эффекты при наведении
    startButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(startButton, TweenInfo.new(0.2), {
            BackgroundColor3 = GUI_COLORS.accent
        })
        tween:Play()
    end)
    
    startButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(startButton, TweenInfo.new(0.2), {
            BackgroundColor3 = GUI_COLORS.title
        })
        tween:Play()
    end)
    
    -- ========================================
    -- СТАТУС СООБЩЕНИЕ
    -- ========================================
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.8, 0, 0.06, 0)
    statusLabel.Position = UDim2.new(0.1, 0, 0.78, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = GUI_COLORS.accent
    statusLabel.TextSize = 16
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center
    statusLabel.ZIndex = 3
    statusLabel.Parent = mainFrame
    
    -- ========================================
    -- ИНФОРМАЦИЯ
    -- ========================================
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(0.8, 0, 0.05, 0)
    infoLabel.Position = UDim2.new(0.1, 0, 0.88, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Made by Vinomin | VinScript v2.0"
    infoLabel.TextColor3 = GUI_COLORS.disabled
    infoLabel.TextSize = 14
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextXAlignment = Enum.TextXAlignment.Center
    infoLabel.ZIndex = 3
    infoLabel.Parent = mainFrame
    
    -- ========================================
    -- ОБРАБОТЧИК КНОПКИ START
    -- ========================================
    
    startButton.MouseButton1Click:Connect(function()
        local enteredKey = keyInput.Text
        
        if enteredKey == "" then
            statusLabel.Text = "❌ Please enter a key!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 107, 107)
            
            local shakeTween = TweenService:Create(keyInputFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 3, true), {
                Position = UDim2.new(0.15, 10, 0.45, 0)
            })
            shakeTween:Play()
            shakeTween.Completed:Connect(function()
                keyInputFrame.Position = UDim2.new(0.15, 0, 0.45, 0)
            end)
            return
        end
        
        if validateKey(enteredKey) then
            statusLabel.Text = "✅ Key accepted! Loading VinScript..."
            statusLabel.TextColor3 = Color3.fromRGB(101, 218, 255)
            
            local clickTween = TweenService:Create(startButton, TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0.38, 0, 0.095, 0)
            })
            clickTween:Play()
            
            task.wait(0.05)
            
            local releaseTween = TweenService:Create(startButton, TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Size = UDim2.new(0.4, 0, 0.1, 0)
            })
            releaseTween:Play()
            
            task.wait(1)
            
            -- Анимация исчезновения
            local disappearTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -0.7, 0)
            })
            disappearTween:Play()
            
            disappearTween.Completed:Connect(function()
                keySystemScreen:Destroy()
                
                -- Загружаем VinScript 2.0 с GitHub
                print("[VinScript Key System] ✅ Key validated!")
                print("[VinScript Key System] Loading VinScript 2.0...")
                
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Vinom1n/VinScript2.6beta/refs/heads/main/VinScript2.0.lua"))()
            end)
        else
            statusLabel.Text = "❌ Invalid key! Please try again."
            statusLabel.TextColor3 = Color3.fromRGB(255, 107, 107)
            
            local shakeTween = TweenService:Create(mainFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 3, true), {
                Position = UDim2.new(0.5, 10, 0.5, 0)
            })
            shakeTween:Play()
            shakeTween.Completed:Connect(function()
                mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            end)
        end
    end)
    
    -- ========================================
    -- АНИМАЦИЯ ПОЯВЛЕНИЯ
    -- ========================================
    
    local appearTween = TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    appearTween:Play()
    
    return keySystemScreen
end

-- ========================================
-- ЗАПУСК СИСТЕМЫ
-- ========================================

print("========================================")
print("  VinScript Key System v1.0")
print("========================================")
print("Loading key system...")

createKeySystemGUI()

print("Key system loaded successfully!")
print("Valid keys: " .. #VALID_KEYS)
