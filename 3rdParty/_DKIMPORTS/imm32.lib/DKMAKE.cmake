# https://learn.microsoft.com/en-us/windows/win32/api/imm/nf-imm-immgetcontext
if(NOT WIN)
	return()
endif()

dk_findLibrary(imm32.lib)
