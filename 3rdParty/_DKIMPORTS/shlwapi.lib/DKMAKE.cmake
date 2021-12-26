if(NOT WIN_HOST)
	return()
endif()

# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers

WIN_LIB(shlwapi.lib)
