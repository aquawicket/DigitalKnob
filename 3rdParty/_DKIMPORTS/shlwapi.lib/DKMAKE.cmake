# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers

if(NOT WIN_HOST)
	return()
endif()

dk_findLibrary(shlwapi.lib)
