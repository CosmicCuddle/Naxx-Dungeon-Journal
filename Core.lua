local ADDON_NAME = ...

DungeonJournal = DungeonJournal or {}
local SDJ = DungeonJournal

DungeonJournalDB = DungeonJournalDB or {}

SDJ.ADDON_NAME = ADDON_NAME or "DungeonJournal"
SDJ.VERSION = "0.2.0"
SDJ.MEDIA = "Interface\\AddOns\\DungeonJournal\\Media\\"
SDJ.ALLIANCE_ICON = SDJ.MEDIA .. "Alliance.tga"
SDJ.HORDE_ICON = SDJ.MEDIA .. "Horde.tga"
SDJ.CHAIN_ICON = SDJ.MEDIA .. "QuestChain.tga"
SDJ.DUNGEONS = SDJ.DUNGEONS or { Vanilla = {}, TBC = {}, Wrath = {} }
SDJ.BY_ID = SDJ.BY_ID or {}

function SDJ:AddDungeon(era, data)
    if not era or not data or not data.id then return end
    self.DUNGEONS[era] = self.DUNGEONS[era] or {}
    table.insert(self.DUNGEONS[era], data)
    self.BY_ID[data.id] = data
end

function SDJ:PlayerFaction()
    if UnitFactionGroup then
        local faction = UnitFactionGroup("player")
        if faction == "Horde" then return "Horde" end
    end
    return "Alliance"
end

function SDJ:QuestMatchesFaction(quest, faction)
    if not quest then return false end
    local qf = quest.faction or "Both"
    return qf == "Both" or qf == faction
end

function SDJ:GetQuestCount(dungeon, faction)
    local count = 0
    if not dungeon or not dungeon.quests then return count end
    for _, quest in ipairs(dungeon.quests) do
        if self:QuestMatchesFaction(quest, faction) then
            count = count + 1
        end
    end
    return count
end

function SDJ:GetItemDisplay(item)
    if not item then return nil end
    local itemID = item.id or item[1]
    local fallbackName = item.name or item[2] or (itemID and ("Item " .. itemID)) or "Unknown Item"
    local name, link, quality, _, _, _, _, _, _, icon = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    if itemID and GetItemInfo then
        name, link, quality, _, _, _, _, _, _, icon = GetItemInfo(itemID)
    end
    if not icon and itemID and GetItemIcon then
        icon = GetItemIcon(itemID)
    end
    return {
        id = itemID,
        name = name or fallbackName,
        link = link,
        quality = quality or item.quality or item[4] or 1,
        icon = icon or "Interface\\Icons\\INV_Misc_QuestionMark",
        slot = item.slot or item[3] or "",
        source = item.source or "",
        rate = item.rate or item.dropRate or "",
    }
end

function SDJ:ShowItemTooltip(owner, item)
    if not owner or not item then return end
    local display = self:GetItemDisplay(item)
    if not display then return end
    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    if display.link then
        GameTooltip:SetHyperlink(display.link)
    elseif display.id then
        GameTooltip:SetHyperlink("item:" .. tostring(display.id))
    else
        GameTooltip:SetText(display.name)
    end
    GameTooltip:Show()
end

function SDJ:InsertItemLink(item)
    if not IsShiftKeyDown or not IsShiftKeyDown() then return end
    local display = self:GetItemDisplay(item)
    if not display or not display.link then return end
    if ChatEdit_GetActiveWindow and ChatEdit_InsertLink and ChatEdit_GetActiveWindow() then
        ChatEdit_InsertLink(display.link)
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function()
    DungeonJournalDB = DungeonJournalDB or {}
    DungeonJournalDB.lastEra = DungeonJournalDB.lastEra or "Vanilla"
end)

SLASH_SERVERDUNGEONJOURNAL1 = "/dj"
SLASH_SERVERDUNGEONJOURNAL2 = "/dungeonjournal"
SlashCmdList["SERVERDUNGEONJOURNAL"] = function(msg)
    if SDJ.Toggle then
        SDJ:Toggle()
    end
end
