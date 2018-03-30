function drawController(x, y, inputData)
	local buttonID   	   = {inputData.A, inputData.B, inputData.Down, inputData.Left, inputData.Right, inputData.Select, inputData.Start, inputData.Up}
	local pressedbuttonPos = {bX = {9, 8, 2, 1, 3, 5, 6, 2},
							  bY = {2, 2, 3, 2, 2, 3, 3, 1}}
	
	gui.drawRectangle(x, y, 10, 4, 0x8F0061FF, 0x8F0061FF)
	gui.drawLine(x+1, y+2, x+3, y+2, 0xFFF000000)
	gui.drawLine(x+2, y+1, x+2, y+3, 0xFFF000000)
	gui.drawLine(x+5, y+3, x+6, y+3, 0xFFF000000)
	gui.drawLine(x+8, y+2, x+9, y+2, 0xFFF000000)
	for i,v in ipairs(buttonID) do
		if v == true then gui.drawPixel(x + pressedbuttonPos.bX[i], y + pressedbuttonPos.bY[i], 0xFFFFC014) end
	end
end

while true do
	gameplayType   = memory.read_u8(0xDB95)
	GAMEPLAY_WORLD = 0x0B
	local currentInputs  = joypad.get()
	local linkSpritePos  = {x              = memory.read_u8(0xFF98),
							y              = memory.read_u8(0xC145),
							y_puddleOffset = memory.read_u8(0xC13B)}
	
	if linkSpritePos.x < 6   then linkSpritePos.x = 6 elseif linkSpritePos.x > 155 then linkSpritePos.x = 155 end
	if linkSpritePos.y > 131 then linkSpritePos.y = 0 end
	if gameplayType == GAMEPLAY_WORLD then
		drawController(linkSpritePos.x - 6, linkSpritePos.y + linkSpritePos.y_puddleOffset, currentInputs)
	else
		drawController(0, 139, currentInputs)
	end
	emu.frameadvance();
end