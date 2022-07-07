# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application
if(NOT WIN_HOST)
	return()
endif()


WIN_dk_findLibrary(ws2_32.lib)
