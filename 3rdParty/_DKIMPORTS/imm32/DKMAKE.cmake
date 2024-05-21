# https://learn.microsoft.com/en-us/windows/win32/api/imm/nf-imm-immgetcontext
if(NOT WIN)
	dk_undepend(imm32)
	dk_return()
endif()

dk_findLibrary(imm32.lib)


# MSYS2 (-limm32)
if(MSYSTEM)
	dk_set(IMM32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-limm32")
endif()