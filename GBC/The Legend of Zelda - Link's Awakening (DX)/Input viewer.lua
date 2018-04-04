print("LADX input viewer\nChange the layout by clicking \"Edit\" in the console window and changing the layout parameter (first parameter, set to \"2\" by default) of the drawController() call in the main loop.")
buttonsGFX = "./resources/gfx/buttons.png"

function drawController(layout, x, y, inputData)
	local buttonID         = {inputData.Up, inputData.Down, inputData.Left, inputData.Right, inputData.B, inputData.A, inputData.Select, inputData.Start}
	                                         --u , d , l , r , B , A , s , S
	local pressedbuttonPos = {layout1 = {bX = {12, 12, 11, 13, 18, 19, 15, 16},
                                         bY = {25, 27, 26, 26, 26, 26, 27, 27}},
	                          layout2 = {bX = {12, 12, 0 , 24, 8 , 16, 8 , 16},
	                                     bY = {0 , 24, 12, 12, 8 , 8 , 16, 16}}}
	
	if layout == 1 then
		gui.drawRectangle(x+10, y+24, 10, 4, 0x8F0061FF, 0x8F0061FF)
		gui.drawLine(x+11, y+26, x+13, y+26, 0xFFF000000)
		gui.drawLine(x+12, y+25, x+12, y+27, 0xFFF000000)
		gui.drawLine(x+15, y+27, x+16, y+27, 0xFFF000000)
		gui.drawLine(x+18, y+26, x+19, y+26, 0xFFF000000)
	end
	for i,v in ipairs(buttonID) do
		if v     and layout == 1 then gui.drawPixel(x + pressedbuttonPos.layout1.bX[i], y + pressedbuttonPos.layout1.bY[i], 0xFFFFC014)
		elseif v and layout == 2 then gui.drawImageRegion(buttonsGFX, 8 * (i-1), 0, 8, 8, x + pressedbuttonPos.layout2.bX[i], y + pressedbuttonPos.layout2.bY[i])
		elseif v and layout == 3 then gui.drawImageRegion(buttonsGFX, 8 * (i-1), 0, 8, 8, 8 * (i-1), 0) end
	end
end

while true do
	local currentInputs  = joypad.get()
	local linkDrawPos    = {x              = memory.read_u8(0xFF98),
	                        y              = memory.read_u8(0xC145),
	                        y_puddleOffset = memory.read_u8(0xC13B)}
	
	drawController(2, linkDrawPos.x - 16, linkDrawPos.y + linkDrawPos.y_puddleOffset - 24, currentInputs)
	emu.frameadvance();
end