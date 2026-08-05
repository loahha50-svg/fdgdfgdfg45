-- ============================================================
--  MM2 Value Calculator (Supreme + Fallback)  -- ИСПРАВЛЕННЫЙ
-- ============================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local SV_CACHE = {}
local SV_LOADED = false

-- ============================================================
--  ЗАПАСНЫЕ ЗНАЧЕНИЯ (HARDCODED) — если сайт не грузится
-- ============================================================
local FALLBACK_VALUES = {
    ["travelersgun"] = 5600,
    ["evergun"] = 3450,
    ["constellation"] = 2700,
    ["evergreen"] = 2500,
    ["turkey"] = 2450,
    ["vampiresgun"] = 1950,
    ["alienbeam"] = 1850,
    ["darkshot"] = 1700,
    ["darksword"] = 1675,
    ["raygun"] = 1550,
    ["blossom"] = 1330,
    ["sakura"] = 1320,
    ["sunrise"] = 1125,
    ["snowcannon"] = 850,
    ["bauble"] = 825,
    ["sunset"] = 625,
    ["soul"] = 615,
    ["spirit"] = 605,
    ["rainbowgun"] = 420,
    ["flora"] = 410,
    ["rainbow"] = 410,
    ["bloom"] = 400,
    ["heartwand"] = 340,
    ["ocean"] = 285,
    ["waves"] = 280,
    ["xenoknife"] = 280,
    ["xenoshot"] = 280,
    ["flowerwoodgun"] = 265,
    ["blizzard"] = 260,
    ["flowerwood"] = 260,
    ["snowstorm"] = 260,
    ["snowdagger"] = 250,
    ["watergun"] = 250,
    ["icecream"] = 160,
    ["treat"] = 155,
    ["beachy"] = 150,
    ["sands"] = 150,
    ["sweet"] = 150,
    ["borealis"] = 145,
    ["australis"] = 140,
    ["bat"] = 120,
    ["pearlshine"] = 85,
    ["pearl"] = 80,
    ["candy"] = 80,
    ["heartblade"] = 65,
    ["luger"] = 40,
    ["redluger"] = 37,
    ["phantom"] = 35,
    ["spectre"] = 35,
    ["candleflame"] = 33,
    ["darkbringer"] = 33,
    ["elderwoodblade"] = 33,
    ["elderwoodrevolver"] = 33,
    ["iceblaster"] = 33,
    ["lightbringer"] = 33,
    ["makeshift"] = 33,
    ["sugar"] = 32,
    ["ornament"] = 28,
    ["greenluger"] = 23,
    ["amerilaser"] = 22,
    ["laser"] = 22,
    ["hallowgun"] = 20,
    ["nightblade"] = 20,
    ["shark"] = 20,
    ["icebeam"] = 18,
    ["plasmabeam"] = 18,
    ["swirlygun"] = 18,
    ["battleaxeii"] = 17,
    ["blaster"] = 17,
    ["gingerluger"] = 17,
    ["pixel"] = 17,
    ["gemstone"] = 15,
    ["iceflake"] = 15,
    ["oldglory"] = 15,
    ["plasmablade"] = 15,
    ["slasher"] = 15,
    ["vampiresedge"] = 15,
    ["cookiecane"] = 13,
    ["deathshard"] = 13,
    ["eternalcane"] = 13,
    ["gingerblade"] = 13,
    ["jinglegun"] = 13,
    ["lugercane"] = 13,
    ["minty"] = 13,
    ["nebula"] = 13,
    ["virtual"] = 13,
    ["battleaxe"] = 12,
    ["gingermint"] = 12,
    ["swirlyblade"] = 12,
    ["chill"] = 10,
    ["clockwork"] = 10,
    ["fang"] = 10,
    ["frostsaber"] = 10,
    ["heat"] = 10,
    ["spider"] = 10,
    ["tides"] = 10,
    ["bioblade"] = 8,
    ["eternaliii"] = 8,
    ["eternaliv"] = 8,
    ["hallowsblade"] = 8,
    ["hallowsedge"] = 8,
    ["handsaw"] = 8,
    ["boneblade"] = 7,
    ["eternal"] = 7,
    ["eternalii"] = 7,
    ["frostbite"] = 7,
    ["ghostblade"] = 7,
    ["icedragon"] = 7,
    ["iceshard"] = 7,
    ["prismatic"] = 7,
    ["pumpking"] = 7,
    ["saw"] = 7,
    ["xmas"] = 7,
    ["eggblade"] = 5,
    ["flames"] = 5,
    ["snowflake"] = 5,
    ["wintersedge"] = 5,
    ["peppermint"] = 4,
    ["cookieblade"] = 3,
    ["blueseer"] = 3,
    ["purpleseer"] = 3,
    ["redseer"] = 3,
    ["seer"] = 3,
    ["orangeseer"] = 2,
    ["yellowseer"] = 2,
    ["corrupt"] = 600,
    ["gingerscope"] = 18500,
    ["travelersaxe"] = 8100,
    ["vampireaxe"] = 925,
    ["harvester"] = 300,
    ["icepiercer"] = 200,
}

-- Функция для получения значения (сначала ищет в кэше, потом в fallback)
local function getItemValue(itemName)
    if not itemName or itemName == "" then return 0 end
    local clean = itemName:lower():gsub("[^a-z0-9%']", "")

    -- Поиск в загруженном кэше
    if SV_CACHE[clean] then return SV_CACHE[clean] end

    -- Поиск в fallback
    if FALLBACK_VALUES[clean] then return FALLBACK_VALUES[clean] end

    -- Поиск по части названия
    for key, val in pairs(FALLBACK_VALUES) do
        if clean:find(key) or key:find(clean) then return val end
    end

    return 0
end

-- Загружаем fallback сразу (чтобы значения были всегда)
for k, v in pairs(FALLBACK_VALUES) do
    SV_CACHE[k] = v
end
SV_LOADED = true
print("[ValueCalc] Fallback values loaded: " .. #FALLBACK_VALUES .. " items")

-- ============================================================
--  GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ValueCalculator"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 998
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 80)
MainFrame.Position = UDim2.new(0.5, -100, 0.8, -40)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.15
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

do
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = MainFrame
    local s = Instance.new("UIStroke"); s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Color = Color3.fromRGB(100, 100, 255); s.Thickness = 1.5; s.Parent = MainFrame
end

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 16)
Title.Position = UDim2.new(0, 0, 0, 2)
Title.BackgroundTransparency = 1
Title.Text = "MM2 Value Calculator"
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 10
Title.TextColor3 = Color3.fromRGB(204, 204, 255)
Title.Parent = MainFrame

local YourLabel = Instance.new("TextLabel")
YourLabel.Size = UDim2.new(0.45, 0, 0, 16)
YourLabel.Position = UDim2.new(0, 6, 0, 20)
YourLabel.BackgroundTransparency = 1
YourLabel.Text = "You: —"
YourLabel.Font = Enum.Font.SourceSansBold
YourLabel.TextSize = 11
YourLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
YourLabel.TextXAlignment = Enum.TextXAlignment.Left
YourLabel.Parent = MainFrame

local TheirLabel = Instance.new("TextLabel")
TheirLabel.Size = UDim2.new(0.45, 0, 0, 16)
TheirLabel.Position = UDim2.new(0.55, 0, 0, 20)
TheirLabel.BackgroundTransparency = 1
TheirLabel.Text = "Them: —"
TheirLabel.Font = Enum.Font.SourceSansBold
TheirLabel.TextSize = 11
TheirLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
TheirLabel.TextXAlignment = Enum.TextXAlignment.Left
TheirLabel.Parent = MainFrame

local DiffLabel = Instance.new("TextLabel")
DiffLabel.Size = UDim2.new(1, 0, 0, 16)
DiffLabel.Position = UDim2.new(0, 0, 0, 40)
DiffLabel.BackgroundTransparency = 1
DiffLabel.Text = "Diff: —"
DiffLabel.Font = Enum.Font.SourceSansBold
DiffLabel.TextSize = 11
DiffLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
DiffLabel.TextXAlignment = Enum.TextXAlignment.Center
DiffLabel.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 14)
StatusLabel.Position = UDim2.new(0, 0, 0, 58)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Values loaded (fallback)"
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 8
StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- ============================================================
--  ФУНКЦИИ ДЛЯ ЧТЕНИЯ ОФФЕРА
-- ============================================================
local function getTradeItems(offerFrameName)
    local items = {}
    local tradeGui = nil
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui.Name == "TradeGUI" or gui.Name == "TradeGui" then
            tradeGui = gui
            break
        end
    end
    if not tradeGui or not tradeGui.Enabled then return items end

    local container = tradeGui:FindFirstChild("Container")
    if not container or not container.Visible then return items end

    local trade = container:FindFirstChild("Trade")
    if not trade or not trade.Visible then return items end

    local offerFrame = trade:FindFirstChild(offerFrameName)
    local slotContainer = offerFrame and offerFrame:FindFirstChild("Container")
    if not slotContainer then return items end

    for i = 1, 4 do
        local slot = slotContainer:FindFirstChild("NewItem" .. i)
        if slot and slot.Visible then
            local labelObj = slot:FindFirstChild("Label", true)
            if labelObj and labelObj:IsA("TextLabel") and labelObj.Text ~= "" and labelObj.Text ~= "Label" then
                local amount = 1
                local tradeAmtObj = slot:FindFirstChild("TradeAmount", true)
                if tradeAmtObj and tradeAmtObj:IsA("TextLabel") then
                    local n = tradeAmtObj.Text:match("x?(%d+)")
                    if n then amount = tonumber(n) or 1 end
                end
                local amtObj = slot:FindFirstChild("Amount", true)
                if amtObj and amtObj:IsA("TextLabel") and amount == 1 then
                    local n = amtObj.Text:match("x(%d+)")
                    if n then amount = tonumber(n) or 1 end
                end
                table.insert(items, { name = labelObj.Text, amount = amount })
            end
        end
    end
    return items
end

local function getFakeTradeItems(offerSlots)
    local items = {}
    if not offerSlots then return items end
    for i = 1, 4 do
        local slot = offerSlots[i]
        if slot then
            local name = slot.ItemName or slot.Name or slot.DataID or ""
            if name ~= "" then
                table.insert(items, { name = name, amount = slot.Amount or 1 })
            end
        end
    end
    return items
end

local function calculateValue(items)
    local total = 0
    for _, item in ipairs(items) do
        local val = getItemValue(item.name)
        total = total + (val * (item.amount or 1))
    end
    return total
end

local function formatValue(val)
    if val >= 1000000 then return string.format("%.1fM", val / 1000000) end
    if val >= 1000 then return string.format("%.1fK", val / 1000) end
    return tostring(math.floor(val))
end

-- ============================================================
--  ОБНОВЛЕНИЕ
-- ============================================================
local function updateValues()
    pcall(function()
        local isFakeActive = _G.fakeTrade and _G.fakeTrade.active

        local yourItems = {}
        local theirItems = {}

        if isFakeActive and _G.YourSlots and _G.TheirSlots then
            yourItems = getFakeTradeItems(_G.YourSlots)
            theirItems = getFakeTradeItems(_G.TheirSlots)
        else
            yourItems = getTradeItems("YourOffer")
            theirItems = getTradeItems("TheirOffer")
        end

        local yourVal = calculateValue(yourItems)
        local theirVal = calculateValue(theirItems)
        local diff = yourVal - theirVal

        YourLabel.Text = "You: " .. (yourVal > 0 and formatValue(yourVal) or "—")
        TheirLabel.Text = "Them: " .. (theirVal > 0 and formatValue(theirVal) or "—")

        if diff > 0 then
            DiffLabel.Text = "Diff: +" .. formatValue(diff) .. " (you win)"
            DiffLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif diff < 0 then
            DiffLabel.Text = "Diff: " .. formatValue(diff) .. " (you lose)"
            DiffLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            DiffLabel.Text = "Diff: 0 (fair trade)"
            DiffLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        StatusLabel.Text = "Values: " .. (#SV_CACHE) .. " items"
        StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
    end)
end

-- ============================================================
--  ЗАПУСК
-- ============================================================
task.spawn(function()
    while true do
        task.wait(3)
        updateValues()
    end
end)

updateValues()
print("[ValueCalc] Loaded with fallback values. Ctrl+Click to refresh.")
