# https://learn.microsoft.com/en-us/windows/win32/api/setupapi
if(NOT WIN)
	return()
endif()

dk_findLibrary(Setupapi.lib)
