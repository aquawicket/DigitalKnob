# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application
if(NOT WIN_HOST)
	return()
endif()


FIND_LIBRARY(libWs2_32 Ws2_32.lib)
if(NOT libWs2_32)
	dk_error("Could not locate Ws2_32.lib")
endif()
dk_debug("libWs2_32 = ${libWs2_32}")

WIN_dk_lib(Ws2_32.lib)
