# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application
if(NOT WIN_HOST)
	return()
endif()


#FIND_LIBRARY(Ws2_32.lib_path Ws2_32.lib)
#if(NOT Ws2_32.lib_path)
#	dk_warn("Could not locate Ws2_32.lib")
#endif()
#dk_info("Ws2_32.lib_path = ${Ws2_32.lib_path}")

WIN_dk_lib(Ws2_32.lib)
