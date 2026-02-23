-- =============================================================================
-- NoMercyList - Locale : English (enUS)
-- =============================================================================

if GetLocale() ~= "enUS" then return end

local L = NoMercyList_L

-- Window titles
L["WIN_ADD"]            = "Add a player"
L["WIN_HISTORY"]        = "Attacker History (5 min)"
L["WIN_SETTINGS"]       = "Settings"

-- Nearby frame
L["NEARBY_LISTED"]      = "My nearby enemies"
L["NEARBY_OTHERS"]      = "Nearby enemies"

-- Buttons
L["BTN_ADD_PLAYER"]     = "Add a player"
L["BTN_HISTORY"]        = "Attacker history"
L["BTN_ADD"]            = "Add"
L["BTN_CANCEL"]         = "Cancel"
L["BTN_REFRESH"]        = "Refresh"
L["BTN_CLOSE"]          = "Close"
L["BTN_ADD_TO_LIST"]    = "Add to list"
L["BTN_ALREADY_ADDED"]  = "Already added"
L["BTN_ALREADY_LISTED"] = "Already in list"
L["BTN_TEST_VISUAL"]    = "Test visual alert"
L["BTN_TEST_TEXT"]      = "Test text alert"
L["BTN_RESET"]          = "Reset"

-- Column headers
L["COL_NAME"]           = "Player name"
L["COL_LEVEL"]          = "Level"
L["COL_CLASS"]          = "Class"
L["COL_GUILD"]          = "Guild"
L["COL_DEATHS"]         = "Deaths"
L["COL_KILLS"]          = "Kills"
L["COL_RATIO"]          = "Ratio"
L["COL_HATE"]           = "Hate"
L["COL_LASTSEEN"]       = "Last seen"

-- Tooltips
L["TIP_ADD_PLAYER"]     = "Add a player"
L["TIP_ADD_ENEMY"]      = "Active enemy target:"
L["TIP_ADD_ENEMY2"]     = "  Adds target with level and class"
L["TIP_ADD_NOTARGET"]   = "Without target:"
L["TIP_ADD_NOTARGET2"]  = "  Opens manual input"
L["TIP_HISTORY"]        = "Attacker history"
L["TIP_HISTORY2"]       = "Shows enemy players who attacked"
L["TIP_HISTORY3"]       = "you in the last 5 minutes"
L["TIP_SETTINGS"]       = "Settings"
L["TIP_SETTINGS2"]      = "Configure visual alerts"
L["TIP_NEARBY"]         = "Nearby enemies"
L["TIP_NEARBY2"]        = "Show/hide the nearby enemy list"
L["TIP_MINIMAP2"]       = "Click: show/hide"
L["TIP_MINIMAP3"]       = "Drag: reposition freely"

-- Settings — section titles
L["SET_SEC_BORDER"]     = "Visual alert (border)"
L["SET_SEC_TEXT"]       = "Alert text"
L["SET_SEC_SOUND"]      = "Alert sound"
L["SET_SEC_COOLDOWN"]   = "Alert frequency"
L["SET_SEC_COLUMNS"]    = "Displayed columns"
L["SET_SEC_NEARBY"]     = "My nearby enemies"
L["SET_SEC_OTHERS"]     = "Nearby enemies (not on list)"
L["SET_SEC_MINIMAP"]    = "Minimap button"

-- Settings — labels
L["SET_BORDER_ENABLE"]  = "Enable border alert"
L["SET_COLOR"]          = "Color:"
L["SET_CLICK_CHOOSE"]   = "Click to choose"
L["SET_BORDER_DUR"]     = "Border flash duration (sec):"
L["SET_BORDER_SPEED"]   = "Border flash speed:"
L["SET_SPEED_FAST"]     = "Fast"
L["SET_SPEED_SLOW"]     = "Slow"
L["SET_TEXT_ENABLE"]    = "Enable text alert"
L["SET_TEXT_COLOR"]     = "Text color:"
L["SET_TEXT_DUR"]       = "Text display duration (sec):"
L["SET_POSITION"]       = "Position:"
L["SET_POS_TOP"]        = "Top"
L["SET_POS_CENTER"]     = "Center"
L["SET_POS_BOTTOM"]     = "Bottom"
L["SET_FONT_SIZE"]      = "Font size:"
L["SET_ELEMENTS"]       = "Elements shown in text:"
L["SET_SHOW_CLASS"]     = "Class"
L["SET_SHOW_RATIO"]     = "K/D Ratio"
L["SET_SHOW_HATE"]      = "Hate level"
L["SET_SOUND_ENABLE"]   = "Enable sound alert"
L["SET_SOUND_CHOOSE"]   = "Choose a sound:"
L["SET_SOUND_SELECT"]   = "Select..."
L["SET_COOLDOWN"]       = "Delay between alerts (sec):"
L["SET_COL_LABEL"]      = "Check columns to display:"
L["SET_COL_LEVEL"]      = "Level"
L["SET_COL_CLASS"]      = "Class"
L["SET_COL_GUILD"]      = "Guild"
L["SET_COL_DEATHS"]     = "Deaths"
L["SET_COL_KILLS"]      = "Kills"
L["SET_COL_RATIO"]      = "Ratio"
L["SET_COL_HATE"]       = "Hate level"
L["SET_COL_LASTSEEN"]   = "Last seen"
L["SET_COL_DELETE"]     = "Delete button"
L["SET_NEARBY_LISTED"]  = "Show my listed enemies"
L["SET_MAX_ENTRIES"]    = "Max entries:"
L["SET_EXPIRE_TIME"]    = "Expiration delay (sec):"
L["SET_SCALE"]          = "Scale:"
L["SET_OPACITY"]        = "Background opacity:"
L["SET_OTHERS_SHOW"]    = "Show unlisted enemies"
L["SET_MINIMAP_SHOW"]   = "Show minimap button"

-- Sounds
L["SOUND_ALARM"]        = "Invasion Alarm"
L["SOUND_BELL"]         = "Bell"

-- Messages
L["MSG_ADDED_TARGET"]   = " added from target."
L["MSG_ALREADY_LISTED"] = " is already in the list."
L["MSG_CANT_ADD"]       = "Cannot add this target."
L["MSG_ADDED"]          = "Added: "
L["MSG_ALREADY_SHORT"]  = "Already in the list."
L["MSG_INVALID_NAME"]   = "Invalid or empty name."
L["MSG_HINT"]           = "Tip: target the player before clicking\nto get their level and class."
L["MSG_EMPTY_LIST"]     = "Empty list. Target an enemy player and click Add."
L["MSG_NO_ATTACKERS"]   = "No recent attackers.\nPlayers who attack you will appear here."
L["MSG_COUNT"]          = " player(s) tracked"
L["MSG_RESET_OK"]       = "Settings reset!"
L["MSG_ADDED_HIST"]     = " added from history."
L["MSG_ADDED_MANUAL"]   = " added (level/class unknown)."
L["MSG_ALREADY_LIST2"]  = "Already in the list."
L["MSG_INVALID"]        = "Invalid name."

-- Hate levels
L["HATE_1"]             = "Peon"
L["HATE_2"]             = "Grunt"
L["HATE_3"]             = "Nemesis"

-- Time formats
L["TIME_NEVER"]         = "Never"
L["TIME_NOW"]           = "Now"
L["TIME_MIN"]           = "%d min ago"
L["TIME_HOUR"]          = "%d h ago"
L["TIME_DAY"]           = "%d d ago"
L["TIME_SEC"]           = "%d sec ago"

-- Attacker history
L["HIST_KILL"]          = "Kill"
L["HIST_DEATH"]         = "Death"
L["HIST_FIGHT"]         = " | Fight"
L["HIST_LEVEL"]         = " (Lvl "

-- Alert text
L["ALERT_RATIO"]        = "Ratio: "
L["ALERT_LEVEL"]        = "Lvl "

-- Class names
L["CLASS_WARRIOR"]      = "Warrior"
L["CLASS_PALADIN"]      = "Paladin"
L["CLASS_HUNTER"]       = "Hunter"
L["CLASS_ROGUE"]        = "Rogue"
L["CLASS_PRIEST"]       = "Priest"
L["CLASS_SHAMAN"]       = "Shaman"
L["CLASS_MAGE"]         = "Mage"
L["CLASS_WARLOCK"]      = "Warlock"
L["CLASS_DRUID"]        = "Druid"
L["CLASS_DEATHKNIGHT"]  = "Death Knight"

-- Slash help
L["HELP_COMMANDS"]      = "Commands:"
L["HELP_SHOW"]          = "  /nml              Show/hide"
L["HELP_NEARBY"]        = "  /nml nearby       Toggle 'Nearby enemies'"
L["HELP_HISTORY"]       = "  /nml history      Attacker history (5 min)"
L["HELP_SETTINGS"]      = "  /nml settings     Open settings"
L["HELP_ADD"]           = "  /nml add          Add current target"
L["HELP_ADD_NAME"]      = "  /nml add <name>   Add by name"
L["HELP_DEBUG"]         = "  /nml debug        Show debug info"
L["HELP_TEST"]          = "  /nml testalert    Test alerts + sound"
L["HELP_HELP"]          = "  /nml help         This help"
