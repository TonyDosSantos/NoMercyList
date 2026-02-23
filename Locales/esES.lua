-- =============================================================================
-- NoMercyList - Locale : Español (esES / esMX)
-- =============================================================================

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L = NoMercyList_L

-- Títulos de ventanas
L["WIN_ADD"]            = "Añadir jugador"
L["WIN_HISTORY"]        = "Historial de atacantes (5 min)"
L["WIN_SETTINGS"]       = "Ajustes"

-- Marco enemigos cercanos
L["NEARBY_LISTED"]      = "Mis enemigos cercanos"
L["NEARBY_OTHERS"]      = "Enemigos cercanos"

-- Botones
L["BTN_ADD_PLAYER"]     = "Añadir jugador"
L["BTN_HISTORY"]        = "Historial atacantes"
L["BTN_ADD"]            = "Añadir"
L["BTN_CANCEL"]         = "Cancelar"
L["BTN_REFRESH"]        = "Actualizar"
L["BTN_CLOSE"]          = "Cerrar"
L["BTN_ADD_TO_LIST"]    = "Añadir a la lista"
L["BTN_ALREADY_ADDED"]  = "Ya añadido"
L["BTN_ALREADY_LISTED"] = "Ya en la lista"
L["BTN_TEST_VISUAL"]    = "Probar alerta visual"
L["BTN_TEST_TEXT"]      = "Probar alerta de texto"
L["BTN_RESET"]          = "Restablecer"

-- Encabezados de columnas
L["COL_NAME"]           = "Nombre del jugador"
L["COL_LEVEL"]          = "Nivel"
L["COL_CLASS"]          = "Clase"
L["COL_GUILD"]          = "Hermandad"
L["COL_DEATHS"]         = "Muertes"
L["COL_KILLS"]          = "Kills"
L["COL_RATIO"]          = "Ratio"
L["COL_HATE"]           = "Odio"
L["COL_LASTSEEN"]       = "Última vez visto"

-- Tooltips
L["TIP_ADD_PLAYER"]     = "Añadir jugador"
L["TIP_ADD_ENEMY"]      = "Objetivo enemigo activo:"
L["TIP_ADD_ENEMY2"]     = "  Añade el objetivo con nivel y clase"
L["TIP_ADD_NOTARGET"]   = "Sin objetivo:"
L["TIP_ADD_NOTARGET2"]  = "  Abre la entrada manual"
L["TIP_HISTORY"]        = "Historial de atacantes"
L["TIP_HISTORY2"]       = "Muestra los jugadores enemigos que te han"
L["TIP_HISTORY3"]       = "atacado en los últimos 5 minutos"
L["TIP_SETTINGS"]       = "Ajustes"
L["TIP_SETTINGS2"]      = "Configurar alertas visuales"
L["TIP_NEARBY"]         = "Enemigos cercanos"
L["TIP_NEARBY2"]        = "Mostrar/ocultar la lista de enemigos cercanos"
L["TIP_MINIMAP2"]       = "Clic: mostrar/ocultar"
L["TIP_MINIMAP3"]       = "Arrastrar: reposicionar libremente"

-- Ajustes — títulos de secciones
L["SET_SEC_BORDER"]     = "Alerta visual (borde)"
L["SET_SEC_TEXT"]       = "Texto de alerta"
L["SET_SEC_SOUND"]      = "Sonido de alerta"
L["SET_SEC_COOLDOWN"]   = "Frecuencia de alerta"
L["SET_SEC_COLUMNS"]    = "Columnas mostradas"
L["SET_SEC_NEARBY"]     = "Mis enemigos cercanos"
L["SET_SEC_OTHERS"]     = "Enemigos cercanos (no listados)"
L["SET_SEC_MINIMAP"]    = "Botón del minimapa"

-- Ajustes — etiquetas
L["SET_BORDER_ENABLE"]  = "Activar alerta de borde"
L["SET_COLOR"]          = "Color:"
L["SET_CLICK_CHOOSE"]   = "Clic para elegir"
L["SET_BORDER_DUR"]     = "Duración del parpadeo del borde (seg):"
L["SET_BORDER_SPEED"]   = "Velocidad de parpadeo del borde:"
L["SET_SPEED_FAST"]     = "Rápido"
L["SET_SPEED_SLOW"]     = "Lento"
L["SET_TEXT_ENABLE"]    = "Activar alerta de texto"
L["SET_TEXT_COLOR"]     = "Color del texto:"
L["SET_TEXT_DUR"]       = "Duración de visualización del texto (seg):"
L["SET_POSITION"]       = "Posición:"
L["SET_POS_TOP"]        = "Arriba"
L["SET_POS_CENTER"]     = "Centro"
L["SET_POS_BOTTOM"]     = "Abajo"
L["SET_FONT_SIZE"]      = "Tamaño de fuente:"
L["SET_ELEMENTS"]       = "Elementos mostrados en el texto:"
L["SET_SHOW_CLASS"]     = "Clase"
L["SET_SHOW_RATIO"]     = "Ratio K/M"
L["SET_SHOW_HATE"]      = "Nivel de odio"
L["SET_SOUND_ENABLE"]   = "Activar alerta sonora"
L["SET_SOUND_CHOOSE"]   = "Elegir sonido:"
L["SET_SOUND_SELECT"]   = "Seleccionar..."
L["SET_COOLDOWN"]       = "Retraso entre alertas (seg):"
L["SET_COL_LABEL"]      = "Marcar columnas a mostrar:"
L["SET_COL_LEVEL"]      = "Nivel"
L["SET_COL_CLASS"]      = "Clase"
L["SET_COL_GUILD"]      = "Hermandad"
L["SET_COL_DEATHS"]     = "Muertes"
L["SET_COL_KILLS"]      = "Kills"
L["SET_COL_RATIO"]      = "Ratio"
L["SET_COL_HATE"]       = "Nivel odio"
L["SET_COL_LASTSEEN"]   = "Última vez visto"
L["SET_COL_DELETE"]     = "Botón eliminar"
L["SET_NEARBY_LISTED"]  = "Mostrar mis enemigos de la lista"
L["SET_MAX_ENTRIES"]    = "Máx. entradas:"
L["SET_EXPIRE_TIME"]    = "Tiempo de expiración (seg):"
L["SET_SCALE"]          = "Escala:"
L["SET_OPACITY"]        = "Opacidad del fondo:"
L["SET_OTHERS_SHOW"]    = "Mostrar enemigos no listados"
L["SET_MINIMAP_SHOW"]   = "Mostrar botón del minimapa"

-- Sonidos
L["SOUND_ALARM"]        = "Alarma de invasión"
L["SOUND_BELL"]         = "Campana"

-- Mensajes
L["MSG_ADDED_TARGET"]   = " añadido desde objetivo."
L["MSG_ALREADY_LISTED"] = " ya está en la lista."
L["MSG_CANT_ADD"]       = "No se puede añadir este objetivo."
L["MSG_ADDED"]          = "Añadido: "
L["MSG_ALREADY_SHORT"]  = "Ya en la lista."
L["MSG_INVALID_NAME"]   = "Nombre inválido o vacío."
L["MSG_HINT"]           = "Consejo: selecciona al jugador antes de hacer clic\npara obtener su nivel y clase."
L["MSG_EMPTY_LIST"]     = "Lista vacía. Selecciona un enemigo y haz clic en Añadir."
L["MSG_NO_ATTACKERS"]   = "Sin atacantes recientes.\nLos jugadores que te ataquen aparecerán aquí."
L["MSG_COUNT"]          = " jugador(es) rastreado(s)"
L["MSG_RESET_OK"]       = "¡Ajustes restablecidos!"
L["MSG_ADDED_HIST"]     = " añadido desde historial."
L["MSG_ADDED_MANUAL"]   = " añadido (nivel/clase desconocidos)."
L["MSG_ALREADY_LIST2"]  = "Ya en la lista."
L["MSG_INVALID"]        = "Nombre inválido."

-- Niveles de odio
L["HATE_1"]             = "Peon"
L["HATE_2"]             = "Grunt"
L["HATE_3"]             = "Nemesis"

-- Formatos de tiempo
L["TIME_NEVER"]         = "Nunca"
L["TIME_NOW"]           = "Ahora"
L["TIME_MIN"]           = "Hace %d min"
L["TIME_HOUR"]          = "Hace %d h"
L["TIME_DAY"]           = "Hace %d días"
L["TIME_SEC"]           = "Hace %d seg"

-- Historial
L["HIST_KILL"]          = "Kill"
L["HIST_DEATH"]         = "Muerte"
L["HIST_FIGHT"]         = " | Combate"
L["HIST_LEVEL"]         = " (Niv "

-- Texto de alerta
L["ALERT_RATIO"]        = "Ratio: "
L["ALERT_LEVEL"]        = "Niv "

-- Clases
L["CLASS_WARRIOR"]      = "Guerrero"
L["CLASS_PALADIN"]      = "Paladín"
L["CLASS_HUNTER"]       = "Cazador"
L["CLASS_ROGUE"]        = "Pícaro"
L["CLASS_PRIEST"]       = "Sacerdote"
L["CLASS_SHAMAN"]       = "Chamán"
L["CLASS_MAGE"]         = "Mago"
L["CLASS_WARLOCK"]      = "Brujo"
L["CLASS_DRUID"]        = "Druida"
L["CLASS_DEATHKNIGHT"]  = "Caballero de la Muerte"

-- Ayuda slash
L["HELP_COMMANDS"]      = "Comandos:"
L["HELP_SHOW"]          = "  /nml              Mostrar/ocultar"
L["HELP_NEARBY"]        = "  /nml nearby       Alternar 'Enemigos cercanos'"
L["HELP_HISTORY"]       = "  /nml history      Historial de atacantes (5 min)"
L["HELP_SETTINGS"]      = "  /nml settings     Abrir ajustes"
L["HELP_ADD"]           = "  /nml add          Añadir objetivo actual"
L["HELP_ADD_NAME"]      = "  /nml add <nombre> Añadir por nombre"
L["HELP_DEBUG"]         = "  /nml debug        Mostrar info de depuración"
L["HELP_TEST"]          = "  /nml testalert    Probar alertas + sonido"
L["HELP_HELP"]          = "  /nml help         Esta ayuda"
