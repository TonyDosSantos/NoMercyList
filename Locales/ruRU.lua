-- =============================================================================
-- NoMercyList - Locale : Русский (ruRU)
-- =============================================================================

if GetLocale() ~= "ruRU" then return end

local L = NoMercyList_L

-- Заголовки окон
L["WIN_ADD"]            = "Добавить игрока"
L["WIN_HISTORY"]        = "История атакующих (5 мин)"
L["WIN_SETTINGS"]       = "Настройки"

-- Окно ближайших врагов
L["NEARBY_LISTED"]      = "Мои ближайшие враги"
L["NEARBY_OTHERS"]      = "Ближайшие враги"

-- Кнопки
L["BTN_ADD_PLAYER"]     = "Добавить игрока"
L["BTN_HISTORY"]        = "История атак"
L["BTN_ADD"]            = "Добавить"
L["BTN_CANCEL"]         = "Отмена"
L["BTN_REFRESH"]        = "Обновить"
L["BTN_CLOSE"]          = "Закрыть"
L["BTN_ADD_TO_LIST"]    = "Добавить в список"
L["BTN_ALREADY_ADDED"]  = "Уже добавлен"
L["BTN_ALREADY_LISTED"] = "Уже в списке"
L["BTN_TEST_VISUAL"]    = "Тест визуального оповещения"
L["BTN_TEST_TEXT"]      = "Тест текстового оповещения"
L["BTN_RESET"]          = "Сбросить"

-- Заголовки столбцов
L["COL_NAME"]           = "Имя игрока"
L["COL_LEVEL"]          = "Уровень"
L["COL_CLASS"]          = "Класс"
L["COL_GUILD"]          = "Гильдия"
L["COL_DEATHS"]         = "Смерти"
L["COL_KILLS"]          = "Убийства"
L["COL_RATIO"]          = "Соотношение"
L["COL_HATE"]           = "Ненависть"
L["COL_LASTSEEN"]       = "Последний раз"

-- Подсказки
L["TIP_ADD_PLAYER"]     = "Добавить игрока"
L["TIP_ADD_ENEMY"]      = "Активная цель-враг:"
L["TIP_ADD_ENEMY2"]     = "  Добавляет цель с уровнем и классом"
L["TIP_ADD_NOTARGET"]   = "Без цели:"
L["TIP_ADD_NOTARGET2"]  = "  Открывает ручной ввод"
L["TIP_HISTORY"]        = "История атакующих"
L["TIP_HISTORY2"]       = "Показывает игроков-врагов, которые"
L["TIP_HISTORY3"]       = "атаковали вас за последние 5 минут"
L["TIP_SETTINGS"]       = "Настройки"
L["TIP_SETTINGS2"]      = "Настроить визуальные оповещения"
L["TIP_NEARBY"]         = "Ближайшие враги"
L["TIP_NEARBY2"]        = "Показать/скрыть список ближайших врагов"
L["TIP_MINIMAP2"]       = "Клик: показать/скрыть"
L["TIP_MINIMAP3"]       = "Перетащить: свободно разместить"

-- Настройки — заголовки разделов
L["SET_SEC_BORDER"]     = "Визуальное оповещение (рамка)"
L["SET_SEC_TEXT"]       = "Текст оповещения"
L["SET_SEC_SOUND"]      = "Звук оповещения"
L["SET_SEC_COOLDOWN"]   = "Частота оповещений"
L["SET_SEC_COLUMNS"]    = "Отображаемые столбцы"
L["SET_SEC_NEARBY"]     = "Мои ближайшие враги"
L["SET_SEC_OTHERS"]     = "Ближайшие враги (не в списке)"
L["SET_SEC_MINIMAP"]    = "Кнопка миникарты"

-- Настройки — метки
L["SET_BORDER_ENABLE"]  = "Включить рамочное оповещение"
L["SET_COLOR"]          = "Цвет:"
L["SET_CLICK_CHOOSE"]   = "Нажмите для выбора"
L["SET_BORDER_DUR"]     = "Длительность мигания рамки (сек):"
L["SET_BORDER_SPEED"]   = "Скорость мигания рамки:"
L["SET_SPEED_FAST"]     = "Быстро"
L["SET_SPEED_SLOW"]     = "Медленно"
L["SET_TEXT_ENABLE"]    = "Включить текстовое оповещение"
L["SET_TEXT_COLOR"]     = "Цвет текста:"
L["SET_TEXT_DUR"]       = "Длительность отображения текста (сек):"
L["SET_POSITION"]       = "Положение:"
L["SET_POS_TOP"]        = "Вверху"
L["SET_POS_CENTER"]     = "По центру"
L["SET_POS_BOTTOM"]     = "Внизу"
L["SET_FONT_SIZE"]      = "Размер шрифта:"
L["SET_ELEMENTS"]       = "Элементы в тексте оповещения:"
L["SET_SHOW_CLASS"]     = "Класс"
L["SET_SHOW_RATIO"]     = "Соотношение У/С"
L["SET_SHOW_HATE"]      = "Уровень ненависти"
L["SET_SOUND_ENABLE"]   = "Включить звуковое оповещение"
L["SET_SOUND_CHOOSE"]   = "Выбрать звук:"
L["SET_SOUND_SELECT"]   = "Выбрать..."
L["SET_COOLDOWN"]       = "Задержка между оповещениями (сек):"
L["SET_COL_LABEL"]      = "Выбрать отображаемые столбцы:"
L["SET_COL_LEVEL"]      = "Уровень"
L["SET_COL_CLASS"]      = "Класс"
L["SET_COL_GUILD"]      = "Гильдия"
L["SET_COL_DEATHS"]     = "Смерти"
L["SET_COL_KILLS"]      = "Убийства"
L["SET_COL_RATIO"]      = "Соотношение"
L["SET_COL_HATE"]       = "Уровень ненависти"
L["SET_COL_LASTSEEN"]   = "Последний раз"
L["SET_COL_DELETE"]     = "Кнопка удаления"
L["SET_NEARBY_LISTED"]  = "Показать моих врагов из списка"
L["SET_MAX_ENTRIES"]    = "Макс. записей:"
L["SET_EXPIRE_TIME"]    = "Время истечения (сек):"
L["SET_SCALE"]          = "Масштаб:"
L["SET_OPACITY"]        = "Прозрачность фона:"
L["SET_OTHERS_SHOW"]    = "Показать врагов не из списка"
L["SET_MINIMAP_SHOW"]   = "Показать кнопку миникарты"

-- Звуки
L["SOUND_ALARM"]        = "Сигнал вторжения"
L["SOUND_BELL"]         = "Колокол"

-- Сообщения
L["MSG_ADDED_TARGET"]   = " добавлен из цели."
L["MSG_ALREADY_LISTED"] = " уже в списке."
L["MSG_CANT_ADD"]       = "Невозможно добавить эту цель."
L["MSG_ADDED"]          = "Добавлен: "
L["MSG_ALREADY_SHORT"]  = "Уже в списке."
L["MSG_INVALID_NAME"]   = "Недопустимое или пустое имя."
L["MSG_HINT"]           = "Совет: выберите цель перед нажатием,\nчтобы получить уровень и класс."
L["MSG_EMPTY_LIST"]     = "Список пуст. Выберите врага и нажмите Добавить."
L["MSG_NO_ATTACKERS"]   = "Нет недавних атакующих.\nИгроки, атакующие вас, появятся здесь."
L["MSG_COUNT"]          = " отслеживаемых игрок(ов)"
L["MSG_RESET_OK"]       = "Настройки сброшены!"
L["MSG_ADDED_HIST"]     = " добавлен из истории."
L["MSG_ADDED_MANUAL"]   = " добавлен (уровень/класс неизвестны)."
L["MSG_ALREADY_LIST2"]  = "Уже в списке."
L["MSG_INVALID"]        = "Недопустимое имя."

-- Уровни ненависти
L["HATE_1"]             = "Пеон"
L["HATE_2"]             = "Рядовой"
L["HATE_3"]             = "Заклятый враг"

-- Форматы времени
L["TIME_NEVER"]         = "Никогда"
L["TIME_NOW"]           = "Сейчас"
L["TIME_MIN"]           = "%d мин назад"
L["TIME_HOUR"]          = "%d ч назад"
L["TIME_DAY"]           = "%d дн назад"
L["TIME_SEC"]           = "%d сек назад"

-- История атакующих
L["HIST_KILL"]          = "Убийство"
L["HIST_DEATH"]         = "Смерть"
L["HIST_FIGHT"]         = " | Бой"
L["HIST_LEVEL"]         = " (Ур "

-- Текст оповещения
L["ALERT_RATIO"]        = "Соотношение: "
L["ALERT_LEVEL"]        = "Ур "

-- Классы
L["CLASS_WARRIOR"]      = "Воин"
L["CLASS_PALADIN"]      = "Паладин"
L["CLASS_HUNTER"]       = "Охотник"
L["CLASS_ROGUE"]        = "Разбойник"
L["CLASS_PRIEST"]       = "Жрец"
L["CLASS_SHAMAN"]       = "Шаман"
L["CLASS_MAGE"]         = "Маг"
L["CLASS_WARLOCK"]      = "Чернокнижник"
L["CLASS_DRUID"]        = "Друид"
L["CLASS_DEATHKNIGHT"]  = "Рыцарь смерти"

-- Помощь slash
L["HELP_COMMANDS"]      = "Команды:"
L["HELP_SHOW"]          = "  /nml              Показать/скрыть"
L["HELP_NEARBY"]        = "  /nml nearby       Переключить 'Ближайшие враги'"
L["HELP_HISTORY"]       = "  /nml history      История атак (5 мин)"
L["HELP_SETTINGS"]      = "  /nml settings     Открыть настройки"
L["HELP_ADD"]           = "  /nml add          Добавить текущую цель"
L["HELP_ADD_NAME"]      = "  /nml add <имя>    Добавить по имени"
L["HELP_DEBUG"]         = "  /nml debug        Показать отладочную информацию"
L["HELP_TEST"]          = "  /nml testalert    Тест оповещений + звук"
L["HELP_HELP"]          = "  /nml help         Эта справка"
