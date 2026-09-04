--!strict
-- Notification.lua - facade buat Toast/Dialog/Popup
-- sekarang dipecah jadi 3 file biar rapih: Toast/Toast.lua, Dialog/Dialog.lua, Popup/Popup.lua
-- tapi biar kompat, file ini tetep ada dan nge-require mereka

local Toast  = require(script:FindFirstChild("Toast"):FindFirstChild("Toast"))
local Dialog = require(script:FindFirstChild("Dialog"):FindFirstChild("Dialog"))
local Popup  = require(script:FindFirstChild("Popup"):FindFirstChild("Popup"))

local Notification = {}

function Notification.Notify(cfg: any) return Toast.Notify(cfg) end
Notification.MakeNotification = Notification.Notify

function Notification.Dialog(cfg: any, parent: Frame?) return Dialog.Show(cfg, parent) end

function Notification.Popup(cfg: any) return Popup.Show(cfg) end

return Notification
