# https://learn.microsoft.com/en-us/windows/win32/api/imm/nf-imm-immgetcontext
if(NOT WIN)
	dk_undepend(imm32.lib)
	dk_return()
endif()

dk_findLibrary(imm32.lib)
