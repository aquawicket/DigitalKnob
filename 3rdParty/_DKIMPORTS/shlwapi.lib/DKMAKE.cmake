# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers
if(NOT WIN)
	return()
endif()

dk_findLibrary(shlwapi.lib)
