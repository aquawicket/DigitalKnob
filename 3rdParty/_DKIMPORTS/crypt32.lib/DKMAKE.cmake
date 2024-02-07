# https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/
if(NOT WIN)
	dk_undepend(crypt32.lib)
	dk_return()
endif()

dk_findLibrary(crypt32.lib)