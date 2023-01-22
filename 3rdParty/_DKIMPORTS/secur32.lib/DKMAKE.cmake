# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers

if(NOT WIN)
	dk_undepend(secur32.lib)
	dk_return()
endif()

dk_findLibrary(Secur32.Lib)
