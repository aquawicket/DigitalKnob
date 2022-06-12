### DKVARIABLES ##################################################################
if(CMAKE_HOST_WIN32)
	set(WIN_HOST 	TRUE 	CACHE INTERNAL "")
endif()
if(CMAKE_HOST_APPLE)
	set(UNIX_HOST 	TRUE 	CACHE INTERNAL "")
	set(MAC_HOST 	TRUE 	CACHE INTERNAL "")
endif()
if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(UNIX_HOST 	TRUE 	CACHE INTERNAL "")
	set(LINUX_HOST 	TRUE 	CACHE INTERNAL "")
endif()

include(dk_getDigitalknobPath.cmake)
dk_file_getDigitalknobPath(DIGITALKNOB)

include(${DIGITALKNOB}/DK/DKCMake/DKCall.cmake)
DKLoad(DKDEBUGFUNC)
