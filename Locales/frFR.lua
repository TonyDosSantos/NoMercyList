-- =============================================================================
-- NoMercyList - Locale : Français (frFR)
-- Fichier de base / fallback universel — toujours chargé en premier
-- =============================================================================

local L = NoMercyList_L

-- Titres de fenêtres
L["WIN_MAIN"]           = "No Mercy List v1.4.4"
L["WIN_ADD"]            = "Ajouter un joueur"
L["WIN_HISTORY"]        = "Historique des attaquants (5 min)"
L["WIN_SETTINGS"]       = "Réglages"

-- Cadre "Ennemis à portée"
L["NEARBY_LISTED"]      = "Mes ennemis à portée"
L["NEARBY_OTHERS"]      = "Ennemis à portée"

-- Boutons
L["BTN_ADD_PLAYER"]     = "Ajouter un joueur"
L["BTN_HISTORY"]        = "Historique attaquants"
L["BTN_ADD"]            = "Ajouter"
L["BTN_CANCEL"]         = "Annuler"
L["BTN_REFRESH"]        = "Rafraichir"
L["BTN_CLOSE"]          = "Fermer"
L["BTN_ADD_TO_LIST"]    = "Ajouter a la liste"
L["BTN_ALREADY_ADDED"]  = "Deja ajoute"
L["BTN_ALREADY_LISTED"] = "Deja dans la liste"
L["BTN_TEST_VISUAL"]    = "Tester alerte visuelle"
L["BTN_TEST_TEXT"]      = "Tester texte d'alerte"
L["BTN_RESET"]          = "Reinitialiser"

-- En-têtes de colonnes
L["COL_NAME"]           = "Nom du joueur"
L["COL_LEVEL"]          = "Niveau"
L["COL_CLASS"]          = "Classe"
L["COL_GUILD"]          = "Guilde"
L["COL_DEATHS"]         = "Morts"
L["COL_KILLS"]          = "Kills"
L["COL_RATIO"]          = "Ratio"
L["COL_HATE"]           = "Haine"
L["COL_LASTSEEN"]       = "Derniere vue"
L["COL_DELETE"]         = "X"

-- Tooltips
L["TIP_ADD_PLAYER"]     = "Ajouter un joueur"
L["TIP_ADD_ENEMY"]      = "Cible ennemie active :"
L["TIP_ADD_ENEMY2"]     = "  Ajoute la cible avec niveau et classe"
L["TIP_ADD_NOTARGET"]   = "Sans cible :"
L["TIP_ADD_NOTARGET2"]  = "  Ouvre la saisie manuelle"
L["TIP_HISTORY"]        = "Historique des attaquants"
L["TIP_HISTORY2"]       = "Affiche les joueurs ennemis qui vous ont"
L["TIP_HISTORY3"]       = "attaque au cours des 5 dernieres minutes"
L["TIP_SETTINGS"]       = "Parametres"
L["TIP_SETTINGS2"]      = "Configurer les alertes visuelles"
L["TIP_NEARBY"]         = "Ennemis a portee"
L["TIP_NEARBY2"]        = "Afficher/masquer la liste des ennemis proches"
L["TIP_MINIMAP"]        = "No Mercy List"
L["TIP_MINIMAP2"]       = "Clic : afficher/masquer"
L["TIP_MINIMAP3"]       = "Glisser : repositionner librement"

-- Paramètres — titres de sections
L["SET_SEC_BORDER"]     = "Alerte visuelle (bordure)"
L["SET_SEC_TEXT"]       = "Texte d'alerte"
L["SET_SEC_SOUND"]      = "Son d'alerte"
L["SET_SEC_COOLDOWN"]   = "Frequence d'alerte"
L["SET_SEC_COLUMNS"]    = "Colonnes affichees"
L["SET_SEC_NEARBY"]     = "Mes ennemis a portee"
L["SET_SEC_OTHERS"]     = "Ennemis a portee (hors liste)"
L["SET_SEC_MINIMAP"]    = "Bouton minimap"

-- Paramètres — labels
L["SET_BORDER_ENABLE"]  = "Activer l'alerte bordure"
L["SET_COLOR"]          = "Couleur :"
L["SET_CLICK_CHOOSE"]   = "Cliquer pour choisir"
L["SET_BORDER_DUR"]     = "Duree clignotement bordure (sec) :"
L["SET_BORDER_SPEED"]   = "Vitesse clignotement bordure :"
L["SET_SPEED_FAST"]     = "Rapide"
L["SET_SPEED_SLOW"]     = "Lent"
L["SET_TEXT_ENABLE"]    = "Activer l'alerte texte"
L["SET_TEXT_COLOR"]     = "Couleur du texte :"
L["SET_TEXT_DUR"]       = "Duree affichage texte (sec) :"
L["SET_POSITION"]       = "Position :"
L["SET_POS_TOP"]        = "Haut"
L["SET_POS_CENTER"]     = "Centre"
L["SET_POS_BOTTOM"]     = "Bas"
L["SET_FONT_SIZE"]      = "Taille police :"
L["SET_ELEMENTS"]       = "Elements affiches dans le texte :"
L["SET_SHOW_CLASS"]     = "Classe"
L["SET_SHOW_RATIO"]     = "Ratio K/D"
L["SET_SHOW_HATE"]      = "Niveau de haine"
L["SET_SOUND_ENABLE"]   = "Activer l'alerte sonore"
L["SET_SOUND_CHOOSE"]   = "Choisir un son :"
L["SET_SOUND_SELECT"]   = "Selectionner..."
L["SET_COOLDOWN"]       = "Delai entre alertes (sec) :"
L["SET_COL_LABEL"]      = "Cocher les colonnes a afficher :"
L["SET_COL_LEVEL"]      = "Niveau"
L["SET_COL_CLASS"]      = "Classe"
L["SET_COL_GUILD"]      = "Guilde"
L["SET_COL_DEATHS"]     = "Morts"
L["SET_COL_KILLS"]      = "Kills"
L["SET_COL_RATIO"]      = "Ratio"
L["SET_COL_HATE"]       = "Niveau haine"
L["SET_COL_LASTSEEN"]   = "Derniere vue"
L["SET_COL_DELETE"]     = "Bouton supprimer"
L["SET_NEARBY_LISTED"]  = "Afficher mes ennemis de la liste"
L["SET_MAX_ENTRIES"]    = "Nombre max d'entrees :"
L["SET_EXPIRE_TIME"]    = "Delai d'expiration (sec) :"
L["SET_SCALE"]          = "Echelle :"
L["SET_OPACITY"]        = "Opacite du fond :"
L["SET_OTHERS_SHOW"]    = "Afficher les ennemis hors liste"
L["SET_MINIMAP_SHOW"]   = "Afficher le bouton minimap"

-- Sons
L["SOUND_ALARM"]        = "Alarme Invasion"
L["SOUND_BELL"]         = "Cloche"

-- Messages (chat / UI)
L["MSG_ADDED_TARGET"]   = " ajoute depuis cible."
L["MSG_ALREADY_LISTED"] = " est deja dans la liste."
L["MSG_CANT_ADD"]       = "Impossible d'ajouter cette cible."
L["MSG_ADDED"]          = "Ajoute : "
L["MSG_ALREADY_SHORT"]  = "Deja dans la liste."
L["MSG_INVALID_NAME"]   = "Nom invalide ou vide."
L["MSG_HINT"]           = "Astuce : ciblez le joueur avant de cliquer\npour obtenir son niveau et sa classe."
L["MSG_EMPTY_LIST"]     = "Liste vide. Ciblez un joueur ennemi et cliquez Ajouter."
L["MSG_NO_ATTACKERS"]   = "Aucun attaquant recent.\nLes joueurs qui vous attaquent apparaitront ici."
L["MSG_COUNT"]          = " joueur(s) suivi(s)"
L["MSG_RESET_OK"]       = "Parametres reinitialises !"
L["MSG_ADDED_HIST"]     = " ajoute depuis l'historique."
L["MSG_ADDED_MANUAL"]   = " ajoute (niveau/classe inconnus)."
L["MSG_ALREADY_LIST2"]  = "Deja dans la liste."
L["MSG_INVALID"]        = "Nom invalide."

-- Niveaux de haine
L["HATE_1"]             = "Peon"
L["HATE_2"]             = "Grunt"
L["HATE_3"]             = "FDP"

-- Formats de temps
L["TIME_NEVER"]         = "Jamais"
L["TIME_NOW"]           = "Maintenant"
L["TIME_MIN"]           = "Il y a %d min"
L["TIME_HOUR"]          = "Il y a %d h"
L["TIME_DAY"]           = "Il y a %d j"
L["TIME_SEC"]           = "Il y a %d sec"

-- Historique des attaquants
L["HIST_KILL"]          = "Kill"
L["HIST_DEATH"]         = "Mort"
L["HIST_FIGHT"]         = " | Combat"
L["HIST_LEVEL"]         = " (Niv "

-- Texte d'alerte
L["ALERT_RATIO"]        = "Ratio: "
L["ALERT_LEVEL"]        = "Niv "

-- Classes (affichage)
L["CLASS_WARRIOR"]      = "Guerrier"
L["CLASS_PALADIN"]      = "Paladin"
L["CLASS_HUNTER"]       = "Chasseur"
L["CLASS_ROGUE"]        = "Voleur"
L["CLASS_PRIEST"]       = "Pretre"
L["CLASS_SHAMAN"]       = "Chaman"
L["CLASS_MAGE"]         = "Mage"
L["CLASS_WARLOCK"]      = "Demoniste"
L["CLASS_DRUID"]        = "Druide"
L["CLASS_DEATHKNIGHT"]  = "Chevalier de la Mort"

-- Aide slash
L["HELP_COMMANDS"]      = "Commandes :"
L["HELP_SHOW"]          = "  /nml              Afficher/masquer"
L["HELP_NEARBY"]        = "  /nml nearby       Toggle 'Ennemis a portee'"
L["HELP_HISTORY"]       = "  /nml history      Historique des attaquants (5 min)"
L["HELP_SETTINGS"]      = "  /nml settings     Ouvrir les parametres"
L["HELP_ADD"]           = "  /nml add          Ajouter la cible (niveau+classe+guilde)"
L["HELP_ADD_NAME"]      = "  /nml add <nom>    Ajouter par nom (niveau/classe inconnus)"
L["HELP_DEBUG"]         = "  /nml debug        Affiche les infos de debug"
L["HELP_TEST"]          = "  /nml testalert    Test des alertes visuelles + son"
L["HELP_HELP"]          = "  /nml help         Cette aide"
