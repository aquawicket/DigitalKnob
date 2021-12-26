# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application

if(NOT CMAKE_HOST_WIN32)
	return()
endif()

WIN_LIB(Ws2_32.lib)
