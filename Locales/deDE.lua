-- =============================================================================
-- NoMercyList - Locale : Deutsch (deDE)
-- =============================================================================

if GetLocale() ~= "deDE" then return end

local L = NoMercyList_L

-- Fenstertitel
L["WIN_ADD"]            = "Spieler hinzufügen"
L["WIN_HISTORY"]        = "Angreifer-Verlauf (5 Min.)"
L["WIN_SETTINGS"]       = "Einstellungen"

-- Nahes-Feinde-Fenster
L["NEARBY_LISTED"]      = "Meine nahen Feinde"
L["NEARBY_OTHERS"]      = "Nahe Feinde"

-- Schaltflächen
L["BTN_ADD_PLAYER"]     = "Spieler hinzufügen"
L["BTN_HISTORY"]        = "Angreifer-Verlauf"
L["BTN_ADD"]            = "Hinzufügen"
L["BTN_CANCEL"]         = "Abbrechen"
L["BTN_REFRESH"]        = "Aktualisieren"
L["BTN_CLOSE"]          = "Schließen"
L["BTN_ADD_TO_LIST"]    = "Zur Liste hinzufügen"
L["BTN_ALREADY_ADDED"]  = "Bereits hinzugefügt"
L["BTN_ALREADY_LISTED"] = "Bereits auf der Liste"
L["BTN_TEST_VISUAL"]    = "Visuellen Alarm testen"
L["BTN_TEST_TEXT"]      = "Text-Alarm testen"
L["BTN_RESET"]          = "Zurücksetzen"

-- Spaltenüberschriften
L["COL_NAME"]           = "Spielername"
L["COL_LEVEL"]          = "Stufe"
L["COL_CLASS"]          = "Klasse"
L["COL_GUILD"]          = "Gilde"
L["COL_DEATHS"]         = "Tode"
L["COL_KILLS"]          = "Kills"
L["COL_RATIO"]          = "Ratio"
L["COL_HATE"]           = "Hass"
L["COL_LASTSEEN"]       = "Zuletzt gesehen"

-- Tooltips
L["TIP_ADD_PLAYER"]     = "Spieler hinzufügen"
L["TIP_ADD_ENEMY"]      = "Aktives Feindziel:"
L["TIP_ADD_ENEMY2"]     = "  Fügt Ziel mit Stufe und Klasse hinzu"
L["TIP_ADD_NOTARGET"]   = "Ohne Ziel:"
L["TIP_ADD_NOTARGET2"]  = "  Öffnet manuelle Eingabe"
L["TIP_HISTORY"]        = "Angreifer-Verlauf"
L["TIP_HISTORY2"]       = "Zeigt Feinde, die Sie in den letzten"
L["TIP_HISTORY3"]       = "5 Minuten angegriffen haben"
L["TIP_SETTINGS"]       = "Einstellungen"
L["TIP_SETTINGS2"]      = "Visuelle Alarme konfigurieren"
L["TIP_NEARBY"]         = "Nahe Feinde"
L["TIP_NEARBY2"]        = "Liste der nahen Feinde ein-/ausblenden"
L["TIP_MINIMAP2"]       = "Klick: anzeigen/verbergen"
L["TIP_MINIMAP3"]       = "Ziehen: frei positionieren"

-- Einstellungen — Abschnittstitel
L["SET_SEC_BORDER"]     = "Visueller Alarm (Rahmen)"
L["SET_SEC_TEXT"]       = "Alarmtext"
L["SET_SEC_SOUND"]      = "Alarmton"
L["SET_SEC_COOLDOWN"]   = "Alarmhäufigkeit"
L["SET_SEC_COLUMNS"]    = "Angezeigte Spalten"
L["SET_SEC_NEARBY"]     = "Meine nahen Feinde"
L["SET_SEC_OTHERS"]     = "Nahe Feinde (nicht gelistet)"
L["SET_SEC_MINIMAP"]    = "Minimap-Schaltfläche"

-- Einstellungen — Labels
L["SET_BORDER_ENABLE"]  = "Rahmenalarm aktivieren"
L["SET_COLOR"]          = "Farbe:"
L["SET_CLICK_CHOOSE"]   = "Klicken zum Wählen"
L["SET_BORDER_DUR"]     = "Dauer Rahmenblitzen (Sek.):"
L["SET_BORDER_SPEED"]   = "Geschwindigkeit Rahmenblitzen:"
L["SET_SPEED_FAST"]     = "Schnell"
L["SET_SPEED_SLOW"]     = "Langsam"
L["SET_TEXT_ENABLE"]    = "Textalarm aktivieren"
L["SET_TEXT_COLOR"]     = "Textfarbe:"
L["SET_TEXT_DUR"]       = "Textanzeigedauer (Sek.):"
L["SET_POSITION"]       = "Position:"
L["SET_POS_TOP"]        = "Oben"
L["SET_POS_CENTER"]     = "Mitte"
L["SET_POS_BOTTOM"]     = "Unten"
L["SET_FONT_SIZE"]      = "Schriftgröße:"
L["SET_ELEMENTS"]       = "Im Text angezeigte Elemente:"
L["SET_SHOW_CLASS"]     = "Klasse"
L["SET_SHOW_RATIO"]     = "K/T-Ratio"
L["SET_SHOW_HATE"]      = "Hassstufe"
L["SET_SOUND_ENABLE"]   = "Tonalarm aktivieren"
L["SET_SOUND_CHOOSE"]   = "Ton wählen:"
L["SET_SOUND_SELECT"]   = "Auswählen..."
L["SET_COOLDOWN"]       = "Verzögerung zwischen Alarmen (Sek.):"
L["SET_COL_LABEL"]      = "Anzuzeigende Spalten auswählen:"
L["SET_COL_LEVEL"]      = "Stufe"
L["SET_COL_CLASS"]      = "Klasse"
L["SET_COL_GUILD"]      = "Gilde"
L["SET_COL_DEATHS"]     = "Tode"
L["SET_COL_KILLS"]      = "Kills"
L["SET_COL_RATIO"]      = "Ratio"
L["SET_COL_HATE"]       = "Hassstufe"
L["SET_COL_LASTSEEN"]   = "Zuletzt gesehen"
L["SET_COL_DELETE"]     = "Löschen-Schaltfläche"
L["SET_NEARBY_LISTED"]  = "Meine gelisteten Feinde anzeigen"
L["SET_MAX_ENTRIES"]    = "Max. Einträge:"
L["SET_EXPIRE_TIME"]    = "Ablaufzeit (Sek.):"
L["SET_SCALE"]          = "Skalierung:"
L["SET_OPACITY"]        = "Hintergrundopazität:"
L["SET_OTHERS_SHOW"]    = "Nicht gelistete Feinde anzeigen"
L["SET_MINIMAP_SHOW"]   = "Minimap-Schaltfläche anzeigen"

-- Sounds
L["SOUND_ALARM"]        = "Invasionsalarm"
L["SOUND_BELL"]         = "Glocke"

-- Nachrichten
L["MSG_ADDED_TARGET"]   = " von Ziel hinzugefügt."
L["MSG_ALREADY_LISTED"] = " ist bereits auf der Liste."
L["MSG_CANT_ADD"]       = "Dieses Ziel kann nicht hinzugefügt werden."
L["MSG_ADDED"]          = "Hinzugefügt: "
L["MSG_ALREADY_SHORT"]  = "Bereits auf der Liste."
L["MSG_INVALID_NAME"]   = "Ungültiger oder leerer Name."
L["MSG_HINT"]           = "Tipp: Ziele den Spieler an, bevor du klickst,\num seine Stufe und Klasse zu erhalten."
L["MSG_EMPTY_LIST"]     = "Liste leer. Ziele einen Feind an und klicke Hinzufügen."
L["MSG_NO_ATTACKERS"]   = "Keine kürzlichen Angreifer.\nSpieler, die Sie angreifen, erscheinen hier."
L["MSG_COUNT"]          = " verfolgte(r) Spieler"
L["MSG_RESET_OK"]       = "Einstellungen zurückgesetzt!"
L["MSG_ADDED_HIST"]     = " aus Verlauf hinzugefügt."
L["MSG_ADDED_MANUAL"]   = " hinzugefügt (Stufe/Klasse unbekannt)."
L["MSG_ALREADY_LIST2"]  = "Bereits auf der Liste."
L["MSG_INVALID"]        = "Ungültiger Name."

-- Hassstufen
L["HATE_1"]             = "Peon"
L["HATE_2"]             = "Grunt"
L["HATE_3"]             = "Erzfeind"

-- Zeitformate
L["TIME_NEVER"]         = "Nie"
L["TIME_NOW"]           = "Jetzt"
L["TIME_MIN"]           = "Vor %d Min."
L["TIME_HOUR"]          = "Vor %d Std."
L["TIME_DAY"]           = "Vor %d Tagen"
L["TIME_SEC"]           = "Vor %d Sek."

-- Angreifer-Verlauf
L["HIST_KILL"]          = "Kill"
L["HIST_DEATH"]         = "Tod"
L["HIST_FIGHT"]         = " | Kampf"
L["HIST_LEVEL"]         = " (Stufe "

-- Alarmtext
L["ALERT_RATIO"]        = "Ratio: "
L["ALERT_LEVEL"]        = "Stufe "

-- Klassennamen
L["CLASS_WARRIOR"]      = "Krieger"
L["CLASS_PALADIN"]      = "Paladin"
L["CLASS_HUNTER"]       = "Jäger"
L["CLASS_ROGUE"]        = "Schurke"
L["CLASS_PRIEST"]       = "Priester"
L["CLASS_SHAMAN"]       = "Schamane"
L["CLASS_MAGE"]         = "Magier"
L["CLASS_WARLOCK"]      = "Hexenmeister"
L["CLASS_DRUID"]        = "Druide"
L["CLASS_DEATHKNIGHT"]  = "Todesritter"

-- Slash-Hilfe
L["HELP_COMMANDS"]      = "Befehle:"
L["HELP_SHOW"]          = "  /nml              Anzeigen/Verbergen"
L["HELP_NEARBY"]        = "  /nml nearby       'Nahe Feinde' umschalten"
L["HELP_HISTORY"]       = "  /nml history      Angreifer-Verlauf (5 Min.)"
L["HELP_SETTINGS"]      = "  /nml settings     Einstellungen öffnen"
L["HELP_ADD"]           = "  /nml add          Aktuelles Ziel hinzufügen"
L["HELP_ADD_NAME"]      = "  /nml add <Name>   Nach Name hinzufügen"
L["HELP_DEBUG"]         = "  /nml debug        Debug-Infos anzeigen"
L["HELP_TEST"]          = "  /nml testalert    Alarm testen"
L["HELP_HELP"]          = "  /nml help         Diese Hilfe"
