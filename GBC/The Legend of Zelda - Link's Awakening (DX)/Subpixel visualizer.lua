print("Sub-pixel Visualizer\nLeft click = change sub-pixel (green dot)\nMiddle click = move plane around")

plane = {128, 112, 8}

while true do
	x     = 0x011A
	y     = 0x011B
	pos   = {memory.read_u8(x, "WRAM")/16, memory.read_u8(y, "WRAM")/16}
	mouse = input.getmouse()

	gui.pixelText(plane[1] + 1, plane[2] - plane[3], "(" .. pos[1] .. "," .. pos[2] .. ")")
	--gui.pixelText(mouse.X, mouse.Y, "(" .. mouse.X .. "," .. mouse.Y .. ")") --debug
	gui.drawBox(plane[1], plane[2], plane[1] + 31, plane[2] + 31, 0x7F808080, 0x7F808080)
	for i = 0, 31, 2 do
		gui.drawLine(i + plane[1], plane[2], i + plane[1], plane[2] + 31, 0xFF000000)
		gui.drawLine(plane[1], i + plane[2], plane[1] + 31, i + plane[2], 0xFF000000)
	end
	gui.drawBox(pos[1] * 2 + plane[1], pos[2] * 2 + plane[2], pos[1] * 2 + (plane[1] + 1), pos[2] * 2 + (plane[2] + 1), 0xFF247F29)
	if mouse.X >= plane[1] and mouse.X < plane[1] + 32 and mouse.Y >= plane[2] and mouse.Y < plane[2] + 32 then
		if mouse.Left == true and mouse.Middle == false then
			memory.write_u8(x, math.floor((mouse.X - plane[1])/2) * 16, "WRAM")
			memory.write_u8(y, math.floor((mouse.Y - plane[2])/2) * 16, "WRAM")
		elseif mouse.Left == false and mouse.Middle == true then
			plane[1] = mouse.X - 15
			plane[2] = mouse.Y - 15
		end
	end
	if plane[1] < 0 then plane[1] = 0   elseif plane[1] > 128 then plane[1] = 128 end
	if plane[2] < 0 then plane[2] = 0   elseif plane[2] > 112 then plane[2] = 112 end
	if plane[2] < 9 then plane[3] = -33 elseif plane[2] > 103 then plane[3] = 8   end
	
	emu.frameadvance()
end