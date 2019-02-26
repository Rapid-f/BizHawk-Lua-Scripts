while true do
	textState = memory.read_u8(0xC19F)
	if textState == 0x09 then joypad.set({B=1})
	elseif textState == 0x89 then joypad.set({B=1})
	elseif textState == 0x0C then joypad.set({A=1})
	elseif textState == 0x8C then joypad.set({B=1})
	end
	emu.frameadvance();
end