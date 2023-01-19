# https://learn.microsoft.com/en-us/windows/win32/api/userenv/
if(NOT WIN)
	dk_return()
endif()

dk_findLibrary(Userenv.lib)
