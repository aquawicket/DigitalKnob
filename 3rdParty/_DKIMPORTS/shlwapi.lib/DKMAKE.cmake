# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers

if(NOT WIN_HOST)
	return()
endif()


WIN_dk_lib(shlwapi.lib)
#dk_import(shlwapi.lib)
