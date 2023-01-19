# https://learn.microsoft.com/en-us/windows/win32/api/setupapi

if(NOT WIN)
	dk_return()
endif()

dk_findLibrary(Setupapi.lib)
