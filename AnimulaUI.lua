--!strict
-- =============================================================================
--  AnimulaUI.lua — Wrapper backward-compat
--  Lokasi: Script/MainUI/AnimulaUI.lua  (nama baru, biru Animula)
--  Alias lama: AnimulaUI(legacy).lua tetap ada untuk kompat.
--  File ini hanya re-export LoaderUI. Logic asli ada di ComponentsUI/.
--  Jangan edit file ini — edit di ComponentsUI/*.
-- =============================================================================
return require(script.Parent.LoaderUI)
