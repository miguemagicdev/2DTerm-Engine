--[[
ooooo                      .       .   ooooo     ooo  o8o  
`888'                    .o8     .o8   `888'     `8'  `"'  
 888          .ooooo.  .o888oo .o888oo  888       8  oooo  
 888         d88' `88b   888     888    888       8  `888  
 888         888ooo888   888     888    888       8   888  
 888       o 888    .o   888 .   888 .  `88.    .8'   888  
o888ooooood8 `Y8bod8P'   "888"   "888"    `YbodP'    o888o
                   El modulo LettUI
]]

-- Modulos

local SimpleFuncs = require("SimpleFunctions")
local SR = require("ScreenRendering")

-- Variables

local LettUI = {
  Registered = {},
  Config = {
    UIColor = {},
    Style = "8bit"
  }
}

local DefaultPos = {0, 0}
local DefaultEase = "Linear"
local DefaultSize = {3, 3}
local DefaultShape = "█"
local DefaultColor = "white"
local DefaultUntitledUI = "Untitled UI"
local DefaultType = "screen"

-- Funciones

function LettUI:new(UIName, Pos, Size, OnOpen, OnClose, PermEvent, Shape, OnClick, Type)
  local UI = {
      name = UIName or DefaultUntitledUI,
      type = Type or DefaultType,
      pos = Pos or DefaultPos,
      size = Size or DefaultSize,
      openEvent = OnOpen,
      closeEvent = OnClose,
      permEvent = PermEvent,
      shape = Shape or DefaultShape,
      clickEvent = OnClick,
      state = "hidden",
      insideTxts = {}
  }
  table.insert(LettUI.Registered, UI)
end

function LettUI:CheckUI(UI)
  if UI then
    if UI.name ~= nil and UI.pos ~= nil and UI.size ~= nil and UI.shape ~= nil and UI.state ~= nil then
      return true
    else
      return false
    end
  else
    return false
  end
end

function LettUI:Actualizar()
  if LettUI.Registered[1] then
    for i, UI in pairs(LettUI.Registered) do
      if UI.state == "displaying" then
        for i = 1, UI.size[2] do
          SR.ScreenContent.ui = SimpleFuncs:WriteFrom(SR.ScreenContent.ui, UI.pos[1] + UI.size[1], (UI.pos[2] + i), ("\b \b"):rep(UI.size[1]) .. UI.shape:rep(UI.size[1]))
        end
      else
        for i = 1, UI.size[2] do
          SR.ScreenContent.ui = SimpleFuncs:WriteFrom(SR.ScreenContent.ui, UI.pos[1] + UI.size[1], (UI.pos[2] + i), ("\b \b"):rep(UI.size[1]) .. (" "):rep(UI.size[1]))
        end
      end
   end
    SR:actualizar()
  else
    error("Error al actualizar las UIS: No hay ninguna UI registrada.")
  end
end

function LettUI:SetUIState(UI, state)
  if UI then
    if LettUI:CheckUI(UI) then
      if (state == "hidden" or "displaying") then
        UI.state = state
        LettUI:Actualizar(UI)
      else
        error("Error al poner estado de UI: Estado invalido, pon 'hidden' o 'displaying'.")
      end
    else
      error("Error al poner estado de UI: el UI puesto no es valido.")
    end
  else
    error("Error al poner estado de UI: No pusiste un UI.")
  end
end

return LettUI