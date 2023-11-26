# https://learn.microsoft.com/en-us/windows/win32/psapi/psapi-functions

if(NOT WIN)
	dk_undepend(psapi.lib)
	dk_return()
endif()

dk_findLibrary(Psapi.lib)
