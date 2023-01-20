# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application

if(NOT WIN)
	dk_undepend(ws2_32.lib)
	dk_return()
endif()

dk_findLibrary(ws2_32.lib)
