-- ============================================================
--  MM2 VALUE CALCULATOR (FULL DATABASE v3)
--  Все годли + аншенты + хромы (август 2026)
-- ============================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
--  ПОЛНАЯ БАЗА ЦЕН
-- ============================================================
local VALUES = {
    -- ====== ANCIENTS ======
    ["gingerscope"] = 18500,
    ["travelersaxe"] = 8100,
    ["celestial"] = 1725,
    ["vampireaxe"] = 925,
    ["harvester"] = 300,
    ["icepiercer"] = 200,
    ["godly"] = 0, -- заглушка

    -- ====== TIER 4 GODLIES ======
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

    -- ====== TIER 3 GODLIES ======
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

    -- ====== TIER 2 GODLIES ======
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
    ["blue"] = 3,
    ["orange"] = 2,
    ["purple"] = 3,
    ["red"] = 3,
    ["yellow"] = 2,

    -- ====== TIER 1 GODLIES ======
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

    -- ====== VINTAGE (полный список) ======
    ["corrupt"] = 600,
    ["amerilaser"] = 22,
    ["battleaxe"] = 12,
    ["battleaxeii"] = 17,
    ["blaster"] = 17,
    ["blue"] = 3,
    ["boneblade"] = 7,
    ["chill"] = 10,
    ["clockwork"] = 10,
    ["cookieblade"] = 3,
    ["deathshard"] = 13,
    ["eternal"] = 7,
    ["eternalii"] = 7,
    ["eternaliii"] = 8,
    ["eternaliv"] = 8,
    ["fang"] = 10,
    ["flames"] = 5,
    ["frostbite"] = 7,
    ["frostsaber"] = 10,
    ["ghostblade"] = 7,
    ["gingerblade"] = 13,
    ["handsaw"] = 8,
    ["heat"] = 10,
    ["icebeam"] = 18,
    ["iceflake"] = 15,
    ["icedragon"] = 7,
    ["iceshard"] = 7,
    ["jinglegun"] = 13,
    ["laser"] = 22,
    ["luger"] = 40,
    ["minty"] = 13,
    ["nebula"] = 13,
    ["oldglory"] = 15,
    ["orange"] = 2,
    ["peppermint"] = 4,
    ["pixel"] = 17,
    ["plasmablade"] = 15,
    ["plasmabeam"] = 18,
    ["prismatic"] = 7,
    ["pumpking"] = 7,
    ["purple"] = 3,
    ["red"] = 3,
    ["saw"] = 7,
    ["seer"] = 3,
    ["slasher"] = 15,
    ["snowflake"] = 5,
    ["spider"] = 10,
    ["swirlyblade"] = 12,
    ["swirlygun"] = 18,
    ["tides"] = 10,
    ["vampiresedge"] = 15,
    ["virtual"] = 13,
    ["wintersedge"] = 5,
    ["xmas"] = 7,
    ["yellow"] = 2,

    -- ====== CHROMAS (все существующие) ======
    ["chromatravelersgun"] = 225000,
    ["chromaevergun"] = 78000,
    ["chromaevergreen"] = 60000,
    ["chromabauble"] = 38000,
    ["chromaconstellation"] = 36000,
    ["chromavampiresgun"] = 35000,
    ["chromaalienbeam"] = 30000,
    ["chromaraygun"] = 15000,
    ["chromasunrise"] = 11250,
    ["chromasnowcannon"] = 8500,
    ["chromablizzard"] = 8000,
    ["chromasunset"] = 6500,
    ["chromasnowdagger"] = 5750,
    ["chromatreat"] = 4850,
    ["chromaheartwand"] = 4750,
    ["chromasnowstorm"] = 4250,
    ["chromawatergun"] = 3400,
    ["chromasweet"] = 2850,
    ["chromaornament"] = 2700,
    ["chromacandleflame"] = 200,
    ["chromacorrupt"] = 180,
    ["chromadarkbringer"] = 180,
    ["chromaeternal"] = 120,
    ["chromaeternalii"] = 120,
    ["chromaeternaliii"] = 120,
    ["chromaeternaliv"] = 120,
    ["chromafang"] = 120,
    ["chromagemstone"] = 120,
    ["chromaghostblade"] = 120,
    ["chromagreenluger"] = 120,
    ["chromaheat"] = 120,
    ["chromalaser"] = 120,
    ["chromalightbringer"] = 180,
    ["chromaluger"] = 180,
    ["chromamakeshift"] = 180,
    ["chromaminty"] = 120,
    ["chromaoldglory"] = 120,
    ["chromaphantom"] = 120,
    ["chromapixel"] = 120,
    ["chromaplasmablade"] = 120,
    ["chromaplasmabeam"] = 120,
    ["chromapumpking"] = 120,
    ["chromaredluger"] = 120,
    ["chromaseer"] = 120,
    ["chromashark"] = 120,
    ["chromaslasher"] = 120,
    ["chromaspectre"] = 120,
    ["chromasugar"] = 120,
    ["chromatides"] = 120,
    ["chromaxmas"] = 120,
}

-- ============================================================
--  ПОИСК ЦЕНЫ
-- ============================================================
local function getItemValue(name)
    if not name or name == "" then return 0 end
    local clean = name:lower():gsub("[^a-z0-9]", "")

    if VALUES[clean] then return VALUES[clean] end

    if string.sub(clean, 1, 6) == "chroma" then
        local base = string.sub(clean, 7)
        if VALUES[base] then return VALUES[base] * 2.5 end
    end

    for key, val in pairs(VALUES) do
        if clean:find(key) or key:find(clean) then return val end
    end

    return 0
end

-- ============================================================
--  GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2Values"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 210, 0, 72)
MainFrame.Position = UDim2.new(0.5, -105, 0.8, -36)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

do
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = MainFrame
    local s = Instance.new("UIStroke"); s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Color = Color3.fromRGB(150, 80, 255); s.Thickness = 1.5; s.Parent = MainFrame
end

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 16)
Title.Position = UDim2.new(0, 0, 0, 1)
Title.BackgroundTransparency = 1
Title.Text = "💰 MM2 Values (Full DB)"
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 10
Title.TextColor3 = Color3.fromRGB(200, 180, 255)
Title.Parent = MainFrame

local YourLabel = Instance.new("TextLabel")
YourLabel.Size = UDim2.new(0.48, 0, 0, 16)
YourLabel.Position = UDim2.new(0, 4, 0, 18)
YourLabel.BackgroundTransparency = 1
YourLabel.Text = "You: —"
YourLabel.Font = Enum.Font.SourceSansBold
YourLabel.TextSize = 11
YourLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
YourLabel.TextXAlignment = Enum.TextXAlignment.Left
YourLabel.Parent = MainFrame

local TheirLabel = Instance.new("TextLabel")
TheirLabel.Size = UDim2.new(0.48, 0, 0, 16)
TheirLabel.Position = UDim2.new(0.52, 0, 0, 18)
TheirLabel.BackgroundTransparency = 1
TheirLabel.Text = "Them: —"
TheirLabel.Font = Enum.Font.SourceSansBold
TheirLabel.TextSize = 11
TheirLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
TheirLabel.TextXAlignment = Enum.TextXAlignment.Left
TheirLabel.Parent = MainFrame

local DiffLabel = Instance.new("TextLabel")
DiffLabel.Size = UDim2.new(1, 0, 0, 16)
DiffLabel.Position = UDim2.new(0, 0, 0, 36)
DiffLabel.BackgroundTransparency = 1
DiffLabel.Text = "Diff: —"
DiffLabel.Font = Enum.Font.SourceSansBold
DiffLabel.TextSize = 11
DiffLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
DiffLabel.TextXAlignment = Enum.TextXAlignment.Center
DiffLabel.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 12)
StatusLabel.Position = UDim2.new(0, 0, 0, 54)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ready"
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 8
StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- ============================================================
--  ЧТЕНИЕ ОФФЕРА
-- ============================================================
local function getTradeItems(side)
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

    local frame = trade:FindFirstChild(side)
    if not frame then return items end

    local slotContainer = frame:FindFirstChild("Container")
    if not slotContainer then return items end

    for i = 1, 4 do
        local slot = slotContainer:FindFirstChild("NewItem" .. i)
        if slot and slot.Visible then
            local label = slot:FindFirstChild("Label", true)
            if label and label:IsA("TextLabel") and label.Text ~= "" and label.Text ~= "Label" then
                local amount = 1
                local amtLabel = slot:FindFirstChild("Amount", true)
                if amtLabel and amtLabel:IsA("TextLabel") then
                    local n = amtLabel.Text:match("x(%d+)")
                    if n then amount = tonumber(n) or 1 end
                end
                table.insert(items, { name = label.Text, amount = amount })
            end
        end
    end
    return items
end

local function getFakeItems(slots)
    local items = {}
    if not slots then return items end
    for i = 1, 4 do
        local slot = slots[i]
        if slot then
            local name = slot.Name or slot.DataID or slot.ItemName or ""
            if name ~= "" and name ~= "NewItem" then
                table.insert(items, { name = name, amount = slot.Amount or 1 })
            end
        end
    end
    return items
end

local function calcTotal(items)
    local total = 0
    for _, item in ipairs(items) do
        local val = getItemValue(item.name)
        total = total + (val * (item.amount or 1))
    end
    return total
end

local function fmt(v)
    if v >= 1000000 then return string.format("%.1fM", v / 1000000) end
    if v >= 1000 then return string.format("%.1fK", v / 1000) end
    return tostring(math.floor(v))
end

-- ============================================================
--  ОБНОВЛЕНИЕ
-- ============================================================
local function update()
    pcall(function()
        local isFake = _G.fakeTrade and _G.fakeTrade.active
        local yourItems, theirItems

        if isFake and _G.YourSlots and _G.TheirSlots then
            yourItems = getFakeItems(_G.YourSlots)
            theirItems = getFakeItems(_G.TheirSlots)
        else
            yourItems = getTradeItems("YourOffer")
            theirItems = getTradeItems("TheirOffer")
        end

        local y = calcTotal(yourItems)
        local t = calcTotal(theirItems)
        local d = y - t

        YourLabel.Text = "You: " .. (y > 0 and fmt(y) or "—")
        TheirLabel.Text = "Them: " .. (t > 0 and fmt(t) or "—")

        if d > 0 then
            DiffLabel.Text = "Diff: +" .. fmt(d) .. " ✅"
            DiffLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif d < 0 then
            DiffLabel.Text = "Diff: " .. fmt(d) .. " ❌"
            DiffLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            DiffLabel.Text = "Diff: 0 ⚖️"
            DiffLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
end

-- ============================================================
--  ЗАПУСК
-- ============================================================
task.spawn(function()
    while true do
        task.wait(2)
        update()
    end
end)

update()

print("[MM2 Values] Loaded. " .. #VALUES .. " items in database.")
