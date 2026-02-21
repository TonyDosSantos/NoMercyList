-- =============================================================================
-- KillList.lua - Addon complet pour TBC Anniversary (Interface 20504)
-- v1.2 : colonnes Niveau + Classe, ajout via cible..

-- =============================================================================

-- ---------------------------------------------------------------------------
-- COULEURS ET NOMS DE CLASSES
-- ---------------------------------------------------------------------------
local CLASS_COLOR = {
    ["WARRIOR"]     = "C79C6E",
    ["PALADIN"]     = "F58CBA",
    ["HUNTER"]      = "ABD473",
    ["ROGUE"]       = "FFF569",
    ["PRIEST"]      = "FFFFFF",
    ["SHAMAN"]      = "0070DE",
    ["MAGE"]        = "69CCF0",
    ["WARLOCK"]     = "9482C9",
    ["DRUID"]       = "FF7D0A",
    ["DEATHKNIGHT"] = "C41F3B",
}

local CLASS_DISPLAY = {
    ["WARRIOR"]     = "Guerrier",
    ["PALADIN"]     = "Paladin",
    ["HUNTER"]      = "Chasseur",
    ["ROGUE"]       = "Voleur",
    ["PRIEST"]      = "Pretre",
    ["SHAMAN"]      = "Chaman",
    ["MAGE"]        = "Mage",
    ["WARLOCK"]     = "Demoniste",
    ["DRUID"]       = "Druide",
    ["DEATHKNIGHT"] = "Chevalier",
}

-- Coordonnées des icônes de classe dans l'atlas
local CLASS_ICON_TCOORDS = {
    ["WARRIOR"]     = {0, 0.25, 0, 0.25},
    ["MAGE"]        = {0.25, 0.49609375, 0, 0.25},
    ["ROGUE"]       = {0.49609375, 0.7421875, 0, 0.25},
    ["DRUID"]       = {0.7421875, 0.98828125, 0, 0.25},
    ["HUNTER"]      = {0, 0.25, 0.25, 0.5},
    ["SHAMAN"]      = {0.25, 0.49609375, 0.25, 0.5},
    ["PRIEST"]      = {0.49609375, 0.7421875, 0.25, 0.5},
    ["WARLOCK"]     = {0.7421875, 0.98828125, 0.25, 0.5},
    ["PALADIN"]     = {0, 0.25, 0.5, 0.75},
    ["DEATHKNIGHT"] = {0.25, 0.49609375, 0.5, 0.75},
}

-- ---------------------------------------------------------------------------
-- DONNÉES & PERSISTANCE
-- ---------------------------------------------------------------------------

-- Forward declarations (fonctions appelées avant d'être définies)
local TriggerAlert
local StartNearbyUpdates
local RefreshNearbyFrame
local UpdateNearbyEnemy

local function InitDB()
    if type(NoMercyListDB) ~= "table" then
        NoMercyListDB = {}
    end
    if type(NoMercyListDB.players) ~= "table" then
        NoMercyListDB.players = {}
    end
    if type(NoMercyListDB.minimapAngle) ~= "number" then
        NoMercyListDB.minimapAngle = 220
    end
    
    -- ========================================================================
    -- PARAMÈTRES ÉTENDUS
    -- ========================================================================
    if type(NoMercyListDB.settings) ~= "table" then
        NoMercyListDB.settings = {}
    end
    
    -- Alerte visuelle (bordure)
    if type(NoMercyListDB.settings.alert) ~= "table" then
        NoMercyListDB.settings.alert = {}
    end
    if type(NoMercyListDB.settings.alert.enabled) ~= "boolean" then
        NoMercyListDB.settings.alert.enabled = true
    end
    if type(NoMercyListDB.settings.alert.color) ~= "table" then
        NoMercyListDB.settings.alert.color = {r = 1, g = 0, b = 0}  -- Rouge
    end
    if type(NoMercyListDB.settings.alert.duration) ~= "number" then
        NoMercyListDB.settings.alert.duration = 1  -- 1 seconde
    end
    if type(NoMercyListDB.settings.alert.pulseFrequency) ~= "number" then
        NoMercyListDB.settings.alert.pulseFrequency = 0.15
    end
    
    -- Texte d'alerte
    if type(NoMercyListDB.settings.text) ~= "table" then
        NoMercyListDB.settings.text = {}
    end
    if type(NoMercyListDB.settings.text.enabled) ~= "boolean" then
        NoMercyListDB.settings.text.enabled = true
    end
    if type(NoMercyListDB.settings.text.color) ~= "table" then
        NoMercyListDB.settings.text.color = {r = 1, g = 0, b = 0}  -- Rouge
    end
    if type(NoMercyListDB.settings.text.position) ~= "string" then
        NoMercyListDB.settings.text.position = "TOP"
    end
    if type(NoMercyListDB.settings.text.size) ~= "number" then
        NoMercyListDB.settings.text.size = 24
    end
    if type(NoMercyListDB.settings.text.showClass) ~= "boolean" then
        NoMercyListDB.settings.text.showClass = true
    end
    if type(NoMercyListDB.settings.text.showRatio) ~= "boolean" then
        NoMercyListDB.settings.text.showRatio = true
    end
    if type(NoMercyListDB.settings.text.showHateLevel) ~= "boolean" then
        NoMercyListDB.settings.text.showHateLevel = true
    end
    if type(NoMercyListDB.settings.text.duration) ~= "number" then
        NoMercyListDB.settings.text.duration = 3
    end
    
    -- Son d'alerte
    if type(NoMercyListDB.settings.sound) ~= "table" then
        NoMercyListDB.settings.sound = {}
    end
    if type(NoMercyListDB.settings.sound.enabled) ~= "boolean" then
        NoMercyListDB.settings.sound.enabled = true
    end
    if type(NoMercyListDB.settings.sound.id) ~= "number" then
        NoMercyListDB.settings.sound.id = 8959  -- Raid Warning
    end
    
    -- Fréquence d'alerte (cooldown)
    if type(NoMercyListDB.settings.alertCooldown) ~= "number" then
        NoMercyListDB.settings.alertCooldown = 30
    end
    
    -- Colonnes affichées
    if type(NoMercyListDB.settings.columns) ~= "table" then
        NoMercyListDB.settings.columns = {
            name = true,
            level = true,
            class = true,
            guild = true,
            deaths = true,
            kills = true,
            ratio = true,
            hateLevel = true,
            lastSeen = true,
            delete = true,  -- Bouton de suppression
        }
    end
    
    -- Ennemis à portée
    if type(NoMercyListDB.settings.nearby) ~= "table" then
        NoMercyListDB.settings.nearby = {}
    end
    if type(NoMercyListDB.settings.nearby.maxEntries) ~= "number" then
        NoMercyListDB.settings.nearby.maxEntries = 10
    end
    if type(NoMercyListDB.settings.nearby.expireTime) ~= "number" then
        NoMercyListDB.settings.nearby.expireTime = 30
    end
    if type(NoMercyListDB.settings.nearby.scale) ~= "number" then
        NoMercyListDB.settings.nearby.scale = 1.0
    end
    if type(NoMercyListDB.settings.nearby.opacity) ~= "number" then
        NoMercyListDB.settings.nearby.opacity = 0.8
    end
    
    -- Migration : ajoute les nouveaux champs aux anciens joueurs
    for name, data in pairs(NoMercyListDB.players) do
        if not data.lastSeen then data.lastSeen = 0 end
        if not data.kills then data.kills = 0 end
        if not data.deaths then data.deaths = 0 end
        if not data.level then data.level = 0 end
        if not data.classToken then data.classToken = "" end
        if not data.hateLevel then data.hateLevel = 1 end  -- NOUVEAU : niveau de haine 1-3 (Peon/Grunt/FDP)
        if not data.guild then data.guild = "" end  -- NOUVEAU : guilde
    end
end

local function NormalizeName(name)
    if type(name) ~= "string" then return nil end
    name = name:match("^%s*(.-)%s*$")
    if name == "" then return nil end
    return name:sub(1,1):upper() .. name:sub(2):lower()
end

local function FormatRatio(kills, deaths)
    kills  = kills  or 0
    deaths = deaths or 0
    
    -- Si j'ai tué mais jamais mort → positif (kills)
    if deaths == 0 then
        return kills > 0 and tostring(kills) or "0"
    end
    
    -- Si je suis mort mais jamais tué → négatif (-deaths)
    if kills == 0 then
        return "-" .. tostring(deaths)
    end
    
    -- Sinon : kills / deaths (positif si j'ai tué plus, négatif si mort plus)
    local r = kills / deaths
    
    -- Si ratio < 1, affiche en négatif
    if r < 1 then
        r = -(deaths / kills)  -- Inverse et négatif
    end
    
    -- Formate avec 2 décimales max
    if r == math.floor(r) then
        return tostring(math.floor(r))
    else
        return string.format("%.2f", r)
    end
end

-- Ajoute un joueur. Retourne true+nom ou false+raison.
local function AddPlayerToList(name, level, classToken, guild)
    local normalized = NormalizeName(name)
    if not normalized then return false, "invalide" end
    if NoMercyListDB.players[normalized] then return false, "doublon" end
    NoMercyListDB.players[normalized] = {
        name       = normalized,
        kills      = 0,
        deaths     = 0,
        level      = level or 0,
        classToken = classToken or "",
        lastSeen   = time(),
        hateLevel  = 1,  -- Niveau de haine par défaut : 1
        guild      = guild or "",
    }
    return true, normalized
end

-- Tente de récupérer les infos d'un joueur (niveau/classe/guilde) via l'unit token
local function TryGetPlayerInfo(unitToken)
    if not unitToken or not UnitExists(unitToken) then return nil, nil, nil end
    local level = UnitLevel(unitToken)
    if level and level < 0 then level = 0 end  -- -1 = skull/boss
    local _, classToken = UnitClass(unitToken)
    local guild = GetGuildInfo(unitToken) or ""
    return level, classToken, guild
end

-- Met à jour le lastSeen d'un joueur (si dans la liste)
local function UpdateLastSeen(name, unitToken)
    -- Vérifications directes sans appeler PlayerInList
    if not name or type(name) ~= "string" then
        return false
    end
    
    if not NoMercyListDB or not NoMercyListDB.players then
        return false
    end
    
    if not NoMercyListDB.players[name] then
        return false
    end
    
    -- Mise à jour directe du lastSeen
    NoMercyListDB.players[name].lastSeen = time()
    
    -- NOUVEAU : Mise à jour niveau et guilde si on a un unitToken
    if unitToken and UnitExists(unitToken) then
        local level, classToken, guild = TryGetPlayerInfo(unitToken)
        
        if level and level > 0 then
            NoMercyListDB.players[name].level = level
        end
        
        if classToken and classToken ~= "" then
            NoMercyListDB.players[name].classToken = classToken
        end
        
        if guild and guild ~= "" then
            NoMercyListDB.players[name].guild = guild
        end
    end
    
    -- Force refresh si fenêtre ouverte
    if mainFrame and mainFrame:IsShown() then
        NoMercyList_Refresh()
    end
    
    return true
end

-- Formate un timestamp en texte lisible (ex: "il y a 2h", "maintenant")
local function FormatLastSeen(timestamp)
    if not timestamp or timestamp == 0 then
        return "Jamais"
    end
    
    local now = time()
    if not now then return "Jamais" end
    
    local elapsed = now - timestamp
    
    if elapsed < 0 then
        return "Jamais"
    elseif elapsed < 60 then
        return "Maintenant"
    elseif elapsed < 3600 then
        return string.format("Il y a %d min", math.floor(elapsed / 60))
    elseif elapsed < 86400 then
        return string.format("Il y a %d h", math.floor(elapsed / 3600))
    else
        return string.format("Il y a %d j", math.floor(elapsed / 86400))
    end
end

-- ---------------------------------------------------------------------------
-- ÉVÉNEMENTS & COMPTAGE
-- ---------------------------------------------------------------------------

-- Base de données SavedVariables
NoMercyListDB = NoMercyListDB or {}

local PLAYER_NAME = nil
local lastHitBy   = {}

-- Historique des attaquants : table des joueurs qui m'ont attaqué récemment
-- Structure : attackerHistory[playerName] = { name, classToken, level, lastAttackTime }
local attackerHistory = {}
local HISTORY_DURATION = 300  -- 5 minutes en secondes
local lastDamageDealer = nil  -- Dernier joueur qui m'a fait des dégâts
local lastDamageTime = 0

local function IsHostilePlayer(flags)
    if not flags then return false end
    return (bit.band(flags, 0x400) > 0) and (bit.band(flags, 0x40) > 0)
end

-- Enregistre un attaquant hostile dans l'historique
-- outcome: "killed_me" | "killed_by_me" | "attacked" | nil
local function RecordAttacker(name, flags, outcome, level, classToken)
    if not name or name == PLAYER_NAME then return end
    if not IsHostilePlayer(flags) then return end
    
    -- Récupère les infos si c'est un nouveau attaquant ou met à jour
    if not attackerHistory[name] then
        attackerHistory[name] = {
            name           = name,
            classToken     = classToken or "",
            level          = level or 0,
            lastAttackTime = GetTime(),
            killedMe       = 0,  -- Nombre de fois qu'il m'a tué
            killedByMe     = 0,  -- Nombre de fois que je l'ai tué
            lastOutcome    = outcome or "attacked",  -- Dernier événement
        }
    else
        -- Met à jour le timestamp et les infos si disponibles
        attackerHistory[name].lastAttackTime = GetTime()
        if classToken and classToken ~= "" then
            attackerHistory[name].classToken = classToken
        end
        if level and level > 0 then
            attackerHistory[name].level = level
        end
        if outcome then
            attackerHistory[name].lastOutcome = outcome
            if outcome == "killed_me" then
                attackerHistory[name].killedMe = (attackerHistory[name].killedMe or 0) + 1
            elseif outcome == "killed_by_me" then
                attackerHistory[name].killedByMe = (attackerHistory[name].killedByMe or 0) + 1
            end
        end
    end
end

-- Tente de récupérer les infos d'un joueur (niveau/classe/guilde) via l'unit token
-- Nettoie l'historique (supprime les entrées > 5 minutes)
local function CleanupAttackerHistory()
    local now = GetTime()
    for name, data in pairs(attackerHistory) do
        if (now - data.lastAttackTime) > HISTORY_DURATION then
            attackerHistory[name] = nil
        end
    end
end

-- Retourne la liste des attaquants récents (< 5 min), triée par temps décroissant
local function GetRecentAttackers()
    CleanupAttackerHistory()
    local list = {}
    local count = 0
    for _, data in pairs(attackerHistory) do
        table.insert(list, data)
        count = count + 1
    end
    -- Tri : plus récent en premier
    table.sort(list, function(a, b)
        return a.lastAttackTime > b.lastAttackTime
    end)
    return list
end

local function PlayerInList(name)
    if not NoMercyListDB or not NoMercyListDB.players then 
        return false
    end
    return NoMercyListDB.players[name] ~= nil
end

-- Helper sécurisé pour éviter les erreurs
local function SafePlayerInList(name)
    if not name or type(name) ~= "string" then
        return false
    end
    local success, result = pcall(PlayerInList, name)
    if not success then
        return false
    end
    return result
end

local function AddKill(name)
    if PlayerInList(name) then
        NoMercyListDB.players[name].kills = (NoMercyListDB.players[name].kills or 0) + 1
        return true
    end
    return false
end

local function AddDeath(killerName)
    if SafePlayerInList(killerName) then
        NoMercyListDB.players[killerName].deaths = (NoMercyListDB.players[killerName].deaths or 0) + 1
        return true
    end
    return false
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == "KillList" then InitDB() end

    elseif event == "PLAYER_LOGIN" then
        InitDB()
        PLAYER_NAME = UnitName("player")
        NoMercyList_BuildUI()
        NoMercyList_BuildMinimap()
        NoMercyList_BuildNearbyFrame()
        StartNearbyUpdates()
        NoMercyList_StartNearbyScan()

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        if not PLAYER_NAME then return end
        local timestamp, subEvent, hideCaster,
              srcGUID, srcName, srcFlags, srcRaidFlags,
              dstGUID, dstName, dstFlags, dstRaidFlags = CombatLogGetCurrentEventInfo()
        
        if not subEvent then return end
            
            -- Debug : affiche TOUS les events qui concernent le joueur (DÉSACTIVÉ en prod)
            -- if srcName == PLAYER_NAME or dstName == PLAYER_NAME then
            --     print("|cffaaaaff[COMBAT_LOG]|r " .. subEvent .. " src=" .. tostring(srcName) .. " dst=" .. tostring(dstName))
            -- end

        -- =====================================================================
        -- DÉTECTION ÉLARGIE : N'IMPORTE QUELLE ACTION D'UN JOUEUR DE LA LISTE
        -- =====================================================================
        
        -- Si la SOURCE est un joueur hostile de la liste (il fait une action)
        if srcName and IsHostilePlayer(srcFlags) then
            if subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" 
            or subEvent == "SPELL_PERIODIC_DAMAGE" or subEvent == "RANGE_DAMAGE"
            or subEvent == "SPELL_CAST_START" or subEvent == "SPELL_CAST_SUCCESS"
            or subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_HEAL" then
                
                if SafePlayerInList(srcName) then
                    UpdateLastSeen(srcName)
                    TriggerAlert(srcName, "target")
                end
            end
        end
        
        -- Si la DESTINATION est un joueur hostile de la liste (il subit une action)
        if dstName and IsHostilePlayer(dstFlags) then
            if subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" 
            or subEvent == "SPELL_PERIODIC_DAMAGE" or subEvent == "RANGE_DAMAGE"
            or subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_HEAL" then
                
                if SafePlayerInList(dstName) then
                    UpdateLastSeen(dstName)
                    TriggerAlert(dstName, "target")
                end
            end
        end

        -- =====================================================================
        -- ENREGISTREMENT HISTORIQUE : Attaques contre moi
        -- =====================================================================
        if dstName == PLAYER_NAME then
            if subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE"
            or subEvent == "SPELL_PERIODIC_DAMAGE" or subEvent == "RANGE_DAMAGE" then
                
                -- Tente de récupérer niveau/classe si c'est la cible
                local level, classToken = nil, nil
                if UnitName("target") == srcName then
                    level, classToken = TryGetPlayerInfo("target")
                end
                
                RecordAttacker(srcName, srcFlags, "attacked", level, classToken)
                
                -- Si c'est un joueur de la liste qui m'attaque : alerte + lastSeen
                if srcName and SafePlayerInList(srcName) then
                    UpdateLastSeen(srcName)
                    TriggerAlert(srcName, "target")
                end
            end
        end
        
        -- =====================================================================
        -- ENREGISTREMENT HISTORIQUE : Mes attaques
        -- =====================================================================
        if srcName == PLAYER_NAME and dstName then
            if subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE"
            or subEvent == "SPELL_PERIODIC_DAMAGE" or subEvent == "RANGE_DAMAGE" then
                -- Si c'est un joueur hostile, on l'enregistre
                if IsHostilePlayer(dstFlags) then
                    local level, classToken = nil, nil
                    if UnitName("target") == dstName then
                        level, classToken = TryGetPlayerInfo("target")
                    end
                    RecordAttacker(dstName, dstFlags, "attacked", level, classToken)
                end
                
                -- Si dans la liste : log
                if SafePlayerInList(dstName) then
                    -- Alerte déjà gérée plus haut dans la détection élargie
                end
            end
        end

        -- Mémorise le dernier attaquant pour chaque victime (pour UNIT_DIED fallback)
        if subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE"
        or subEvent == "SPELL_PERIODIC_DAMAGE" or subEvent == "RANGE_DAMAGE" then
            if srcName and dstName then 
                lastHitBy[dstName] = srcName 
                
                -- Track spécifique : dernier qui M'A fait des dégâts
                if dstName == PLAYER_NAME and IsHostilePlayer(srcFlags) then
                    lastDamageDealer = srcName
                    lastDamageTime = GetTime()
                end
            end
        end

        -- =====================================================================
        -- PARTY_KILL / UNIT_DIED : tracking des kills/morts
        -- =====================================================================
        if subEvent == "PARTY_KILL" or subEvent == "UNIT_DIED" then
            
            -- Je tue un joueur hostile (PARTY_KILL uniquement)
            if subEvent == "PARTY_KILL" and srcName == PLAYER_NAME and IsHostilePlayer(dstFlags) then
                local level, classToken = nil, nil
                if UnitName("target") == dstName then
                    level, classToken = TryGetPlayerInfo("target")
                end
                RecordAttacker(dstName, dstFlags, "killed_by_me", level, classToken)
                
                if AddKill(dstName) then
                    NoMercyList_Refresh()
                end
            end
            
            -- Un joueur hostile me tue (UNIT_DIED quand je meurs)
            if dstName == PLAYER_NAME then
                local killer = srcName  -- Peut être nil dans UNIT_DIED
                
                -- Si srcName est nil, utilise le dernier qui m'a fait des dégâts
                if not killer and lastDamageDealer then
                    local timeSinceLastDamage = GetTime() - lastDamageTime
                    if timeSinceLastDamage < 10 then  -- Max 10 secondes
                        killer = lastDamageDealer
                    end
                end
                
                if killer and AddDeath(killer) then
                    NoMercyList_Refresh()
                end
            end
        end
    end
end)

-- ---------------------------------------------------------------------------
-- SYSTÈME D'ALERTES
-- ---------------------------------------------------------------------------

local alertFrame = nil           -- Frame pour le flash de bordure
local detectedPlayers = {}       -- Cache des joueurs détectés récemment (pour éviter spam)
local ALERT_COOLDOWN = 30        -- 30 secondes entre deux alertes pour le même joueur (au lieu de 10)

-- Crée le frame de flash violet (bordure de l'écran)
local function CreateAlertFlash()
    if alertFrame then return end
    
    alertFrame = CreateFrame("Frame", "KillListAlertFrame", UIParent)
    alertFrame:SetAllPoints(UIParent)
    alertFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    alertFrame:Hide()
    
    -- Bordure violette épaisse
    local thickness = 8
    
    -- Haut
    local top = alertFrame:CreateTexture(nil, "OVERLAY")
    top:SetColorTexture(0.6, 0.1, 0.8, 0.7)  -- violet
    top:SetPoint("TOPLEFT", alertFrame, "TOPLEFT", 0, 0)
    top:SetPoint("TOPRIGHT", alertFrame, "TOPRIGHT", 0, 0)
    top:SetHeight(thickness)
    
    -- Bas
    local bottom = alertFrame:CreateTexture(nil, "OVERLAY")
    bottom:SetColorTexture(0.6, 0.1, 0.8, 0.7)
    bottom:SetPoint("BOTTOMLEFT", alertFrame, "BOTTOMLEFT", 0, 0)
    bottom:SetPoint("BOTTOMRIGHT", alertFrame, "BOTTOMRIGHT", 0, 0)
    bottom:SetHeight(thickness)
    
    -- Gauche
    local left = alertFrame:CreateTexture(nil, "OVERLAY")
    left:SetColorTexture(0.6, 0.1, 0.8, 0.7)
    left:SetPoint("TOPLEFT", alertFrame, "TOPLEFT", 0, 0)
    left:SetPoint("BOTTOMLEFT", alertFrame, "BOTTOMLEFT", 0, 0)
    left:SetWidth(thickness)
    
    -- Droite
    local right = alertFrame:CreateTexture(nil, "OVERLAY")
    right:SetColorTexture(0.6, 0.1, 0.8, 0.7)
    right:SetPoint("TOPRIGHT", alertFrame, "TOPRIGHT", 0, 0)
    right:SetPoint("BOTTOMRIGHT", alertFrame, "BOTTOMRIGHT", 0, 0)
    right:SetWidth(thickness)
    
    alertFrame.textures = {top, bottom, left, right}
end

-- Déclenche le flash violet
local function TriggerScreenFlash()
    -- Vérifie si l'alerte bordure est activée
    if not NoMercyListDB.settings.alert.enabled then
        return
    end
    
    if not alertFrame then CreateAlertFlash() end
    
    -- Récupère les paramètres depuis la nouvelle structure
    local color = NoMercyListDB.settings.alert.color
    local duration = NoMercyListDB.settings.alert.duration
    local pulseFreq = NoMercyListDB.settings.alert.pulseFrequency
    
    -- Met à jour la couleur des bordures
    for _, tex in ipairs(alertFrame.textures) do
        tex:SetColorTexture(color.r, color.g, color.b, 0.7)
    end
    
    alertFrame:Show()
    
    -- Animation de clignotement pendant la durée configurée
    local totalTime = 0
    local flashTimer = 0
    
    alertFrame:SetScript("OnUpdate", function(self, elapsed)
        totalTime = totalTime + elapsed
        flashTimer = flashTimer + elapsed
        
        if flashTimer >= pulseFreq then
            flashTimer = 0
            
            -- Alterne visible/invisible
            local visible = self.textures[1]:GetAlpha() > 0
            local alpha = visible and 0 or 0.7
            for _, tex in ipairs(self.textures) do
                tex:SetAlpha(alpha)
            end
        end
        
        -- Arrête après la durée totale configurée
        if totalTime >= duration then
            self:SetScript("OnUpdate", nil)
            self:Hide()
        end
    end)
end

-- Fonction principale d'alerte
-- Frame pour l'affichage du texte d'alerte
local alertTextFrame = nil

local function ShowAlertText(message, hateLevel)
    -- Vérifie si l'alerte texte est activée
    if not NoMercyListDB.settings.text.enabled then
        return
    end
    
    if not alertTextFrame then
        alertTextFrame = CreateFrame("Frame", "NoMercyListAlertText", UIParent)
        alertTextFrame:SetSize(800, 150)  -- Augmenté pour contenir l'image
        alertTextFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        
        alertTextFrame.text = alertTextFrame:CreateFontString(nil, "OVERLAY")
        alertTextFrame.text:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE")
        alertTextFrame.text:SetPoint("TOP", alertTextFrame, "TOP", 0, -10)
        alertTextFrame.text:SetSize(800, 50)
        alertTextFrame.text:SetJustifyH("CENTER")
        alertTextFrame.text:SetJustifyV("TOP")
        
        -- Texture pour l'icône de haine
        alertTextFrame.hateIcon = alertTextFrame:CreateTexture(nil, "ARTWORK")
        alertTextFrame.hateIcon:SetSize(64, 64)  -- Grande taille pour l'alerte
        alertTextFrame.hateIcon:SetPoint("TOP", alertTextFrame.text, "BOTTOM", 0, -10)
    end
    
    -- Position selon les paramètres
    alertTextFrame:ClearAllPoints()
    local pos = NoMercyListDB.settings.text.position
    if pos == "TOP" then
        alertTextFrame:SetPoint("TOP", UIParent, "TOP", 0, -150)
    elseif pos == "BOTTOM" then
        alertTextFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
    else  -- CENTER
        alertTextFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
    end
    
    -- Taille et couleur selon paramètres
    local size = NoMercyListDB.settings.text.size
    local color = NoMercyListDB.settings.text.color
    alertTextFrame.text:SetFont("Fonts\\FRIZQT__.TTF", size, "OUTLINE")
    alertTextFrame.text:SetTextColor(color.r, color.g, color.b, 1)
    alertTextFrame.text:SetText(message)
    
    -- Affiche l'icône de haine si fournie
    if hateLevel and NoMercyListDB.settings.text.showHateLevel then
        local texture
        if hateLevel >= 3 then
            texture = "Interface\\AddOns\\NoMercyList\\Textures\\tdmL"
        elseif hateLevel >= 2 then
            texture = "Interface\\AddOns\\NoMercyList\\Textures\\pouleL"
        else
            texture = "Interface\\AddOns\\NoMercyList\\Textures\\poussinL"
        end
        alertTextFrame.hateIcon:SetTexture(texture)
        alertTextFrame.hateIcon:Show()
    else
        alertTextFrame.hateIcon:Hide()
    end
    
    alertTextFrame:Show()
    
    -- Cache après la durée configurée
    local textDuration = NoMercyListDB.settings.text.duration or 3
    C_Timer.After(textDuration, function()
        if alertTextFrame then alertTextFrame:Hide() end
    end)
end

-- Fonction principale d'alerte
TriggerAlert = function(playerName, unitToken)
    if not playerName then return end
    
    -- Cooldown : utilise le paramètre configurable
    local now = GetTime()
    local cooldown = NoMercyListDB.settings.alertCooldown or ALERT_COOLDOWN
    if detectedPlayers[playerName] and (now - detectedPlayers[playerName]) < cooldown then
        return  -- Déjà alerté récemment
    end
    
    detectedPlayers[playerName] = now
    
    -- Déclenche les alertes visuelles
    TriggerScreenFlash()
    
    -- Son d'alerte (utilise le paramètre configurable)
    if NoMercyListDB.settings.sound.enabled then
        local soundId = NoMercyListDB.settings.sound.id or 8959
        PlaySound(soundId, "Master")
    end
    
    -- Construit le message d'alerte
    local playerData = NoMercyListDB.players[playerName]
    if playerData then
        -- Construit le texte selon les options activées
        local textParts = {playerName}
        
        -- Classe
        if NoMercyListDB.settings.text.showClass and playerData.classToken and playerData.classToken ~= "" then
            local hex = CLASS_COLOR[playerData.classToken]
            local displayClass = CLASS_DISPLAY[playerData.classToken] or playerData.classToken
            if hex then
                table.insert(textParts, "|cff" .. hex .. displayClass .. "|r")
            else
                table.insert(textParts, displayClass)
            end
        end
        
        -- Ratio
        if NoMercyListDB.settings.text.showRatio then
            local ratio = FormatRatio(playerData.kills, playerData.deaths)
            table.insert(textParts, "Ratio: " .. ratio)
        end
        
        local alertMsg = table.concat(textParts, " | ")
        
        -- Récupère le niveau de haine pour l'image
        local hateLevel = playerData.hateLevel or 1
        
        -- Affiche le texte au centre de l'écran avec l'image de haine
        ShowAlertText(alertMsg, hateLevel)
    end
end

-- ---------------------------------------------------------------------------
-- SCAN MULTI-SOURCES DES JOUEURS PROCHES
-- Combine plusieurs méthodes pour détecter un maximum de joueurs
-- ---------------------------------------------------------------------------

local scanFrame = nil
local SCAN_INTERVAL = 0.5  -- Scan rapide toutes les 0.5 secondes

function NoMercyList_StartNearbyScan()
    if scanFrame then return end
    
    scanFrame = CreateFrame("Frame")
    local timeSinceLastScan = 0
    
    scanFrame:SetScript("OnUpdate", function(self, elapsed)
        timeSinceLastScan = timeSinceLastScan + elapsed
        
        if timeSinceLastScan >= SCAN_INTERVAL then
            timeSinceLastScan = 0
            NoMercyList_ScanNearbyPlayers()
        end
    end)
end

function NoMercyList_ScanNearbyPlayers()
    if not PLAYER_NAME then return end
    
    local detected = {}  -- Cache pour éviter de traiter le même joueur 2 fois
    
    -- =========================================================================
    -- MÉTHODE 1 : TARGET / FOCUS / MOUSEOVER
    -- =========================================================================
    for _, unit in ipairs({"target", "focus", "mouseover"}) do
        if UnitExists(unit) and UnitIsPlayer(unit) and UnitIsEnemy("player", unit) then
            local name = UnitName(unit)
            if name and not detected[name] then
                detected[name] = true
                if SafePlayerInList(name) then
                    -- UpdateLastSeen met à jour lastSeen + niveau + classe + guilde
                    UpdateLastSeen(name, unit)
                    TriggerAlert(name, unit)
                    
                    -- Met à jour la liste "Ennemis à portée" (v1.1)
                    local playerData = NoMercyListDB.players[name]
                    if playerData then
                        UpdateNearbyEnemy(name, playerData, unit)  -- Passe le unitID
                    end
                end
            end
        end
    end
    
    -- =========================================================================
    -- MÉTHODE 2 : NAMEPLATES (API TBC)
    -- Sur TBC, on peut itérer sur les nameplates visibles
    -- =========================================================================
    -- Essai 1 : WorldFrame children (contient les nameplates)
    local numChildren = WorldFrame:GetNumChildren()
    local children = {WorldFrame:GetChildren()}
    
    for i = 1, numChildren do
        local frame = children[i]
        if frame and frame:GetName() and frame:GetName():find("NamePlate") then
            -- Sur TBC, chaque nameplate a un healthbar
            local healthBar = frame:GetChildren()
            if healthBar and healthBar.unit then
                local unit = healthBar.unit
                if UnitExists(unit) and UnitIsPlayer(unit) and UnitIsEnemy("player", unit) then
                    local name = UnitName(unit)
                    if name and not detected[name] then
                        detected[name] = true
                        if SafePlayerInList(name) then
                            -- UpdateLastSeen met à jour lastSeen + niveau + classe + guilde
                            UpdateLastSeen(name, unit)
                            TriggerAlert(name, unit)
                            
                            -- Met à jour la liste "Ennemis à portée" avec le unitID du nameplate (v1.1)
                            local playerData = NoMercyListDB.players[name]
                            if playerData then
                                UpdateNearbyEnemy(name, playerData, unit)  -- Passe le unitID du nameplate
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- =========================================================================
    -- MÉTHODE 3 : Tooltip scanning (méthode alternative pour nameplates TBC)
    -- =========================================================================
    -- Sur TBC Classic, on peut créer un tooltip scanner
    if not NoMercyList_ScanTooltip then
        NoMercyList_ScanTooltip = CreateFrame("GameTooltip", "KillListScanTooltip", nil, "GameTooltipTemplate")
        NoMercyList_ScanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    end
    
    -- Cette méthode est coûteuse, on la fait moins souvent
    -- (déjà couverte par les autres méthodes de toute façon)
end

-- Met à jour lastSeen quand on attaque/tue quelqu'un de la liste
local function UpdateLastSeenFromCombat(name)
    if name and PlayerInList(name) then
        UpdateLastSeen(name)
        -- Refresh l'UI si la fenêtre est ouverte
        if mainFrame and mainFrame:IsShown() then
            NoMercyList_Refresh()
        end
    end
end

-- ---------------------------------------------------------------------------
-- MENU DROPDOWN NIVEAU DE HAINE
-- ---------------------------------------------------------------------------

local hateDropdown = CreateFrame("Frame", "NoMercyListHateDropdown", UIParent, "UIDropDownMenuTemplate")

function NoMercyList_ShowHateMenu(button, playerName)
    if not playerName or not NoMercyListDB.players[playerName] then 
        print("|cffff0000[Debug]|r playerName invalide: " .. tostring(playerName))
        return 
    end
    
    local function OnClick(self)
        NoMercyListDB.players[playerName].hateLevel = self.value
        NoMercyList_Refresh()
        CloseDropDownMenus()
    end
    
    local function Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        
        -- Niveau 1 : Peon
        info.text = "Peon"
        info.value = 1
        info.func = OnClick
        info.checked = (NoMercyListDB.players[playerName].hateLevel == 1)
        UIDropDownMenu_AddButton(info)
        
        -- Niveau 2 : Grunt
        info.text = "Grunt"
        info.value = 2
        info.func = OnClick
        info.checked = (NoMercyListDB.players[playerName].hateLevel == 2)
        UIDropDownMenu_AddButton(info)
        
        -- Niveau 3 : FDP
        info.text = "FDP"
        info.value = 3
        info.func = OnClick
        info.checked = (NoMercyListDB.players[playerName].hateLevel == 3)
        UIDropDownMenu_AddButton(info)
    end
    
    UIDropDownMenu_Initialize(hateDropdown, Initialize)
    ToggleDropDownMenu(1, nil, hateDropdown, button, 0, 0)
end

-- ---------------------------------------------------------------------------
-- UI — CONSTANTES
-- ---------------------------------------------------------------------------

local mainFrame   = nil
local scrollChild = nil
local rowFrames   = {}

local WIN_H = 440
local WIN_W_DEFAULT = 1050  -- Largeur par défaut (sera ajustée dynamiquement)
local PAD   = 12
local ROW_H = 28
local HDR_H = 30

-- Largeurs des colonnes (utilisées pour le calcul dynamique)
local COLUMN_WIDTHS = {
    name = 120,
    level = 50,
    class = 120,
    guild = 100,
    deaths = 55,
    kills = 55,
    ratio = 55,
    hateLevel = 80,
    lastSeen = 160,
    delete = 45,  -- Un peu plus large pour centrer le X
}

local COLUMN_SPACING = 7

-- Crée un FontString caché pour mesurer précisément les largeurs de texte
local measureFrame = CreateFrame("Frame")
local measureText = measureFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

-- Fonction pour calculer la largeur réelle d'un texte
local function GetTextWidth(text, fontSize)
    if not text or text == "" then return 0 end
    measureText:SetFont("Fonts\\FRIZQT__.TTF", fontSize or 12, "")
    measureText:SetText(text)
    return measureText:GetStringWidth()
end

-- Calcule les largeurs optimales de colonnes selon le contenu
local function CalculateOptimalColumnWidths()
    local widths = {
        name = 80,      -- Minimum pour le header "Nom du joueur"
        level = 50,     -- Fixe : assez pour "Niveau" + 2 chiffres
        class = 80,     -- Minimum pour les noms de classe
        guild = 100,    -- FIXE : garde le comportement actuel (wrap sur 2 lignes)
        deaths = 55,    -- Fixe : assez pour "Morts" + chiffres
        kills = 55,     -- Fixe : assez pour "Kills" + chiffres
        ratio = 55,     -- Fixe : assez pour "Ratio" + "99.99"
        hateLevel = 35, -- Fixe : 25px icône + 10px marge
        lastSeen = 120, -- Minimum pour le header
        delete = 45,    -- Fixe
    }
    
    local MARGIN = 10  -- 5px de chaque côté
    
    -- Headers widths (mesurés précisément)
    local headerWidths = {
        name = GetTextWidth("Nom du joueur", 11) + MARGIN,
        class = GetTextWidth("Classe", 11) + MARGIN,
        lastSeen = GetTextWidth("Derniere vue", 11) + MARGIN,
    }
    
    -- Parcourt tous les joueurs pour trouver la largeur max
    if NoMercyListDB and NoMercyListDB.players then
        for _, data in pairs(NoMercyListDB.players) do
            -- Nom (police 12)
            local nameWidth = GetTextWidth(data.name, 12) + MARGIN
            if nameWidth > widths.name then
                widths.name = nameWidth
            end
            
            -- Classe (police 11) - avec les codes couleur
            if data.classToken and data.classToken ~= "" then
                local className = CLASS_DISPLAY[data.classToken] or data.classToken
                -- Mesure sans les codes couleur (|cff...)
                local classWidth = GetTextWidth(className, 11) + MARGIN
                if classWidth > widths.class then
                    widths.class = classWidth
                end
            end
            
            -- Dernière vue (police 10)
            local lastSeenStr = FormatLastSeen(data.lastSeen or 0)
            local lastSeenWidth = GetTextWidth(lastSeenStr, 10) + MARGIN
            if lastSeenWidth > widths.lastSeen then
                widths.lastSeen = lastSeenWidth
            end
        end
    end
    
    -- S'assure que les colonnes sont au moins aussi larges que leurs headers
    if headerWidths.name > widths.name then widths.name = headerWidths.name end
    if headerWidths.class > widths.class then widths.class = headerWidths.class end
    if headerWidths.lastSeen > widths.lastSeen then widths.lastSeen = headerWidths.lastSeen end
    
    -- Limite les largeurs max pour éviter des colonnes énormes
    widths.name = math.min(widths.name, 200)
    widths.class = math.min(widths.class, 150)
    widths.lastSeen = math.min(widths.lastSeen, 130)  -- Réduit pour "Il y a XX h/min"
    
    return widths
end

-- Largeurs par défaut (seront recalculées dynamiquement)
local COLUMN_WIDTHS = {
    name = 120,
    level = 50,
    class = 120,
    guild = 100,
    deaths = 55,
    kills = 55,
    ratio = 55,
    hateLevel = 35,  -- 25px icône + 10px marge
    lastSeen = 160,
    delete = 45,
}

-- Calcule la largeur de fenêtre nécessaire selon les colonnes actives
local function CalculateWindowWidth()
    -- Sécurité : si settings pas encore initialisés, retourne largeur par défaut
    if not NoMercyListDB or not NoMercyListDB.settings or not NoMercyListDB.settings.columns then
        return WIN_W_DEFAULT
    end
    
    local cols = NoMercyListDB.settings.columns
    local width = PAD * 2 + 8  -- Padding gauche/droite + marge initiale
    
    -- Nom (toujours affiché)
    width = width + COLUMN_WIDTHS.name + COLUMN_SPACING
    
    -- Autres colonnes selon settings
    if cols.level then width = width + COLUMN_WIDTHS.level + COLUMN_SPACING end
    if cols.class then width = width + COLUMN_WIDTHS.class + COLUMN_SPACING end
    if cols.guild then width = width + COLUMN_WIDTHS.guild + COLUMN_SPACING end
    if cols.deaths then width = width + COLUMN_WIDTHS.deaths + COLUMN_SPACING end
    if cols.kills then width = width + COLUMN_WIDTHS.kills + COLUMN_SPACING end
    if cols.ratio then width = width + COLUMN_WIDTHS.ratio + COLUMN_SPACING end
    if cols.hateLevel then width = width + COLUMN_WIDTHS.hateLevel + COLUMN_SPACING end
    if cols.lastSeen then width = width + COLUMN_WIDTHS.lastSeen + COLUMN_SPACING end
    if cols.delete then width = width + COLUMN_WIDTHS.delete + COLUMN_SPACING end
    
    -- Ajoute une marge finale à droite pour l'esthétique (15px)
    width = width + 15
    
    -- Minimum 400px, maximum 1200px
    return math.max(400, math.min(width, 1200))
end

-- Positions X de chaque colonne dans le scrollChild
-- Ces positions sont maintenant calculées dynamiquement dans Refresh
local COL = {
    name      =   8,
    level     = 135,
    class     = 192,
    guild     = 318,
    deaths    = 424,
    kills     = 485,
    ratio     = 546,
    hateLevel = 607,
    lastSeen  = 693,
    del       = 860,
}

local function MakeText(parent, txt, size, layer)
    local fs = parent:CreateFontString(nil, layer or "OVERLAY", "GameFontNormal")
    fs:SetFont("Fonts\\FRIZQT__.TTF", size or 12, "")
    fs:SetText(txt or "")
    return fs
end

-- ---------------------------------------------------------------------------
-- REFRESH
-- ---------------------------------------------------------------------------

function NoMercyList_Refresh()
    if not mainFrame or not mainFrame:IsShown() then return end
    if not NoMercyListDB or not NoMercyListDB.players then return end
    
    -- RECALCUL DES LARGEURS DE COLONNES SELON LE CONTENU
    COLUMN_WIDTHS = CalculateOptimalColumnWidths()
    
    -- CALCUL ET APPLICATION DE LA LARGEUR DYNAMIQUE
    local newWidth = CalculateWindowWidth()
    mainFrame:SetWidth(newWidth)
    
    -- Ajuste aussi la largeur du scrollChild
    if scrollChild then
        scrollChild:SetWidth(newWidth - PAD * 2 - 22)
    end
    
    -- REPOSITIONNEMENT DYNAMIQUE DES HEADERS
    if mainFrame.headers then
        local cols = NoMercyListDB.settings.columns
        local currentX = COL.name
        
        -- Utilise les largeurs recalculées
        local widths = COLUMN_WIDTHS
        local spacing = COLUMN_SPACING
        
        -- Nom (toujours affiché)
        if mainFrame.headers.name then
            mainFrame.headers.name:ClearAllPoints()
            mainFrame.headers.name:SetPoint("LEFT", mainFrame.headers.name:GetParent(), "LEFT", currentX, 0)
            mainFrame.headers.name:SetWidth(widths.name)  -- Ajuste la largeur du header
            mainFrame.headers.name:Show()
        end
        currentX = COL.name + widths.name + spacing
        
        -- Niveau
        if mainFrame.headers.level then
            if cols.level then
                mainFrame.headers.level:ClearAllPoints()
                mainFrame.headers.level:SetPoint("LEFT", mainFrame.headers.level:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.level:Show()
                currentX = currentX + widths.level + spacing
            else
                mainFrame.headers.level:Hide()
            end
        end
        
        -- Classe
        if mainFrame.headers.class then
            if cols.class then
                mainFrame.headers.class:ClearAllPoints()
                mainFrame.headers.class:SetPoint("LEFT", mainFrame.headers.class:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.class:SetWidth(widths.class)  -- Ajuste la largeur
                mainFrame.headers.class:Show()
                currentX = currentX + widths.class + spacing
            else
                mainFrame.headers.class:Hide()
            end
        end
        
        -- Guilde
        if mainFrame.headers.guild then
            if cols.guild then
                mainFrame.headers.guild:ClearAllPoints()
                mainFrame.headers.guild:SetPoint("LEFT", mainFrame.headers.guild:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.guild:Show()
                currentX = currentX + widths.guild + spacing
            else
                mainFrame.headers.guild:Hide()
            end
        end
        
        -- Morts
        if mainFrame.headers.deaths then
            if cols.deaths then
                mainFrame.headers.deaths:ClearAllPoints()
                mainFrame.headers.deaths:SetPoint("LEFT", mainFrame.headers.deaths:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.deaths:Show()
                currentX = currentX + widths.deaths + spacing
            else
                mainFrame.headers.deaths:Hide()
            end
        end
        
        -- Kills
        if mainFrame.headers.kills then
            if cols.kills then
                mainFrame.headers.kills:ClearAllPoints()
                mainFrame.headers.kills:SetPoint("LEFT", mainFrame.headers.kills:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.kills:Show()
                currentX = currentX + widths.kills + spacing
            else
                mainFrame.headers.kills:Hide()
            end
        end
        
        -- Ratio
        if mainFrame.headers.ratio then
            if cols.ratio then
                mainFrame.headers.ratio:ClearAllPoints()
                mainFrame.headers.ratio:SetPoint("LEFT", mainFrame.headers.ratio:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.ratio:Show()
                currentX = currentX + widths.ratio + spacing
            else
                mainFrame.headers.ratio:Hide()
            end
        end
        
        -- Niveau de haine
        if mainFrame.headers.hateLevel then
            if cols.hateLevel then
                mainFrame.headers.hateLevel:ClearAllPoints()
                mainFrame.headers.hateLevel:SetPoint("LEFT", mainFrame.headers.hateLevel:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.hateLevel:Show()
                currentX = currentX + widths.hateLevel + spacing
            else
                mainFrame.headers.hateLevel:Hide()
            end
        end
        
        -- Dernière vue
        if mainFrame.headers.lastSeen then
            if cols.lastSeen then
                mainFrame.headers.lastSeen:ClearAllPoints()
                mainFrame.headers.lastSeen:SetPoint("LEFT", mainFrame.headers.lastSeen:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.lastSeen:SetWidth(widths.lastSeen)  -- Ajuste la largeur
                mainFrame.headers.lastSeen:Show()
                currentX = currentX + widths.lastSeen + spacing
            else
                mainFrame.headers.lastSeen:Hide()
            end
        end
        
        -- Delete
        if mainFrame.headers.delete then
            if cols.delete then
                mainFrame.headers.delete:ClearAllPoints()
                mainFrame.headers.delete:SetPoint("LEFT", mainFrame.headers.delete:GetParent(), "LEFT", currentX, 0)
                mainFrame.headers.delete:Show()
                currentX = currentX + widths.delete + spacing
            else
                mainFrame.headers.delete:Hide()
            end
        end
    end

    local sorted = {}
    for _, data in pairs(NoMercyListDB.players) do
        table.insert(sorted, data)
    end
    table.sort(sorted, function(a, b) return a.name < b.name end)

    local count = #sorted
    scrollChild:SetHeight(math.max(count * ROW_H, ROW_H))

    for i, data in ipairs(sorted) do
        local row = rowFrames[i]

        if not row then
            row = CreateFrame("Frame", nil, scrollChild)
            row:SetHeight(ROW_H)

            row.bg = row:CreateTexture(nil, "BACKGROUND")
            row.bg:SetAllPoints(row)

            row.tName = MakeText(row, "", 12)
            row.tName:SetPoint("LEFT", row, "LEFT", COL.name, 0)
            row.tName:SetWidth(120)
            row.tName:SetJustifyH("LEFT")

            row.tLevel = MakeText(row, "", 11)
            row.tLevel:SetPoint("LEFT", row, "LEFT", COL.level, 0)
            row.tLevel:SetWidth(50)
            row.tLevel:SetJustifyH("CENTER")

            row.tClass = MakeText(row, "", 11)
            row.tClass:SetPoint("LEFT", row, "LEFT", COL.class, 0)
            row.tClass:SetWidth(120)
            row.tClass:SetJustifyH("LEFT")
            
            -- NOUVEAU : Guilde
            row.tGuild = MakeText(row, "", 10)
            row.tGuild:SetPoint("LEFT", row, "LEFT", COL.guild, 0)
            row.tGuild:SetWidth(100)
            row.tGuild:SetJustifyH("LEFT")

            row.tDeaths = MakeText(row, "", 12)
            row.tDeaths:SetPoint("LEFT", row, "LEFT", COL.deaths, 0)
            row.tDeaths:SetWidth(55)
            row.tDeaths:SetJustifyH("CENTER")

            row.tKills = MakeText(row, "", 12)
            row.tKills:SetPoint("LEFT", row, "LEFT", COL.kills, 0)
            row.tKills:SetWidth(55)
            row.tKills:SetJustifyH("CENTER")

            row.tRatio = MakeText(row, "", 12)
            row.tRatio:SetPoint("LEFT", row, "LEFT", COL.ratio, 0)
            row.tRatio:SetWidth(55)
            row.tRatio:SetJustifyH("CENTER")
            
            -- NOUVEAU : Niveau de haine (dropdown avec image)
            row.hateBtn = CreateFrame("Button", nil, row)
            row.hateBtn:SetSize(25, 25)  -- Taille pour l'icône
            row.hateBtn:SetPoint("LEFT", row, "LEFT", COL.hateLevel, 0)
            
            -- Texture pour afficher l'icône de haine
            row.hateIcon = row.hateBtn:CreateTexture(nil, "ARTWORK")
            row.hateIcon:SetAllPoints(row.hateBtn)
            row.hateIcon:SetTexture("Interface\\AddOns\\NoMercyList\\Textures\\poussin")  -- Par défaut
            
            -- Highlight au survol
            local hl = row.hateBtn:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints(row.hateBtn)
            hl:SetColorTexture(1, 1, 1, 0.3)
            hl:SetBlendMode("ADD")
            
            row.hateBtn:SetScript("OnClick", function(self)
                local playerName = row.playerName
                NoMercyList_ShowHateMenu(self, playerName)
            end)

            row.tLastSeen = MakeText(row, "", 10)
            row.tLastSeen:SetPoint("LEFT", row, "LEFT", COL.lastSeen, 0)
            row.tLastSeen:SetWidth(160)
            row.tLastSeen:SetJustifyH("LEFT")

            local delBtn = CreateFrame("Button", nil, row)
            delBtn:SetSize(22, 22)
            delBtn:SetPoint("LEFT", row, "LEFT", COL.del, 0)
            local delTex = delBtn:CreateFontString(nil, "OVERLAY")
            delTex:SetFont("Fonts\\FRIZQT__.TTF", 16, "BOLD")
            delTex:SetText("X")
            delTex:SetTextColor(0.9, 0.1, 0.1)
            delTex:SetAllPoints(delBtn)
            delBtn:SetScript("OnEnter", function() delTex:SetTextColor(1, 0.4, 0.4) end)
            delBtn:SetScript("OnLeave", function() delTex:SetTextColor(0.9, 0.1, 0.1) end)
            row.delBtn = delBtn
            row.delTex = delTex  -- Stocke la référence au texte

            rowFrames[i] = row
        end

        row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -(i-1) * ROW_H)
        row:SetWidth(scrollChild:GetWidth())
        if i % 2 == 0 then
            row.bg:SetColorTexture(0.15, 0.15, 0.18, 0.9)
        else
            row.bg:SetColorTexture(0.12, 0.12, 0.14, 0.9)
        end

        -- Nom
        row.tName:SetText(data.name)
        row.tName:SetTextColor(1, 1, 1)

        -- Niveau
        local lvl = data.level or 0
        if lvl > 0 then
            row.tLevel:SetText(tostring(lvl))
            row.tLevel:SetTextColor(1, 0.82, 0)
        else
            row.tLevel:SetText("?")
            row.tLevel:SetTextColor(0.5, 0.5, 0.5)
        end

        -- Classe (colorée)
        local ct = data.classToken or ""
        local displayClass = CLASS_DISPLAY[ct] or (ct ~= "" and ct or "?")
        local hex = CLASS_COLOR[ct]
        if hex then
            row.tClass:SetText("|cff" .. hex .. displayClass .. "|r")
        else
            row.tClass:SetText(displayClass)
            row.tClass:SetTextColor(0.5, 0.5, 0.5)
        end
        
        -- NOUVEAU : Guilde
        local guildText = data.guild or ""
        if guildText == "" then
            row.tGuild:SetText("-")
            row.tGuild:SetTextColor(0.5, 0.5, 0.5)
        else
            row.tGuild:SetText(guildText)
            row.tGuild:SetTextColor(0.8, 0.8, 1)
        end

        -- Morts / Kills
        local d = data.deaths or 0
        local k = data.kills  or 0
        row.tDeaths:SetText(tostring(d))
        row.tDeaths:SetTextColor(1.0, 0.35, 0.35)
        row.tKills:SetText(tostring(k))
        row.tKills:SetTextColor(0.35, 1.0, 0.35)

        -- Ratio
        local ratioStr = FormatRatio(k, d)
        row.tRatio:SetText(ratioStr)
        if d == 0 then
            row.tRatio:SetTextColor(1, 0.82, 0)
        elseif k / d >= 1 then
            row.tRatio:SetTextColor(0.3, 1, 0.3)
        else
            row.tRatio:SetTextColor(1, 0.4, 0.4)
        end
        
        -- NOUVEAU : Niveau de haine (affiche l'icône correspondante)
        local hateLevel = data.hateLevel or 1
        row.playerName = data.name  -- Stocke le nom pour le dropdown
        
        -- Affiche l'image selon le niveau de haine (1-3)
        if hateLevel >= 3 then
            row.hateIcon:SetTexture("Interface\\AddOns\\NoMercyList\\Textures\\tdm")
        elseif hateLevel >= 2 then
            row.hateIcon:SetTexture("Interface\\AddOns\\NoMercyList\\Textures\\poule")
        else
            row.hateIcon:SetTexture("Interface\\AddOns\\NoMercyList\\Textures\\poussin")
        end

        -- Dernière vue
        local lastSeenStr = FormatLastSeen(data.lastSeen or 0)
        row.tLastSeen:SetText(lastSeenStr)
        
        -- Couleur selon ancienneté
        local now = time()
        if now and data.lastSeen then
            local elapsed = now - (data.lastSeen or 0)
            if elapsed < 300 then  -- < 5 min
                row.tLastSeen:SetTextColor(0.4, 1, 0.4)  -- vert
            elseif elapsed < 3600 then  -- < 1h
                row.tLastSeen:SetTextColor(1, 0.82, 0)  -- doré
            else
                row.tLastSeen:SetTextColor(0.6, 0.6, 0.6)  -- gris
            end
        else
            row.tLastSeen:SetTextColor(0.6, 0.6, 0.6)
        end

        -- Suppression
        local pName = data.name
        row.delBtn:SetScript("OnClick", function()
            NoMercyListDB.players[pName] = nil
            NoMercyList_Refresh()
        end)
        
        -- REPOSITIONNEMENT DYNAMIQUE DES COLONNES
        -- Calcule les positions X selon les colonnes actives
        local cols = NoMercyListDB.settings.columns
        local currentX = COL.name  -- Commence après le nom (toujours affiché)
        
        -- Utilise les largeurs et spacing globaux
        local widths = COLUMN_WIDTHS
        local spacing = COLUMN_SPACING
        
        -- Nom (toujours affiché)
        row.tName:ClearAllPoints()
        row.tName:SetPoint("LEFT", row, "LEFT", COL.name, 0)
        row.tName:SetWidth(widths.name)  -- Ajuste la largeur dynamiquement
        row.tName:Show()
        currentX = COL.name + widths.name + spacing
        
        -- Niveau
        if cols.level then
            row.tLevel:ClearAllPoints()
            row.tLevel:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tLevel:Show()
            currentX = currentX + widths.level + spacing
        else
            row.tLevel:Hide()
        end
        
        -- Classe
        if cols.class then
            row.tClass:ClearAllPoints()
            row.tClass:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tClass:SetWidth(widths.class)  -- Ajuste la largeur dynamiquement
            row.tClass:Show()
            currentX = currentX + widths.class + spacing
        else
            row.tClass:Hide()
        end
        
        -- Guilde
        if cols.guild then
            row.tGuild:ClearAllPoints()
            row.tGuild:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tGuild:Show()
            currentX = currentX + widths.guild + spacing
        else
            row.tGuild:Hide()
        end
        
        -- Morts
        if cols.deaths then
            row.tDeaths:ClearAllPoints()
            row.tDeaths:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tDeaths:Show()
            currentX = currentX + widths.deaths + spacing
        else
            row.tDeaths:Hide()
        end
        
        -- Kills
        if cols.kills then
            row.tKills:ClearAllPoints()
            row.tKills:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tKills:Show()
            currentX = currentX + widths.kills + spacing
        else
            row.tKills:Hide()
        end
        
        -- Ratio
        if cols.ratio then
            row.tRatio:ClearAllPoints()
            row.tRatio:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tRatio:Show()
            currentX = currentX + widths.ratio + spacing
        else
            row.tRatio:Hide()
        end
        
        -- Niveau de haine
        if cols.hateLevel then
            row.hateBtn:ClearAllPoints()
            -- Centre l'icône dans la colonne : position + (largeur_colonne - largeur_icône) / 2
            local centerOffset = (widths.hateLevel - 25) / 2  -- 25 = taille de l'icône
            row.hateBtn:SetPoint("LEFT", row, "LEFT", currentX + centerOffset, 0)
            row.hateBtn:Show()
            currentX = currentX + widths.hateLevel + spacing
        else
            row.hateBtn:Hide()
        end
        
        -- Dernière vue
        if cols.lastSeen then
            row.tLastSeen:ClearAllPoints()
            row.tLastSeen:SetPoint("LEFT", row, "LEFT", currentX, 0)
            row.tLastSeen:SetWidth(widths.lastSeen)  -- Ajuste la largeur dynamiquement
            row.tLastSeen:Show()
            currentX = currentX + widths.lastSeen + spacing
        else
            row.tLastSeen:Hide()
        end
        
        -- Bouton suppression (comme les autres colonnes)
        if cols.delete then
            row.delBtn:ClearAllPoints()
            -- Centre le bouton dans la colonne : position + (largeur_colonne - largeur_bouton) / 2
            local centerOffset = (widths.delete - 22) / 2  -- 22 = taille du bouton
            row.delBtn:SetPoint("LEFT", row, "LEFT", currentX + centerOffset, 0)
            row.delBtn:Show()
            if row.delTex then
                row.delTex:Show()
            end
            currentX = currentX + widths.delete + spacing
        else
            row.delBtn:Hide()
        end

        row:Show()
    end

    for i = count + 1, #rowFrames do
        if rowFrames[i] then rowFrames[i]:Hide() end
    end

    if not scrollChild.emptyMsg then
        scrollChild.emptyMsg = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        scrollChild.emptyMsg:SetFont("Fonts\\FRIZQT__.TTF", 11, "ITALIC")
        scrollChild.emptyMsg:SetPoint("CENTER", scrollChild, "CENTER", 0, 0)
        scrollChild.emptyMsg:SetTextColor(0.5, 0.5, 0.5)
        scrollChild.emptyMsg:SetText("Liste vide. Ciblez un joueur ennemi et cliquez Ajouter.")
        scrollChild.emptyMsg:SetJustifyH("CENTER")
    end
    scrollChild.emptyMsg:SetShown(count == 0)

    if mainFrame and mainFrame.countText then
        mainFrame.countText:SetText(count .. " joueur(s) suivi(s)")
    end
end

-- ---------------------------------------------------------------------------
-- SYSTÈME "ENNEMIS À PORTÉE" (v1.1)
-- ---------------------------------------------------------------------------

local nearbyEnemies = {}  -- {playerName = {timestamp, level, class, hateLevel}}
local nearbyFrame = nil

UpdateNearbyEnemy = function(playerName, playerData, unitID)
    if not playerName or not NoMercyListDB.players[playerName] then return end
    
    nearbyEnemies[playerName] = {
        timestamp = GetTime(),
        level = playerData.level or 0,
        classToken = playerData.classToken or "",
        hateLevel = playerData.hateLevel or 1,
        unitID = unitID,  -- Stocke le unitID (ex: "target", "nameplate3", etc.)
    }
end

local function CleanExpiredNearbyEnemies()
    local now = GetTime()
    local expireTime = NoMercyListDB.settings.nearby.expireTime or 20
    
    for name, data in pairs(nearbyEnemies) do
        if (now - data.timestamp) > expireTime then
            nearbyEnemies[name] = nil
        end
    end
end

local function GetSortedNearbyEnemies()
    CleanExpiredNearbyEnemies()
    
    local sorted = {}
    for name, data in pairs(nearbyEnemies) do
        table.insert(sorted, {name = name, data = data})
    end
    
    -- Trie par timestamp (plus récent en premier)
    table.sort(sorted, function(a, b)
        return a.data.timestamp > b.data.timestamp
    end)
    
    -- Limite au nombre max configuré
    local maxEntries = NoMercyListDB.settings.nearby.maxEntries or 10
    while #sorted > maxEntries do
        table.remove(sorted)
    end
    
    return sorted
end

-- ---------------------------------------------------------------------------
-- CONSTRUCTION FENETRE PRINCIPALE
-- ---------------------------------------------------------------------------

function NoMercyList_BuildUI()
    if mainFrame then return end

    mainFrame = CreateFrame("Frame", "KillListMainFrame", UIParent, "BasicFrameTemplateWithInset")
    mainFrame:SetSize(WIN_W_DEFAULT, WIN_H)  -- Utilise la largeur par défaut, sera ajustée au premier Refresh
    mainFrame:SetFrameStrata("MEDIUM")
    mainFrame:SetMovable(true)
    mainFrame:EnableMouse(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
    mainFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        NoMercyListDB.windowX = self:GetLeft()
        NoMercyListDB.windowY = self:GetTop()
    end)
    mainFrame:SetToplevel(true)

    if NoMercyListDB.windowX and NoMercyListDB.windowY then
        mainFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", NoMercyListDB.windowX, NoMercyListDB.windowY)
    else
        mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
    mainFrame:Hide()
    mainFrame.TitleText:SetText("No Mercy List v1.4.4")

    -- En-têtes
    local hdrFrame = CreateFrame("Frame", nil, mainFrame)
    hdrFrame:SetPoint("TOPLEFT",  mainFrame, "TOPLEFT",  PAD, -28)
    hdrFrame:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -PAD, -28)
    hdrFrame:SetHeight(HDR_H)
    local hdrBg = hdrFrame:CreateTexture(nil, "BACKGROUND")
    hdrBg:SetAllPoints(hdrFrame)
    hdrBg:SetColorTexture(0.20, 0.18, 0.25, 1)

    local function MakeHeader(txt, xOff, w, justify)
        local fs = hdrFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetFont("Fonts\\FRIZQT__.TTF", 11, "BOLD")
        fs:SetText(txt)
        fs:SetTextColor(1, 0.82, 0)
        fs:SetPoint("LEFT", hdrFrame, "LEFT", xOff, 0)
        fs:SetWidth(w)
        fs:SetJustifyH(justify or "LEFT")
        return fs
    end

    -- Stocke les headers pour pouvoir les masquer/afficher
    mainFrame.headers = {}
    mainFrame.headers.name      = MakeHeader("Nom du joueur", COL.name,      120, "LEFT")
    mainFrame.headers.level     = MakeHeader("Niveau",        COL.level,      50, "CENTER")
    mainFrame.headers.class     = MakeHeader("Classe",        COL.class,     120, "LEFT")
    mainFrame.headers.guild     = MakeHeader("Guilde",        COL.guild,     100, "LEFT")
    mainFrame.headers.deaths    = MakeHeader("Morts",         COL.deaths,     55, "CENTER")
    mainFrame.headers.kills     = MakeHeader("Kills",         COL.kills,      55, "CENTER")
    mainFrame.headers.ratio     = MakeHeader("Ratio",         COL.ratio,      55, "CENTER")
    mainFrame.headers.hateLevel = MakeHeader("Haine",         COL.hateLevel,  35, "CENTER")
    mainFrame.headers.lastSeen  = MakeHeader("Derniere vue",  COL.lastSeen,  160, "LEFT")
    mainFrame.headers.delete    = MakeHeader("X",             COL.del,        45, "CENTER")

    -- Séparateur
    local sep = mainFrame:CreateTexture(nil, "ARTWORK")
    sep:SetPoint("TOPLEFT",  mainFrame, "TOPLEFT",  PAD, -58)
    sep:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -PAD, -58)
    sep:SetHeight(1)
    sep:SetColorTexture(0.5, 0.45, 0.2, 0.7)

    -- ScrollFrame
    local sf = CreateFrame("ScrollFrame", "KillListScrollFrame", mainFrame, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT",     mainFrame, "TOPLEFT",  PAD,      -62)
    sf:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -(PAD + 22), 50)

    scrollChild = CreateFrame("Frame", nil, sf)
    scrollChild:SetWidth(WIN_W_DEFAULT - PAD * 2 - 22)  -- Sera ajusté dynamiquement dans Refresh
    scrollChild:SetHeight(ROW_H)
    sf:SetScrollChild(scrollChild)

    local sfBg = sf:CreateTexture(nil, "BACKGROUND")
    sfBg:SetAllPoints(sf)
    sfBg:SetColorTexture(0.08, 0.08, 0.10, 0.7)

    -- Bouton "Ajouter un joueur"
    -- Si cible ennemie → ajout direct ; sinon → popup manuelle
    local addBtn = CreateFrame("Button", nil, mainFrame, "UIPanelButtonTemplate")
    addBtn:SetSize(160, 26)
    addBtn:SetText("Ajouter un joueur")
    addBtn:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMLEFT", PAD, 14)
    addBtn:SetScript("OnClick", function() NoMercyList_TryAddTarget() end)
    addBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Ajouter un joueur", 1, 0.82, 0)
        GameTooltip:AddLine("Cible ennemie active :", 1, 1, 1)
        GameTooltip:AddLine("  Ajoute la cible avec niveau et classe", 0.4, 1, 0.4)
        GameTooltip:AddLine("Sans cible :", 1, 1, 1)
        GameTooltip:AddLine("  Ouvre la saisie manuelle", 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)
    addBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Bouton "Historique attaquants"
    local histBtn = CreateFrame("Button", nil, mainFrame, "UIPanelButtonTemplate")
    histBtn:SetSize(160, 26)
    histBtn:SetText("Historique attaquants")
    histBtn:SetPoint("LEFT", addBtn, "RIGHT", 8, 0)
    histBtn:SetScript("OnClick", function() NoMercyList_ShowAttackerHistory() end)
    histBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Historique des attaquants", 1, 0.82, 0)
        GameTooltip:AddLine("Affiche les joueurs ennemis qui vous ont", 1, 1, 1)
        GameTooltip:AddLine("attaque au cours des 5 dernieres minutes", 1, 1, 1)
        GameTooltip:Show()
    end)
    histBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Bouton "Paramètres" (icône engrenage)
    local settingsBtn = CreateFrame("Button", nil, mainFrame, "UIPanelButtonTemplate")
    settingsBtn:SetSize(26, 26)
    settingsBtn:SetText("")
    settingsBtn:SetPoint("LEFT", histBtn, "RIGHT", 8, 0)
    
    -- Icône engrenage
    local gearIcon = settingsBtn:CreateTexture(nil, "ARTWORK")
    gearIcon:SetSize(18, 18)
    gearIcon:SetPoint("CENTER", settingsBtn, "CENTER", 0, 0)
    gearIcon:SetTexture("Interface\\Icons\\Trade_Engineering")
    
    settingsBtn:SetScript("OnClick", function() NoMercyList_ShowSettings() end)
    settingsBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Parametres", 1, 0.82, 0)
        GameTooltip:AddLine("Configurer les alertes visuelles", 1, 1, 1)
        GameTooltip:Show()
    end)
    settingsBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Bouton Radar (Ennemis à portée)
    local radarBtn = CreateFrame("Button", nil, mainFrame)
    radarBtn:SetSize(32, 32)
    radarBtn:SetPoint("LEFT", settingsBtn, "RIGHT", 8, 0)
    
    -- Icône target custom (pas de texture de fond)
    local radarIcon = radarBtn:CreateTexture(nil, "ARTWORK")
    radarIcon:SetSize(24, 24)  -- Un peu plus grand pour bien voir
    radarIcon:SetPoint("CENTER", radarBtn, "CENTER", 0, 0)
    radarIcon:SetTexture("Interface\\AddOns\\NoMercyList\\Textures\\target")
    
    -- Effet de surbrillance au survol
    radarBtn:SetScript("OnEnter", function(self)
        radarIcon:SetVertexColor(1.5, 1.5, 1.5)  -- Éclaircit l'icône
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Ennemis a portee", 1, 0.82, 0)
        GameTooltip:AddLine("Afficher/masquer la liste des ennemis proches", 1, 1, 1)
        GameTooltip:Show()
    end)
    radarBtn:SetScript("OnLeave", function()
        radarIcon:SetVertexColor(1, 1, 1)  -- Couleur normale
        GameTooltip:Hide()
    end)
    radarBtn:SetScript("OnClick", function() 
        NoMercyList_ToggleNearby()
    end)

    -- Compteur
    local countText = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    countText:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
    countText:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -PAD, 16)
    countText:SetTextColor(0.5, 0.5, 0.5)
    mainFrame.countText = countText
end

-- ---------------------------------------------------------------------------
-- AJOUT VIA CIBLE
-- ---------------------------------------------------------------------------

function NoMercyList_TryAddTarget()
    -- Un joueur ennemi est-il ciblé ?
    if UnitExists("target") and UnitIsPlayer("target") and UnitIsEnemy("player", "target") then
        local tName  = UnitName("target")
        local tLevel = UnitLevel("target")
        if tLevel and tLevel < 0 then tLevel = 0 end   -- -1 = boss/skull

        -- UnitClass("target") retourne (nomAffiché, tokenInterne)
        -- On veut le token interne (ex: "WARRIOR") pour les couleurs
        local _, tClassToken = UnitClass("target")
        
        -- Récupère la guilde
        local tGuild = GetGuildInfo("target") or ""

        local ok, result = AddPlayerToList(tName, tLevel, tClassToken, tGuild)
        if ok then
            -- Ouvre la fenêtre si masquée
            if mainFrame and not mainFrame:IsShown() then
                mainFrame:Show()
            end
            NoMercyList_Refresh()
            local lvlStr = (tLevel and tLevel > 0) and tostring(tLevel) or "?"
            local cls    = (tClassToken and CLASS_DISPLAY[tClassToken]) or "?"
            local guildStr = (tGuild ~= "") and (" <" .. tGuild .. ">") or ""
            print("|cff00ff00[No Mercy List]|r Ajoute depuis cible : " .. result
                  .. " | Niv " .. lvlStr .. " | " .. cls .. guildStr)
        elseif result == "doublon" then
            print("|cffff4444[No Mercy List]|r " .. (tName or "?") .. " est deja dans la liste.")
        else
            print("|cffff4444[No Mercy List]|r Impossible d'ajouter cette cible.")
        end
    else
        -- Pas de cible valide → saisie manuelle
        NoMercyList_ShowPopup()
    end
end

-- ---------------------------------------------------------------------------
-- POPUP SAISIE MANUELLE
-- ---------------------------------------------------------------------------

local popupFrame = nil

function NoMercyList_ShowPopup()
    if not popupFrame then
        local pop = CreateFrame("Frame", "KillListPopup", UIParent, "BasicFrameTemplate")
        pop:SetSize(300, 140)
        pop:SetFrameStrata("HIGH")
        pop:SetMovable(true)
        pop:EnableMouse(true)
        pop:RegisterForDrag("LeftButton")
        pop:SetScript("OnDragStart", pop.StartMoving)
        pop:SetScript("OnDragStop",  pop.StopMovingOrSizing)
        pop:SetToplevel(true)
        pop.TitleText:SetText("Ajouter un joueur")

        local eb = CreateFrame("EditBox", "KillListEditBox", pop, "InputBoxTemplate")
        eb:SetSize(240, 22)
        eb:SetPoint("TOP", pop, "TOP", 0, -38)
        eb:SetAutoFocus(false)
        eb:SetMaxLetters(30)
        eb:SetFontObject("GameFontHighlightSmall")
        pop.eb = eb

        -- Note explicative
        local hint = pop:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        hint:SetFont("Fonts\\FRIZQT__.TTF", 9, "ITALIC")
        hint:SetPoint("TOP", eb, "BOTTOM", 0, -6)
        hint:SetWidth(260)
        hint:SetJustifyH("CENTER")
        hint:SetTextColor(0.5, 0.5, 0.5)
        hint:SetText("Astuce : ciblez le joueur avant de cliquer\npour obtenir son niveau et sa classe.")

        local msg = pop:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        msg:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
        msg:SetPoint("TOP", hint, "BOTTOM", 0, -2)
        msg:SetWidth(260)
        msg:SetJustifyH("CENTER")
        msg:SetText("")
        pop.msg = msg

        local btnAdd = CreateFrame("Button", nil, pop, "UIPanelButtonTemplate")
        btnAdd:SetSize(110, 24)
        btnAdd:SetText("Ajouter")
        btnAdd:SetPoint("BOTTOMLEFT", pop, "BOTTOMLEFT", 18, 12)
        btnAdd:SetScript("OnClick", function()
            local success, ok, result = pcall(function()
                return AddPlayerToList(eb:GetText(), 0, "")
            end)
            
            if not success then
                msg:SetText("|cffff0000ERREUR: " .. tostring(ok) .. "|r")
                print("|cffff0000[No Mercy List ERROR]|r " .. tostring(ok))
                return
            end
            
            if ok then
                NoMercyList_Refresh()
                msg:SetText("|cff00ff00Ajoute : " .. result .. "|r")
                eb:SetText("")
                C_Timer.After(0.9, function() pop:Hide() end)
            elseif result == "doublon" then
                msg:SetText("|cffff4444Deja dans la liste.|r")
            else
                msg:SetText("|cffff4444Nom invalide ou vide.|r")
            end
        end)

        local btnCancel = CreateFrame("Button", nil, pop, "UIPanelButtonTemplate")
        btnCancel:SetSize(110, 24)
        btnCancel:SetText("Annuler")
        btnCancel:SetPoint("BOTTOMRIGHT", pop, "BOTTOMRIGHT", -18, 12)
        btnCancel:SetScript("OnClick", function()
            pop:Hide()
            eb:SetText("")
            msg:SetText("")
        end)

        eb:SetScript("OnEnterPressed", function() btnAdd:Click() end)
        eb:SetScript("OnEscapePressed", function() btnCancel:Click() end)
        eb:SetScript("OnTextChanged",   function() msg:SetText("") end)
        pop:SetScript("OnShow", function()
            eb:SetText("")
            msg:SetText("")
            eb:SetFocus()
        end)

        popupFrame = pop
    end

    popupFrame:ClearAllPoints()
    if mainFrame and mainFrame:IsShown() then
        popupFrame:SetPoint("CENTER", mainFrame, "CENTER", 0, 30)
    else
        popupFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
    popupFrame:Show()
end

-- ---------------------------------------------------------------------------
-- BOUTON MINIMAP
-- ---------------------------------------------------------------------------

-- Construction fenêtre "Ennemis à portée"
function NoMercyList_BuildNearbyFrame()
    if nearbyFrame then return end
    
    local scale = NoMercyListDB.settings.nearby.scale or 1.0
    local baseWidth = 200
    
    nearbyFrame = CreateFrame("Frame", "NoMercyListNearbyFrame", UIParent)
    nearbyFrame:SetSize(baseWidth * scale, 100 * scale)
    nearbyFrame:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    nearbyFrame:SetFrameStrata("MEDIUM")
    nearbyFrame:SetMovable(true)
    nearbyFrame:EnableMouse(true)
    nearbyFrame:RegisterForDrag("LeftButton")
    nearbyFrame:SetScript("OnDragStart", nearbyFrame.StartMoving)
    nearbyFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Sauvegarde position
        local point, _, relativePoint, x, y = self:GetPoint()
        NoMercyListDB.settings.nearby.position = {point, relativePoint, x, y}
    end)
    nearbyFrame:SetClampedToScreen(true)
    
    -- Fond
    nearbyFrame.bg = nearbyFrame:CreateTexture(nil, "BACKGROUND")
    nearbyFrame.bg:SetAllPoints()
    nearbyFrame.bg:SetColorTexture(0, 0, 0, NoMercyListDB.settings.nearby.opacity or 0.8)
    
    -- Titre
    nearbyFrame.title = nearbyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    nearbyFrame.title:SetPoint("TOP", 0, -5)
    nearbyFrame.title:SetText("Ennemis à portée")
    nearbyFrame.title:SetTextColor(1, 0.82, 0)
    
    -- Bouton fermeture (X)
    local closeBtn = CreateFrame("Button", nil, nearbyFrame)
    closeBtn:SetSize(16, 16)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetScript("OnClick", function() nearbyFrame:Hide() end)
    
    -- PRÉ-CRÉER 10 boutons sécurisés
    nearbyFrame.buttons = {}
    for i = 1, 10 do
        local btn = CreateFrame("Button", "NMLNearbyButton"..i, nearbyFrame, "SecureActionButtonTemplate")
        btn:SetSize(180, 20)
        btn:SetPoint("TOP", 0, -25 - (i-1)*20)
        
        --  OnLoad
        btn:RegisterForClicks("AnyDown", "AnyUp")
        btn:SetAttribute("type1", "macro")  -- PAS *type1 mais type1 !!!
        btn:SetAttribute("macrotext", "/targetexact nil")  -- Initialise
        
        -- Icône classe
        btn.classIcon = btn:CreateTexture(nil, "ARTWORK")
        btn.classIcon:SetSize(20, 20)
        btn.classIcon:SetPoint("LEFT", 2, 0)
        
        -- Nom
        btn.nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btn.nameText:SetPoint("LEFT", btn.classIcon, "RIGHT", 2, 0)
        btn.nameText:SetJustifyH("LEFT")
        
        -- Niveau
        btn.levelText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btn.levelText:SetPoint("LEFT", btn.nameText, "RIGHT", 3, 0)
        
        -- Icône haine
        btn.hateIcon = btn:CreateTexture(nil, "ARTWORK")
        btn.hateIcon:SetSize(16, 16)
        btn.hateIcon:SetPoint("RIGHT", -2, 0)
        
        -- PreClick
        btn:SetScript("PreClick", function(self, button)
            if button == "LeftButton" and self.targetName then
                if not InCombatLockdown() then
                    self:SetAttribute("macrotext", "/targetexact " .. self.targetName)
                end
            end
        end)
        
        btn:Hide()
        nearbyFrame.buttons[i] = btn
    end
    
    -- Restaure position sauvegardée
    if NoMercyListDB.settings.nearby.position then
        local pos = NoMercyListDB.settings.nearby.position
        nearbyFrame:ClearAllPoints()
        nearbyFrame:SetPoint(pos[1], UIParent, pos[2], pos[3], pos[4])
    end
    
    nearbyFrame:Hide()
end

-- Toggle la fenêtre nearby
function NoMercyList_ToggleNearby()
    if nearbyFrame then
        if nearbyFrame:IsShown() then
            nearbyFrame:Hide()
        else
            nearbyFrame:Show()
            RefreshNearbyFrame()
        end
    end
end

-- Fonction de refresh de la fenêtre nearby
RefreshNearbyFrame = function()
    if not nearbyFrame then return end
    
    local sorted = GetSortedNearbyEnemies()
    
    -- Cache tous les boutons d'abord
    for i = 1, 10 do
        nearbyFrame.buttons[i]:Hide()
    end
    
    -- Affiche et configure seulement ceux nécessaires
    for i = 1, math.min(#sorted, 10) do
        local entry = sorted[i]
        local btn = nearbyFrame.buttons[i]
        local playerName = entry.name
        local data = entry.data
        
        -- Stocke le nom pour PreClick (pas de SetAttribute ici!)
        btn.targetName = playerName
        
        -- Met à jour les visuels (pas de SetAttribute, donc OK en combat)
        
        -- Classe
        if data.classToken and data.classToken ~= "" then
            local coords = CLASS_ICON_TCOORDS[data.classToken]
            if coords then
                btn.classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
                btn.classIcon:SetTexCoord(unpack(coords))
            end
        end
        
        -- Nom coloré
        local hex = CLASS_COLOR[data.classToken] or "FFFFFF"
        btn.nameText:SetText("|cff" .. hex .. playerName .. "|r")
        
        -- Niveau
        btn.levelText:SetText(tostring(data.level))
        
        -- Icône haine
        local hateTex = "Interface\\AddOns\\NoMercyList\\Textures\\poussin"
        if data.hateLevel >= 3 then
            hateTex = "Interface\\AddOns\\NoMercyList\\Textures\\tdm"
        elseif data.hateLevel >= 2 then
            hateTex = "Interface\\AddOns\\NoMercyList\\Textures\\poule"
        end
        btn.hateIcon:SetTexture(hateTex)
        
        btn:Show()
    end
    
    -- Ajuste la hauteur du frame
    local visibleCount = math.min(#sorted, 10)
    local totalHeight = 30 + (visibleCount * 20)
    nearbyFrame:SetHeight(math.max(totalHeight, 50))
end

-- Timer pour refresh auto
local nearbyUpdateTimer = 0
StartNearbyUpdates = function()
    local f = CreateFrame("Frame")
    f:SetScript("OnUpdate", function(self, elapsed)
        nearbyUpdateTimer = nearbyUpdateTimer + elapsed
        if nearbyUpdateTimer >= 0.5 then  -- Update toutes les 0.5s
            nearbyUpdateTimer = 0
            if nearbyFrame and nearbyFrame:IsShown() then
                RefreshNearbyFrame()
            end
        end
    end)
end

-- ---------------------------------------------------------------------------

local minimapBtn = nil

function NoMercyList_BuildMinimap()
    if minimapBtn then return end

    -- Crée le bouton avec un nom standard reconnu par les gestionnaires de minimap
    local btn = CreateFrame("Button", "NoMercyListMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetMovable(true)
    btn:EnableMouse(true)
    
    -- Attributs pour la détection par les gestionnaires de minimap
    btn.noAutoScale = true
    btn.noRotate = true
    
    -- Icône - IMPORTANT : bien centrer sur le bouton lui-même
    btn.icon = btn:CreateTexture(nil, "BACKGROUND")
    btn.icon:SetSize(20, 20)
    btn.icon:SetPoint("CENTER", 0, 0)  -- Centré sur le bouton parent
    -- Utilise l'icône de skull du targeting frame (celle qui apparaît quand on cible un boss)
    btn.icon:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull")
    btn.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)  -- Crop les bords pour avoir juste le skull

    -- Bordure
    local border = btn:CreateTexture(nil, "OVERLAY")
    border:SetSize(52, 52)
    border:SetPoint("TOPLEFT", 0, 0)
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    -- Highlight
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetSize(30, 30)
    hl:SetPoint("CENTER", 0, 0)
    hl:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    hl:SetBlendMode("ADD")

    local function UpdatePos()
        local angle = math.rad(NoMercyListDB.minimapAngle or 220)
        local x = math.cos(angle) * 80
        local y = math.sin(angle) * 80
        btn:ClearAllPoints()
        btn:SetPoint("CENTER", Minimap, "CENTER", x, y)
    end
    
    -- Fonction UpdatePosition pour les gestionnaires de minimap
    btn.UpdatePosition = UpdatePos
    UpdatePos()

    btn:RegisterForDrag("LeftButton")
    btn:SetScript("OnDragStart", function(self)
        self._dragging = true
        self:SetScript("OnUpdate", function()
            local cx, cy = Minimap:GetCenter()
            local mx, my = GetCursorPosition()
            local s = UIParent:GetEffectiveScale()
            NoMercyListDB.minimapAngle = math.deg(math.atan2(my/s - cy, mx/s - cx))
            UpdatePos()
        end)
    end)
    btn:SetScript("OnDragStop", function(self)
        self._dragging = false
        self:SetScript("OnUpdate", nil)
    end)

    btn:RegisterForClicks("AnyUp")
    btn:SetScript("OnClick", function(self, mouseBtn)
        if self._dragging then return end
        if mouseBtn == "LeftButton" then
            if not mainFrame then return end
            if mainFrame:IsShown() then
                mainFrame:Hide()
            else
                mainFrame:Show()
                NoMercyList_Refresh()
            end
        end
    end)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("No Mercy List", 1, 0.82, 0)
        GameTooltip:AddLine("Clic : afficher/masquer", 1, 1, 1)
        GameTooltip:AddLine("Glisser : repositionner", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    minimapBtn = btn
end

-- ---------------------------------------------------------------------------
-- FENÊTRE HISTORIQUE DES ATTAQUANTS
-- ---------------------------------------------------------------------------

local historyFrame = nil

function NoMercyList_ShowAttackerHistory()
    if not historyFrame then
        -- Construction de la fenêtre
        local hf = CreateFrame("Frame", "KillListHistoryFrame", UIParent, "BasicFrameTemplate")
        hf:SetSize(520, 360)  -- Élargi pour afficher plus d'infos
        hf:SetFrameStrata("HIGH")
        hf:SetMovable(true)
        hf:EnableMouse(true)
        hf:RegisterForDrag("LeftButton")
        hf:SetScript("OnDragStart", hf.StartMoving)
        hf:SetScript("OnDragStop", hf.StopMovingOrSizing)
        hf:SetToplevel(true)
        hf.TitleText:SetText("Historique des attaquants (5 min)")

        -- ScrollFrame pour la liste
        local sf = CreateFrame("ScrollFrame", "KillListHistoryScroll", hf, "UIPanelScrollFrameTemplate")
        sf:SetPoint("TOPLEFT", hf, "TOPLEFT", 12, -28)
        sf:SetPoint("BOTTOMRIGHT", hf, "BOTTOMRIGHT", -30, 50)

        local child = CreateFrame("Frame", nil, sf)
        child:SetWidth(470)  -- Ajusté pour la nouvelle largeur de fenêtre
        child:SetHeight(300)
        sf:SetScrollChild(child)

        local sfBg = sf:CreateTexture(nil, "BACKGROUND")
        sfBg:SetAllPoints(sf)
        sfBg:SetColorTexture(0.08, 0.08, 0.10, 0.7)

        hf.scrollChild = child
        hf.scrollFrame = sf

        -- Pool de lignes pour l'historique
        hf.rows = {}

        -- Bouton "Rafraîchir"
        local refreshBtn = CreateFrame("Button", nil, hf, "UIPanelButtonTemplate")
        refreshBtn:SetSize(110, 24)
        refreshBtn:SetText("Rafraichir")
        refreshBtn:SetPoint("BOTTOMLEFT", hf, "BOTTOMLEFT", 12, 14)
        refreshBtn:SetScript("OnClick", function()
            NoMercyList_RefreshAttackerHistory()
        end)

        -- Bouton "Fermer"
        local closeBtn = CreateFrame("Button", nil, hf, "UIPanelButtonTemplate")
        closeBtn:SetSize(110, 24)
        closeBtn:SetText("Fermer")
        closeBtn:SetPoint("BOTTOMRIGHT", hf, "BOTTOMRIGHT", -12, 14)
        closeBtn:SetScript("OnClick", function() hf:Hide() end)

        -- Message liste vide
        hf.emptyMsg = hf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        hf.emptyMsg:SetFont("Fonts\\FRIZQT__.TTF", 11, "ITALIC")
        hf.emptyMsg:SetPoint("CENTER", child, "CENTER", 0, 0)
        hf.emptyMsg:SetTextColor(0.5, 0.5, 0.5)
        hf.emptyMsg:SetText("Aucun attaquant recent.\nLes joueurs qui vous attaquent apparaitront ici.")
        hf.emptyMsg:SetJustifyH("CENTER")

        historyFrame = hf
    end

    -- Positionne la fenêtre
    historyFrame:ClearAllPoints()
    if mainFrame and mainFrame:IsShown() then
        historyFrame:SetPoint("LEFT", mainFrame, "RIGHT", 10, 0)
    else
        historyFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end

    historyFrame:Show()
    NoMercyList_RefreshAttackerHistory()
end

function NoMercyList_RefreshAttackerHistory()
    if not historyFrame or not historyFrame:IsShown() then 
        return 
    end

    local attackers = GetRecentAttackers()
    local count = #attackers
    

    local child = historyFrame.scrollChild
    local rows  = historyFrame.rows

    -- Hauteur dynamique
    local ROW_H = 32
    child:SetHeight(math.max(count * ROW_H, ROW_H))

    for i, data in ipairs(attackers) do
        local row = rows[i]

        if not row then
            -- Création de la ligne
            row = CreateFrame("Frame", nil, child)
            row:SetHeight(ROW_H)

            row.bg = row:CreateTexture(nil, "BACKGROUND")
            row.bg:SetAllPoints(row)

            -- Nom
            row.tName = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            row.tName:SetFont("Fonts\\FRIZQT__.TTF", 12, "")
            row.tName:SetPoint("LEFT", row, "LEFT", 8, 6)
            row.tName:SetWidth(250)  -- Élargi pour niveau + classe
            row.tName:SetJustifyH("LEFT")

            -- Temps écoulé + stats
            row.tTime = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            row.tTime:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
            row.tTime:SetPoint("LEFT", row, "LEFT", 8, -8)
            row.tTime:SetWidth(250)  -- Élargi pour les stats
            row.tTime:SetJustifyH("LEFT")
            row.tTime:SetTextColor(0.6, 0.6, 0.6)

            -- Bouton "Ajouter à la liste"
            row.addBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
            row.addBtn:SetSize(140, 24)
            row.addBtn:SetText("Ajouter a la liste")
            row.addBtn:SetPoint("RIGHT", row, "RIGHT", -8, 0)

            rows[i] = row
        end

        row:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -(i-1) * ROW_H)
        local childWidth = child:GetWidth()
        if not childWidth or childWidth == 0 then
            childWidth = 470  -- Fallback ajusté
        end
        row:SetWidth(childWidth)

        -- Fond alterné
        if i % 2 == 0 then
            row.bg:SetColorTexture(0.15, 0.15, 0.18, 0.9)
        else
            row.bg:SetColorTexture(0.12, 0.12, 0.14, 0.9)
        end

        -- Nom (coloré par classe si connue)
        local displayName = data.name
        if data.classToken and data.classToken ~= "" then
            local hex = CLASS_COLOR[data.classToken]
            if hex then
                displayName = "|cff" .. hex .. data.name .. "|r"
            end
        end
        
        -- Ajoute niveau si connu
        local levelStr = ""
        if data.level and data.level > 0 then
            levelStr = " (Niv " .. data.level .. ")"
        end
        
        -- Ajoute classe si connue
        local classStr = ""
        if data.classToken and data.classToken ~= "" then
            classStr = " " .. (CLASS_DISPLAY[data.classToken] or data.classToken)
        end
        
        row.tName:SetText(displayName .. levelStr .. classStr)

        -- Temps écoulé + dernier événement
        local elapsed = GetTime() - data.lastAttackTime
        local timeStr
        if elapsed < 60 then
            timeStr = string.format("Il y a %d sec", math.floor(elapsed))
        else
            timeStr = string.format("Il y a %d min", math.floor(elapsed / 60))
        end
        
        -- Ajoute l'info kills/deaths
        local outcomeStr = ""
        local killedMe = data.killedMe or 0
        local killedByMe = data.killedByMe or 0
        
        if killedMe > 0 or killedByMe > 0 then
            outcomeStr = " | "
            if killedByMe > 0 then
                outcomeStr = outcomeStr .. "|cff00ff00" .. killedByMe .. " Kill" .. (killedByMe > 1 and "s" or "") .. "|r"
            end
            if killedMe > 0 then
                if killedByMe > 0 then outcomeStr = outcomeStr .. " / " end
                outcomeStr = outcomeStr .. "|cffff4444" .. killedMe .. " Mort" .. (killedMe > 1 and "s" or "") .. "|r"
            end
        elseif data.lastOutcome == "attacked" then
            outcomeStr = " | Combat"
        end
        
        row.tTime:SetText(timeStr .. outcomeStr)

        -- Bouton : ajoute à la No Mercy List
        local pName = data.name
        local pLevel = data.level
        local pClass = data.classToken
        row.addBtn:SetScript("OnClick", function()
            local ok, result = AddPlayerToList(pName, pLevel, pClass)
            if ok then
                NoMercyList_Refresh()
                print("|cff00ff00[No Mercy List]|r " .. result .. " ajoute depuis l'historique.")
                -- Grise le bouton pour éviter les doublons
                row.addBtn:Disable()
                row.addBtn:SetText("Deja ajoute")
            elseif result == "doublon" then
                row.addBtn:Disable()
                row.addBtn:SetText("Deja dans la liste")
            end
        end)

        -- Vérifie si déjà dans la liste pour griser le bouton
        if PlayerInList(pName) then
            row.addBtn:Disable()
            row.addBtn:SetText("Deja dans la liste")
        else
            row.addBtn:Enable()
            row.addBtn:SetText("Ajouter a la liste")
        end

        row:Show()
    end
end

-- ---------------------------------------------------------------------------
-- FENÊTRE DE PARAMÈTRES
-- ---------------------------------------------------------------------------

function NoMercyList_ShowSettings()
    if not settingsFrame then
        local sf = CreateFrame("Frame", "NoMercyListSettingsFrame", UIParent)
        sf:SetSize(600, 600)
        sf:SetPoint("CENTER")
        sf:SetFrameStrata("DIALOG")
        sf:SetMovable(true)
        sf:EnableMouse(true)
        sf:RegisterForDrag("LeftButton")
        sf:SetScript("OnDragStart", sf.StartMoving)
        sf:SetScript("OnDragStop", sf.StopMovingOrSizing)
        sf:SetToplevel(true)
        
        -- Fond noir
        sf.bg = sf:CreateTexture(nil, "BACKGROUND")
        sf.bg:SetAllPoints(sf)
        sf.bg:SetColorTexture(0, 0, 0, 0.9)
        
        -- Bordure dorée
        sf.border = CreateFrame("Frame", nil, sf, "DialogBorderOpaqueTemplate")
        
        -- ====================================================================
        -- ZONE 1 : TITRE (en haut, fixe)
        -- ====================================================================
        sf.title = sf:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        sf.title:SetPoint("TOP", sf, "TOP", 0, -15)
        sf.title:SetText("Réglages")
        sf.title:SetTextColor(1, 0.82, 0)
        
        -- Bouton fermer
        sf.closeBtn = CreateFrame("Button", nil, sf, "UIPanelCloseButton")
        sf.closeBtn:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -5, -5)
        
        -- ====================================================================
        -- ZONE 2 : CONTENU SCROLLABLE (milieu)
        -- ====================================================================
        local scrollFrame = CreateFrame("ScrollFrame", nil, sf, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", sf, "TOPLEFT", 20, -45)
        scrollFrame:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -35, 60)  -- S'arrête 60px avant le bas
        
        local scrollChild = CreateFrame("Frame", nil, scrollFrame)
        scrollChild:SetWidth(540)
        scrollChild:SetHeight(1000)  -- Hauteur du contenu
        scrollFrame:SetScrollChild(scrollChild)
        
        local yOffset = -10
        
        -- Fonction pour créer un titre de section avec lignes
        local function MakeSectionTitle(text, y)
            local container = CreateFrame("Frame", nil, scrollChild)
            container:SetSize(540, 20)
            container:SetPoint("TOP", scrollChild, "TOP", 0, y)
            
            -- Ligne gauche
            local leftLine = container:CreateTexture(nil, "ARTWORK")
            leftLine:SetHeight(1)
            leftLine:SetColorTexture(0.5, 0.5, 0.5, 0.8)
            leftLine:SetPoint("LEFT", container, "LEFT", 0, 0)
            leftLine:SetPoint("RIGHT", container, "CENTER", -100, 0)
            
            -- Texte centré
            local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            title:SetPoint("CENTER", container, "CENTER", 0, 0)
            title:SetText(text)
            title:SetTextColor(1, 0.82, 0)
            
            -- Ligne droite
            local rightLine = container:CreateTexture(nil, "ARTWORK")
            rightLine:SetHeight(1)
            rightLine:SetColorTexture(0.5, 0.5, 0.5, 0.8)
            rightLine:SetPoint("LEFT", container, "CENTER", 100, 0)
            rightLine:SetPoint("RIGHT", container, "RIGHT", 0, 0)
            
            return container
        end
        
        -- ====================================================================
        -- SECTION 1 : ALERTE VISUELLE (BORDURE)
        -- ====================================================================
        MakeSectionTitle("Alerte visuelle (bordure)", yOffset)
        yOffset = yOffset - 35
        
        -- Checkbox activation/désactivation
        local enableBorderCb = CreateFrame("CheckButton", "NMLEnableBorderCheckbox", scrollChild, "UICheckButtonTemplate")
        enableBorderCb:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        enableBorderCb.text = enableBorderCb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        enableBorderCb.text:SetPoint("LEFT", enableBorderCb, "RIGHT", 5, 0)
        enableBorderCb.text:SetText("Activer l'alerte bordure")
        enableBorderCb:SetChecked(NoMercyListDB.settings.alert.enabled)
        enableBorderCb:SetScript("OnClick", function(self)
            NoMercyListDB.settings.alert.enabled = self:GetChecked()
        end)
        
        yOffset = yOffset - 40
        
        -- Couleur de la bordure
        local colorLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        colorLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        colorLabel:SetText("Couleur :")
        
        -- Aperçu couleur cliquable
        local colorPreview = CreateFrame("Button", nil, scrollChild)
        colorPreview:SetSize(20, 20)
        colorPreview:SetPoint("LEFT", colorLabel, "RIGHT", 10, 0)
        
        -- Bordure noire (couche du fond)
        colorPreview.border = colorPreview:CreateTexture(nil, "BACKGROUND")
        colorPreview.border:SetAllPoints(colorPreview)
        colorPreview.border:SetColorTexture(0, 0, 0, 1)
        
        -- Texture couleur (par dessus, avec marge de 1px)
        colorPreview.tex = colorPreview:CreateTexture(nil, "ARTWORK")
        colorPreview.tex:SetPoint("TOPLEFT", colorPreview, "TOPLEFT", 1, -1)
        colorPreview.tex:SetPoint("BOTTOMRIGHT", colorPreview, "BOTTOMRIGHT", -1, 1)
        
        local function UpdateColorPreview()
            local c = NoMercyListDB.settings.alert.color
            colorPreview.tex:SetColorTexture(c.r, c.g, c.b, 1)
        end
        
        -- Ouvre le sélecteur de couleur au clic
        colorPreview:SetScript("OnClick", function()
            local c = NoMercyListDB.settings.alert.color
            
            ColorPickerFrame.func = function()
                -- Appelé en temps réel pendant le déplacement
                local r, g, b = ColorPickerFrame:GetColorRGB()
                NoMercyListDB.settings.alert.color.r = r
                NoMercyListDB.settings.alert.color.g = g
                NoMercyListDB.settings.alert.color.b = b
                UpdateColorPreview()
            end
            
            ColorPickerFrame.opacityFunc = ColorPickerFrame.func
            
            ColorPickerFrame.cancelFunc = function(prev)
                -- Restaure l'ancienne couleur si annulé
                NoMercyListDB.settings.alert.color.r = prev.r
                NoMercyListDB.settings.alert.color.g = prev.g
                NoMercyListDB.settings.alert.color.b = prev.b
                UpdateColorPreview()
            end
            
            ColorPickerFrame.hasOpacity = false
            ColorPickerFrame.previousValues = {r = c.r, g = c.g, b = c.b}
            ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
            ColorPickerFrame:Show()
        end)
        
        -- Texte d'aide
        local colorHelp = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        colorHelp:SetPoint("LEFT", colorPreview, "RIGHT", 10, 0)
        colorHelp:SetText("Cliquer pour choisir")
        colorHelp:SetTextColor(0.7, 0.7, 0.7)
        
        UpdateColorPreview()
        yOffset = yOffset - 30  -- Réduit pour carré plus petit
        
        -- Durée d'affichage
        local durationLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        durationLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        durationLabel:SetText("Duree clignotement bordure (sec) :")
        
        yOffset = yOffset - 35
        local durationSlider = CreateFrame("Slider", "NMLDurationSlider", scrollChild, "OptionsSliderTemplate")
        durationSlider:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
        durationSlider:SetWidth(200)
        durationSlider:SetMinMaxValues(1, 10)
        durationSlider:SetValueStep(0.5)
        durationSlider:SetValue(NoMercyListDB.settings.alert.duration)
        
        -- Assure que les labels sont bien créés
        local lowText = _G[durationSlider:GetName().."Low"]
        local highText = _G[durationSlider:GetName().."High"]
        local valueText = _G[durationSlider:GetName().."Text"]
        
        if lowText then lowText:SetText("1s") end
        if highText then highText:SetText("10s") end
        if valueText then valueText:SetText(string.format("%.1fs", NoMercyListDB.settings.alert.duration)) end
        
        durationSlider:SetScript("OnValueChanged", function(self, value)
            NoMercyListDB.settings.alert.duration = value
            local txt = _G[self:GetName().."Text"]
            if txt then txt:SetText(string.format("%.1fs", value)) end
        end)
        
        yOffset = yOffset - 35
        
        -- Fréquence pulsation
        local pulseLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        pulseLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        pulseLabel:SetText("Vitesse clignotement bordure :")
        
        yOffset = yOffset - 35
        local pulseSlider = CreateFrame("Slider", "NMLPulseSlider", scrollChild, "OptionsSliderTemplate")
        pulseSlider:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
        pulseSlider:SetWidth(200)
        pulseSlider:SetMinMaxValues(0.05, 0.5)
        pulseSlider:SetValueStep(0.05)
        pulseSlider:SetValue(NoMercyListDB.settings.alert.pulseFrequency)
        
        local lowText = _G[pulseSlider:GetName().."Low"]
        local highText = _G[pulseSlider:GetName().."High"]
        local valueText = _G[pulseSlider:GetName().."Text"]
        
        if lowText then lowText:SetText("Rapide") end
        if highText then highText:SetText("Lent") end
        if valueText then valueText:SetText(string.format("%.2fs", NoMercyListDB.settings.alert.pulseFrequency)) end
        
        pulseSlider:SetScript("OnValueChanged", function(self, value)
            NoMercyListDB.settings.alert.pulseFrequency = value
            local txt = _G[self:GetName().."Text"]
            if txt then txt:SetText(string.format("%.2fs", value)) end
        end)
        
        yOffset = yOffset - 40
        
        -- Bouton Test Alerte Visuelle
        local testVisualBtn = CreateFrame("Button", nil, scrollChild, "UIPanelButtonTemplate")
        testVisualBtn:SetSize(150, 22)
        testVisualBtn:SetText("Tester alerte visuelle")
        testVisualBtn:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        testVisualBtn:SetScript("OnClick", function()
            TriggerScreenFlash()
            PlaySound(NoMercyListDB.settings.sound.id, "Master")
        end)
        
        yOffset = yOffset - 50
        
        -- ====================================================================
        -- SECTION 2 : TEXTE D'ALERTE
        -- ====================================================================
        MakeSectionTitle("Texte d'alerte", yOffset)
        yOffset = yOffset - 35
        
        -- Checkbox activation/désactivation
        local enableTextCb = CreateFrame("CheckButton", "NMLEnableTextCheckbox", scrollChild, "UICheckButtonTemplate")
        enableTextCb:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        enableTextCb.text = enableTextCb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        enableTextCb.text:SetPoint("LEFT", enableTextCb, "RIGHT", 5, 0)
        enableTextCb.text:SetText("Activer l'alerte texte")
        enableTextCb:SetChecked(NoMercyListDB.settings.text.enabled)
        enableTextCb:SetScript("OnClick", function(self)
            NoMercyListDB.settings.text.enabled = self:GetChecked()
        end)
        
        yOffset = yOffset - 40
        
        -- Couleur du texte
        local textColorLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        textColorLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        textColorLabel:SetText("Couleur du texte :")
        
        -- Aperçu couleur cliquable
        local textColorPreview = CreateFrame("Button", nil, scrollChild)
        textColorPreview:SetSize(20, 20)
        textColorPreview:SetPoint("LEFT", textColorLabel, "RIGHT", 10, 0)
        
        -- Bordure noire (couche du fond)
        textColorPreview.border = textColorPreview:CreateTexture(nil, "BACKGROUND")
        textColorPreview.border:SetAllPoints(textColorPreview)
        textColorPreview.border:SetColorTexture(0, 0, 0, 1)
        
        -- Texture couleur (par dessus, avec marge de 1px)
        textColorPreview.tex = textColorPreview:CreateTexture(nil, "ARTWORK")
        textColorPreview.tex:SetPoint("TOPLEFT", textColorPreview, "TOPLEFT", 1, -1)
        textColorPreview.tex:SetPoint("BOTTOMRIGHT", textColorPreview, "BOTTOMRIGHT", -1, 1)
        
        local function UpdateTextColorPreview()
            local c = NoMercyListDB.settings.text.color
            textColorPreview.tex:SetColorTexture(c.r, c.g, c.b, 1)
        end
        
        -- Ouvre le sélecteur de couleur au clic
        textColorPreview:SetScript("OnClick", function()
            local c = NoMercyListDB.settings.text.color
            
            ColorPickerFrame.func = function()
                -- Appelé en temps réel pendant le déplacement
                local r, g, b = ColorPickerFrame:GetColorRGB()
                NoMercyListDB.settings.text.color.r = r
                NoMercyListDB.settings.text.color.g = g
                NoMercyListDB.settings.text.color.b = b
                UpdateTextColorPreview()
            end
            
            ColorPickerFrame.opacityFunc = ColorPickerFrame.func
            
            ColorPickerFrame.cancelFunc = function(prev)
                -- Restaure l'ancienne couleur si annulé
                NoMercyListDB.settings.text.color.r = prev.r
                NoMercyListDB.settings.text.color.g = prev.g
                NoMercyListDB.settings.text.color.b = prev.b
                UpdateTextColorPreview()
            end
            
            ColorPickerFrame.hasOpacity = false
            ColorPickerFrame.previousValues = {r = c.r, g = c.g, b = c.b}
            ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
            ColorPickerFrame:Show()
        end)
        
        -- Texte d'aide
        local textColorHelp = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        textColorHelp:SetPoint("LEFT", textColorPreview, "RIGHT", 10, 0)
        textColorHelp:SetText("Cliquer pour choisir")
        textColorHelp:SetTextColor(0.7, 0.7, 0.7)
        
        UpdateTextColorPreview()
        yOffset = yOffset - 30  -- Réduit pour carré plus petit
        
        -- Durée d'affichage du texte
        local textDurationLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        textDurationLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        textDurationLabel:SetText("Duree affichage texte (sec) :")
        
        yOffset = yOffset - 35
        local textDurationSlider = CreateFrame("Slider", "NMLTextDurationSlider", scrollChild, "OptionsSliderTemplate")
        textDurationSlider:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
        textDurationSlider:SetWidth(200)
        textDurationSlider:SetMinMaxValues(1, 10)
        textDurationSlider:SetValueStep(0.5)
        textDurationSlider:SetValue(NoMercyListDB.settings.text.duration)
        
        local lowText = _G[textDurationSlider:GetName().."Low"]
        local highText = _G[textDurationSlider:GetName().."High"]
        local valueText = _G[textDurationSlider:GetName().."Text"]
        
        if lowText then lowText:SetText("1s") end
        if highText then highText:SetText("10s") end
        if valueText then valueText:SetText(string.format("%.1fs", NoMercyListDB.settings.text.duration)) end
        
        textDurationSlider:SetScript("OnValueChanged", function(self, value)
            NoMercyListDB.settings.text.duration = value
            local txt = _G[self:GetName().."Text"]
            if txt then txt:SetText(string.format("%.1fs", value)) end
        end)
        
        yOffset = yOffset - 35
        
        -- Position du texte
        local posLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        posLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        posLabel:SetText("Position :")
        
        yOffset = yOffset - 35
        
        local positions = {
            {value = "TOP", text = "Haut"},
            {value = "CENTER", text = "Centre"},
            {value = "BOTTOM", text = "Bas"},
        }
        
        local posButtons = {}
        for i, pos in ipairs(positions) do
            local btn = CreateFrame("CheckButton", "NMLPosBtn"..pos.value, scrollChild, "UIRadioButtonTemplate")
            if i == 1 then
                btn:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
            else
                btn:SetPoint("LEFT", posButtons[i-1], "RIGHT", 80, 0)
            end
            btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            btn.text:SetPoint("LEFT", btn, "RIGHT", 5, 0)
            btn.text:SetText(pos.text)
            btn:SetChecked(NoMercyListDB.settings.text.position == pos.value)
            btn:SetScript("OnClick", function()
                NoMercyListDB.settings.text.position = pos.value
                for _, b in pairs(posButtons) do
                    b:SetChecked(false)
                end
                btn:SetChecked(true)
            end)
            posButtons[i] = btn
        end
        
        yOffset = yOffset - 35
        
        -- Taille du texte
        local sizeLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        sizeLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        sizeLabel:SetText("Taille police :")
        
        yOffset = yOffset - 35
        local sizeSlider = CreateFrame("Slider", "NMLSizeSlider", scrollChild, "OptionsSliderTemplate")
        sizeSlider:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
        sizeSlider:SetWidth(200)
        sizeSlider:SetMinMaxValues(12, 48)
        sizeSlider:SetValueStep(2)
        sizeSlider:SetValue(NoMercyListDB.settings.text.size)
        
        local lowText = _G[sizeSlider:GetName().."Low"]
        local highText = _G[sizeSlider:GetName().."High"]
        local valueText = _G[sizeSlider:GetName().."Text"]
        
        if lowText then lowText:SetText("12") end
        if highText then highText:SetText("48") end
        if valueText then valueText:SetText(tostring(math.floor(NoMercyListDB.settings.text.size))) end
        
        sizeSlider:SetScript("OnValueChanged", function(self, value)
            value = math.floor(value)  -- Arrondir à l'entier
            NoMercyListDB.settings.text.size = value
            local txt = _G[self:GetName().."Text"]
            if txt then txt:SetText(tostring(value)) end
        end)
        
        yOffset = yOffset - 35
        
        -- Éléments à afficher
        local elemLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        elemLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        elemLabel:SetText("Elements affiches dans le texte :")
        
        yOffset = yOffset - 35
        
        local textElements = {
            {key = "showClass", label = "Classe"},
            {key = "showRatio", label = "Ratio K/D"},
            {key = "showHateLevel", label = "Niveau de haine"},
        }
        
        for i, elem in ipairs(textElements) do
            local cb = CreateFrame("CheckButton", "NMLTextElem"..elem.key, scrollChild, "UICheckButtonTemplate")
            cb:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
            cb.text = cb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            cb.text:SetPoint("LEFT", cb, "RIGHT", 5, 0)
            cb.text:SetText(elem.label)
            cb:SetChecked(NoMercyListDB.settings.text[elem.key])
            cb:SetScript("OnClick", function(self)
                NoMercyListDB.settings.text[elem.key] = self:GetChecked()
            end)
            yOffset = yOffset - 30
        end
        
        yOffset = yOffset - 10
        
        -- Bouton Test Texte d'Alerte
        local testTextBtn = CreateFrame("Button", nil, scrollChild, "UIPanelButtonTemplate")
        testTextBtn:SetSize(150, 22)
        testTextBtn:SetText("Tester texte d'alerte")
        testTextBtn:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        testTextBtn:SetScript("OnClick", function()
            -- Créer un faux joueur pour tester
            ShowAlertText("TestPlayer | Voleur | Ratio: 2.5", 2)
        end)
        
        yOffset = yOffset - 40
        
        -- ====================================================================
        -- SECTION 3 : SON D'ALERTE
        -- ====================================================================
        MakeSectionTitle("Son d'alerte", yOffset)
        yOffset = yOffset - 35
        
        -- Checkbox activation/désactivation
        local enableSoundCb = CreateFrame("CheckButton", "NMLEnableSoundCheckbox", scrollChild, "UICheckButtonTemplate")
        enableSoundCb:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        enableSoundCb.text = enableSoundCb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        enableSoundCb.text:SetPoint("LEFT", enableSoundCb, "RIGHT", 5, 0)
        enableSoundCb.text:SetText("Activer l'alerte sonore")
        enableSoundCb:SetChecked(NoMercyListDB.settings.sound.enabled)
        enableSoundCb:SetScript("OnClick", function(self)
            NoMercyListDB.settings.sound.enabled = self:GetChecked()
        end)
        
        yOffset = yOffset - 40
        
        local soundLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        soundLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        soundLabel:SetText("Choisir un son :")
        
        yOffset = yOffset - 35
        
        -- Liste de sons disponibles
        local sounds = {
            {id = 8959, name = "Raid Warning"},
            {id = 11466, name = "Alarme Invasion"},
            {id = 3081, name = "Cloche"},
            {id = 8068, name = "Gong"},
            {id = 8960, name = "Alert 1"},  -- Changé de 8959 à 8960
            {id = 12867, name = "Alert 2"},
            {id = 6594, name = "Whisper"},
            {id = 6595, name = "Tell"},
            {id = 3332, name = "Horn"},
            {id = 8960, name = "PvP Flag"},
        }
        
        local soundDropdown = CreateFrame("Frame", "NMLSoundDropdown", scrollChild, "UIDropDownMenuTemplate")
        soundDropdown:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 10, yOffset)
        
        UIDropDownMenu_SetWidth(soundDropdown, 200)
        UIDropDownMenu_SetText(soundDropdown, "Selectionner...")
        
        local function OnSoundClick(self)
            NoMercyListDB.settings.sound.id = self.value
            UIDropDownMenu_SetText(soundDropdown, self:GetText())
            PlaySound(self.value, "Master")
        end
        
        local function InitializeSoundDropdown()
            local info = UIDropDownMenu_CreateInfo()
            for _, snd in ipairs(sounds) do
                info.text = snd.name
                info.value = snd.id
                info.func = OnSoundClick
                info.checked = (NoMercyListDB.settings.sound.id == snd.id)
                UIDropDownMenu_AddButton(info)
            end
        end
        
        UIDropDownMenu_Initialize(soundDropdown, InitializeSoundDropdown)
        
        -- Set initial text
        for _, snd in ipairs(sounds) do
            if snd.id == NoMercyListDB.settings.sound.id then
                UIDropDownMenu_SetText(soundDropdown, snd.name)
                break
            end
        end
        
        yOffset = yOffset - 50
        
        -- ====================================================================
        -- SECTION 4 : FRÉQUENCE D'ALERTE
        -- ====================================================================
        MakeSectionTitle("Frequence d'alerte", yOffset)
        yOffset = yOffset - 35
        
        local cooldownLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        cooldownLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        cooldownLabel:SetText("Delai entre alertes (sec) :")
        
        yOffset = yOffset - 35
        local cooldownSlider = CreateFrame("Slider", "NMLCooldownSlider", scrollChild, "OptionsSliderTemplate")
        cooldownSlider:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
        cooldownSlider:SetWidth(200)
        cooldownSlider:SetMinMaxValues(1, 60)
        cooldownSlider:SetValueStep(1)
        cooldownSlider:SetValue(NoMercyListDB.settings.alertCooldown)
        
        local lowText = _G[cooldownSlider:GetName().."Low"]
        local highText = _G[cooldownSlider:GetName().."High"]
        local valueText = _G[cooldownSlider:GetName().."Text"]
        
        if lowText then lowText:SetText("1s") end
        if highText then highText:SetText("60s") end
        if valueText then valueText:SetText(tostring(math.floor(NoMercyListDB.settings.alertCooldown)).."s") end
        
        cooldownSlider:SetScript("OnValueChanged", function(self, value)
            value = math.floor(value)  -- Arrondir à l'entier
            NoMercyListDB.settings.alertCooldown = value
            local txt = _G[self:GetName().."Text"]
            if txt then txt:SetText(tostring(value).."s") end
        end)
        
        yOffset = yOffset - 50
        
        -- ====================================================================
        -- SECTION 5 : COLONNES AFFICHÉES
        -- ====================================================================
        MakeSectionTitle("Colonnes affichees", yOffset)
        yOffset = yOffset - 35
        
        local columnsLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        columnsLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, yOffset)
        columnsLabel:SetText("Cocher les colonnes a afficher :")
        
        yOffset = yOffset - 35
        
        local columnsList = {
            {key = "level", label = "Niveau"},
            {key = "class", label = "Classe"},
            {key = "guild", label = "Guilde"},
            {key = "deaths", label = "Morts"},
            {key = "kills", label = "Kills"},
            {key = "ratio", label = "Ratio"},
            {key = "hateLevel", label = "Niveau haine"},
            {key = "lastSeen", label = "Derniere vue"},
            {key = "delete", label = "Bouton supprimer"},
        }
        
        for i, col in ipairs(columnsList) do
            local cb = CreateFrame("CheckButton", "NMLCol"..col.key, scrollChild, "UICheckButtonTemplate")
            cb:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 30, yOffset)
            
            cb.text = cb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            cb.text:SetPoint("LEFT", cb, "RIGHT", 5, 0)
            cb.text:SetText(col.label)
            cb:SetChecked(NoMercyListDB.settings.columns[col.key])
            cb:SetScript("OnClick", function(self)
                NoMercyListDB.settings.columns[col.key] = self:GetChecked()
                NoMercyList_Refresh()
            end)
            
            yOffset = yOffset - 30
        end
        
        yOffset = yOffset - 50
        
        
        -- ====================================================================
        -- ZONE 3 : BOUTONS BAS DE FENÊTRE (en bas, fixe, hors scroll)
        -- ====================================================================
        
        -- Bouton Réinitialiser
        local resetBtn = CreateFrame("Button", nil, sf, "UIPanelButtonTemplate")
        resetBtn:SetSize(120, 26)
        resetBtn:SetText("Reinitialiser")
        resetBtn:SetPoint("BOTTOMLEFT", sf, "BOTTOMLEFT", 15, 15)
        resetBtn:SetScript("OnClick", function()
            -- Réinitialise aux valeurs par défaut
            NoMercyListDB.settings.alert.enabled = true
            NoMercyListDB.settings.alert.color = {r = 0.6, g = 0.1, b = 0.8}
            NoMercyListDB.settings.alert.duration = 3
            NoMercyListDB.settings.alert.pulseFrequency = 0.15
            NoMercyListDB.settings.text.enabled = true
            NoMercyListDB.settings.text.color = {r = 1, g = 0, b = 1}
            NoMercyListDB.settings.text.position = "CENTER"
            NoMercyListDB.settings.text.size = 24
            NoMercyListDB.settings.text.showClass = true
            NoMercyListDB.settings.text.showRatio = true
            NoMercyListDB.settings.text.showHateLevel = true
            NoMercyListDB.settings.text.duration = 3
            NoMercyListDB.settings.sound.enabled = true
            NoMercyListDB.settings.sound.id = 8959
            NoMercyListDB.settings.alertCooldown = 30
            
            -- Ferme et réouvre la fenêtre pour rafraîchir
            sf:Hide()
            settingsFrame = nil
            NoMercyList_ShowSettings()
            
            print("|cff00ff00[No Mercy List]|r Parametres reinitialises !")
        end)
        
        -- Bouton Fermer
        local closeBtn = CreateFrame("Button", nil, sf, "UIPanelButtonTemplate")
        closeBtn:SetSize(120, 26)
        closeBtn:SetText("Fermer")
        closeBtn:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -15, 15)
        closeBtn:SetScript("OnClick", function() sf:Hide() end)
        
        settingsFrame = sf
    end
    
    settingsFrame:ClearAllPoints()
    if mainFrame and mainFrame:IsShown() then
        settingsFrame:SetPoint("LEFT", mainFrame, "RIGHT", 10, 0)
    else
        settingsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
    
    settingsFrame:Show()
end

-- ---------------------------------------------------------------------------
-- COMMANDES SLASH
-- ---------------------------------------------------------------------------

SLASH_NOMERCYLIST1 = "/nomercylist"
SLASH_NOMERCYLIST2 = "/nml"

SlashCmdList["NOMERCYLIST"] = function(msg)
    local cmd = (msg or ""):lower():match("^%s*(.-)%s*$")

    if cmd == "" or cmd == "show" or cmd == "toggle" then
        if not mainFrame then return end
        if mainFrame:IsShown() then mainFrame:Hide()
        else mainFrame:Show(); NoMercyList_Refresh() end

    elseif cmd == "debug" then
        -- Commande de debug pour voir l'état de l'historique
        print("|cff00ff00[No Mercy List Debug]|r Nom du joueur: " .. tostring(PLAYER_NAME))
        print("|cff00ff00[No Mercy List Debug]|r Nombre d'attaquants enregistres: " .. tostring(#GetRecentAttackers()))
        for name, data in pairs(attackerHistory) do
            local elapsed = GetTime() - data.lastAttackTime
            print("  - " .. name .. " (il y a " .. math.floor(elapsed) .. " sec)")
        end
        print("|cff00ff00[No Mercy List Debug]|r Joueurs dans la liste:")
        for name, _ in pairs(NoMercyListDB.players) do
            print("  - " .. name)
        end
        
    elseif cmd == "testalert" then
        -- Test manuel des alertes
        print("|cff00ff00[No Mercy List]|r === TEST DES ALERTES ===")
        TriggerScreenFlash()
        ShowAlertText("TEST ALERTE - Joueur Ennemi !")
        PlaySound(NoMercyListDB.settings.sound.id or 8959, "Master")
        print("Tu devrais voir:")
        print("   - Flash de bordure colore")
        print("   - Texte au centre de l'ecran")
        print("   - Son d'alerte")
        
    elseif cmd == "testscan" then
        -- Test manuel du scan
        print("|cff00ff00[No Mercy List]|r Test du scan manuel...")
        NoMercyList_ScanNearbyPlayers()
        
    elseif cmd == "testupdate" then
        -- Test de mise à jour forcée de lastSeen + niveau/classe/guilde sur la cible
        if not UnitExists("target") then
            print("|cffff0000[Test]|r Aucune cible")
            return
        end
        local name = UnitName("target")
        print("|cff00ff00[Test]|r Cible : " .. (name or "nil"))
        print("|cff00ff00[Test]|r Dans la liste ? " .. tostring(PlayerInList(name)))
        
        if PlayerInList(name) then
            local oldLevel = NoMercyListDB.players[name].level
            local oldGuild = NoMercyListDB.players[name].guild
            
            print("|cff00ff00[Test]|r Appel UpdateLastSeen avec unitToken...")
            UpdateLastSeen(name, "target")  -- Passe le unitToken
            
            local newLevel = NoMercyListDB.players[name].level
            local newGuild = NoMercyListDB.players[name].guild
            
            print("|cff00ff00[Test]|r Niveau : " .. tostring(oldLevel) .. " -> " .. tostring(newLevel))
            print("|cff00ff00[Test]|r Guilde : '" .. tostring(oldGuild) .. "' -> '" .. tostring(newGuild) .. "'")
            
            print("|cff00ff00[Test]|r Refresh UI...")
            if mainFrame and mainFrame:IsShown() then
                NoMercyList_Refresh()
            end
            print("|cff00ff00[Test]|r TERMINE - Verifie ta fenetre No Mercy List")
        else
            print("|cffff0000[Test]|r " .. name .. " PAS dans la liste")
            print("|cffff0000[Test]|r Liste actuelle :")
            for n, _ in pairs(NoMercyListDB.players) do
                print("  - " .. n)
            end
        end

    elseif cmd == "history" or cmd == "hist" then
        -- Ouvre la fenêtre d'historique
        NoMercyList_ShowAttackerHistory()
    
    elseif cmd == "reset" then
        -- Réinitialise tous les paramètres par défaut
        print("|cffff8800[No Mercy List]|r Reinitialisation des parametres...")
        NoMercyListDB.settings = nil  -- Force la réinitialisation
        InitDB()  -- Recrée les settings par défaut
        print("|cff00ff00[No Mercy List]|r Parametres reinitialises aux valeurs par defaut!")
        print("|cff00ff00[No Mercy List]|r Fais /reload pour appliquer tous les changements")
        
    elseif cmd == "settings" or cmd == "config" or cmd == "parametres" then
        -- Ouvre la fenêtre de paramètres
        NoMercyList_ShowSettings()
    
    elseif cmd == "nearby" or cmd == "ennemis" then
        -- Toggle la fenêtre "Ennemis à portée" (v1.1)
        NoMercyList_ToggleNearby()

    elseif cmd == "add" or cmd == "target" then
        -- Ajoute la cible courante (ou ouvre la popup si pas de cible)
        NoMercyList_TryAddTarget()

    elseif cmd:sub(1,4) == "add " then
        -- /kl add NomJoueur : saisie manuelle via slash
        local name = msg:sub(5)
        local ok, result = AddPlayerToList(name, 0, "")
        if ok then
            NoMercyList_Refresh()
            print("|cff00ff00[No Mercy List]|r " .. result .. " ajoute (niveau/classe inconnus).")
        elseif result == "doublon" then
            print("|cffff4444[No Mercy List]|r Deja dans la liste.")
        else
            print("|cffff4444[No Mercy List]|r Nom invalide.")
        end

    elseif cmd == "help" then
        print("|cff00ff00[No Mercy List]|r Commandes :")
        print("  /nml              Afficher/masquer")
        print("  /nml nearby       Toggle 'Ennemis a portee' (v1.1)")
        print("  /nml history      Historique des attaquants (5 min)")
        print("  /nml settings     Ouvrir les parametres")
        print("  /nml add          Ajouter la cible (avec niveau+classe+guilde)")
        print("  /nml add <nom>    Ajouter par nom (niveau/classe inconnus)")
        print("  /nml debug        Affiche les infos de debug")
        print("  /nml testalert    Test des alertes visuelles + son")
        print("  /nml help         Cette aide")
    else
        if mainFrame then
            if mainFrame:IsShown() then mainFrame:Hide()
            else mainFrame:Show(); NoMercyList_Refresh() end
        end
    end
end