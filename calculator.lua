-- ============================================================
--  MM2 Value Calculator (Supreme Values) — ИСПРАВЛЕННАЯ
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local SV_CACHE = {}
local SV_LAST_UPDATE = 0
local SV_CACHE_TTL = 900
local SV_IS_FETCHING = false

-- ── ВСЕ ЭКЗЕКЬЮТОРЫ ──────────────────────────────────────────
local function httpRequest(url)
    local requestFn = syn and syn.request
        or (http and http.request)
        or (rawget(_G, "request") and type(rawget(_G, "request")) == "function" and rawget(_G, "request"))
        or (rawget(_G, "http_request") and type(rawget(_G, "http_request")) == "function" and rawget(_G, "http_request"))
        or (rawget(_G, "fetchget") and type(rawget(_G, "fetchget")) == "function" and rawget(_G, "fetchget"))
        or (rawget(_G, "gethttp") and type(rawget(_G, "gethttp")) == "function" and rawget(_G, "gethttp"))

    if not requestFn then
        warn("[ValueCalc] HTTP not available")
        return nil
    end

    local ok, res = pcall(requestFn, {
        Url = url,
        Method = "GET",
        Headers = {
            ["Accept"] = "*/*",
            ["Referer"] = "https://supremevalues.com/mm2/godlies",
            ["User-Agent"] = "Mozilla/5.0"
        }
    })

    if ok and res and res.Body then
        return res.Body
    end
    return nil
end

-- ── ПАРСИНГ ──────────────────────────────────────────────────
local function fetchSupremeValues()
    if SV_IS_FETCHING then return end
    if SV_CACHE and next(SV_CACHE) and (tick() - SV_LAST_UPDATE) < SV_CACHE_TTL then return end

    SV_IS_FETCHING = true
    print("[ValueCalc] Fetching Supreme Values...")

    local pages = {
        "https://supremevalues.com/mm2/godlies",
        "https://supremevalues.com/mm2/ancients",
        "https://supremevalues.com/mm2/chromas",
    }

    local newCache = {}
    local loaded = 0

    for _, url in ipairs(pages) do
        local body = httpRequest(url)
        if body and #body > 1000 then
            local pos = 1
            while true do
                local ns, ne, rawName = body:find('data%-name="([^"]+)"', pos)
                if not ns then break end

                local searchBlock = body:sub(math.max(1, ns - 300), math.min(#body, ne + 300))
                local val = nil

                for v in searchBlock:gmatch('data%-value="(%d+)"') do
                    val = tonumber(v)
                    break
                end

                if not val then
                    for num in searchBlock:gmatch("Value[%s%p]*(%d+[,%.%d]*)") do
                        val = tonumber(num:gsub("[,.]", ""))
                        if val and val > 0 then break end
                    end
                end

                if val and val > 0 then
                    local name = rawName:gsub("&#039;", "'"):gsub("&amp;", "&"):gsub("&quot;", '"')
                    local clean = name:lower():gsub("[^a-z0-9%']", "")
                    newCache[clean] = val
                    loaded = loaded + 1

                    -- Алиасы
                    if clean == "travelersgun" then
                        newCache["travelergun"] = val
                    elseif clean == "evergun" then
                        newCache["evergun"] = val
                    end
                end
                pos = ne + 1
            end
        end
        task.wait(0.2)
    end

    if loaded > 0 then
        SV_CACHE = newCache
        SV_LAST_UPDATE = tick()
        print("[ValueCalc] Loaded " .. loaded .. " items")
        if StatusLabel then
            StatusLabel.Text = "Supreme Values ✔ (" .. loaded .. ")"
            StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
        end
    else
        warn("[ValueCalc] Failed to load values")
        if StatusLabel then
            StatusLabel.Text = "Failed to load values"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end

    SV_IS_FETCHING = false
end

-- ── ПОИСК ЗНАЧЕНИЙ ──────────────────────────────────────────
local function getItemValue(itemName)
    if not itemName or itemName == "" then return 0 end
    local clean = itemName:lower():gsub("[^a-z0-9%']", "")

    if clean:find("chroma") then
        local base = clean:gsub("chroma", "")
        if SV_CACHE[base] then return SV_CACHE[base] * 2.5 end
    end

    if SV_CACHE[clean] then return SV_CACHE[clean] end

    for key, val in pairs(SV_CACHE) do
        if key:find(clean) or clean:find(key) then return val end
    end

    -- Алиасы
    local aliases = {
        ["corrupt"] = "corrupt", ["gingerscope"] = "gingerscope",
        ["travelersaxe"] = "travelersaxe", ["vampireaxe"] = "vampireaxe",
        ["harvester"] = "harvester", ["icepiercer"] = "icepiercer",
        ["blossom"] = "blossom", ["sakura"] = "sakura",
        ["sunrise"] = "sunrise", ["snowcannon"] = "snowcannon",
        ["bauble"] = "bauble", ["sunset"] = "sunset",
        ["soul"] = "soul", ["spirit"] = "spirit",
        ["rainbowgun"] = "rainbowgun", ["flora"] = "flora",
        ["rainbow"] = "rainbow", ["bloom"] = "bloom",
        ["heartwand"] = "heartwand", ["ocean"] = "ocean",
        ["waves"] = "waves", ["xenoknife"] = "xenoknife",
        ["xenoshot"] = "xenoshot", ["flowerwoodgun"] = "flowerwoodgun",
        ["blizzard"] = "blizzard", ["flowerwood"] = "flowerwood",
        ["snowstorm"] = "snowstorm", ["snowdagger"] = "snowdagger",
        ["watergun"] = "watergun", ["icecream"] = "icecream",
        ["treat"] = "treat", ["beachy"] = "beachy",
        ["sands"] = "sands", ["sweet"] = "sweet",
        ["borealis"] = "borealis", ["australis"] = "australis",
        ["bat"] = "bat", ["pearlshine"] = "pearlshine",
        ["pearl"] = "pearl", ["candy"] = "candy",
        ["heartblade"] = "heartblade", ["luger"] = "luger",
        ["redluger"] = "redluger", ["phantom"] = "phantom",
        ["spectre"] = "spectre", ["candleflame"] = "candleflame",
        ["darkbringer"] = "darkbringer", ["elderwoodblade"] = "elderwoodblade",
        ["elderwoodrevolver"] = "elderwoodrevolver", ["iceblaster"] = "iceblaster",
        ["lightbringer"] = "lightbringer", ["makeshift"] = "makeshift",
        ["sugar"] = "sugar", ["ornament"] = "ornament",
        ["greenluger"] = "greenluger", ["amerilaser"] = "amerilaser",
        ["laser"] = "laser", ["hallowgun"] = "hallowgun",
        ["nightblade"] = "nightblade", ["shark"] = "shark",
        ["icebeam"] = "icebeam", ["plasmabeam"] = "plasmabeam",
        ["swirlygun"] = "swirlygun", ["battleaxeii"] = "battleaxeii",
        ["blaster"] = "blaster", ["gingerluger"] = "gingerluger",
        ["pixel"] = "pixel", ["gemstone"] = "gemstone",
        ["iceflake"] = "iceflake", ["oldglory"] = "oldglory",
        ["plasmablade"] = "plasmablade", ["slasher"] = "slasher",
        ["vampiresedge"] = "vampiresedge", ["cookiecane"] = "cookiecane",
        ["deathshard"] = "deathshard", ["eternalcane"] = "eternalcane",
        ["gingerblade"] = "gingerblade", ["jinglegun"] = "jinglegun",
        ["lugercane"] = "lugercane", ["minty"] = "minty",
        ["nebula"] = "nebula", ["virtual"] = "virtual",
        ["battleaxe"] = "battleaxe", ["gingermint"] = "gingermint",
        ["swirlyblade"] = "swirlyblade", ["chill"] = "chill",
        ["clockwork"] = "clockwork", ["fang"] = "fang",
        ["frostsaber"] = "frostsaber", ["heat"] = "heat",
        ["spider"] = "spider", ["tides"] = "tides",
        ["bioblade"] = "bioblade", ["eternaliii"] = "eternaliii",
        ["eternaliv"] = "eternaliv", ["hallowsblade"] = "hallowsblade",
        ["hallowsedge"] = "hallowsedge", ["handsaw"] = "handsaw",
        ["boneblade"] = "boneblade", ["eternal"] = "eternal",
        ["eternalii"] = "eternalii", ["frostbite"] = "frostbite",
        ["ghostblade"] = "ghostblade", ["icedragon"] = "icedragon",
        ["iceshard"] = "iceshard", ["prismatic"] = "prismatic",
        ["pumpking"] = "pumpking", ["saw"] = "saw",
        ["xmas"] = "xmas", ["eggblade"] = "eggblade",
        ["flames"] = "flames", ["snowflake"] = "snowflake",
        ["wintersedge"] = "wintersedge", ["peppermint"] = "peppermint",
        ["cookieblade"] = "cookieblade", ["blueseer"] = "blueseer",
        ["purpleseer"] = "purpleseer", ["redseer"] = "redseer",
        ["seer"] = "seer", ["orangeseer"] = "orangeseer",
        ["yellowseer"] = "yellowseer",
    }

    if aliases[clean] then
        return SV_CACHE[aliases[clean]] or 0
    end

    return 0
end

-- ── ГЛАВНОЕ GUI ──────────────────────────────────────────────
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
StatusLabel.Text = "Loading values..."
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 8
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- ── ЧТЕНИЕ ОФФЕРА ────────────────────────────────────────────
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

-- ── ОБНОВЛЕНИЕ ──────────────────────────────────────────────
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

        local count = 0
        for _ in pairs(SV_CACHE) do count = count + 1 end
        if count > 0 then
            StatusLabel.Text = "Supreme Values ✔ (" .. count .. " items)"
            StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
        else
            StatusLabel.Text = "Loading values..."
            StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end)
end

-- ── ЗАПУСК ──────────────────────────────────────────────────
task.spawn(function()
    while true do
        task.wait(3)
        updateValues()
    end
end)

task.spawn(function()
    fetchSupremeValues()
    updateValues()
    while true do
        task.wait(600)
        fetchSupremeValues()
    end
end)

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.KeyCode == Enum.KeyCode.LeftControl then
        fetchSupremeValues()
        updateValues()
        StatusLabel.Text = "Refreshing..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        task.delay(2, updateValues)
    end
end)

print("[ValueCalc] Loaded. Ctrl+Click on panel to refresh.")
