

local ScreenRendering = {
  ScreenContent = {
    complete = [[]],
    workspace = [[]],
    ui = [[]]
  }
}

function ScreenRendering:actualizar()
  io.write("\027[2J\027[0;0H".. ScreenRendering.ScreenContent.ui)
  io.flush()
end

return ScreenRendering