# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers
if(NOT WIN_HOST)
	return()
endif()


#DKIMPORT(shlwapi.lib)
WIN_DKLIB(shlwapi.lib)
