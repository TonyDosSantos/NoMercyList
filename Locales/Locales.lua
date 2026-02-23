-- =============================================================================
-- NoMercyList - Système de localisation
-- Les fichiers de locale sont chargés en ordre par le .toc
-- frFR.lua est TOUJOURS chargé en premier comme fallback universel
-- Les autres locales écrasent les clés correspondantes
-- =============================================================================

NoMercyList_L = setmetatable({}, {
    -- Fallback : si une clé est absente d'une locale, retourne la clé elle-même
    __index = function(t, k) return k end
})
