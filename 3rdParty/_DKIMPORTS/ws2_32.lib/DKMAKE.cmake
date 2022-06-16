# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application
if(NOT WIN_HOST)
	return()
endif()


#FIND_LIBRARY(Ws2_32.lib_path Ws2_32.lib)
#if(NOT Ws2_32.lib_path)
#	DKWARN("Could not locate Ws2_32.lib")
#endif()
#DKINFO("Ws2_32.lib_path = ${Ws2_32.lib_path}")

WIN_DKLIB(Ws2_32.lib)
