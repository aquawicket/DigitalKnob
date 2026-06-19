#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################

############ uwebsockets ############
# https://github.com/uNetworking/uWebSockets
# https://github.com/uNetworking/uWebSockets/archive/refs/tags/v0.14.8.zip
# https://github.com/uNetworking/uWebSockets/archive/refs/tags/v20.36.0.zip

dk_depend(libuv)
dk_depend(openssl)
dk_depend(zlib)

dk_import() #PATCH

dk_include				(${uwebsockets})
dk_include				(${uwebsockets_Tuple_Dir})
if(Windows AND MSVC)
	dk_libDebug			(${uwebsockets_Debug_Dir}/uWS.lib)
	dk_libRelease		(${uwebsockets_Release_Dir}/uWS.lib)
else()
	dk_libDebug			(${uwebsockets_Debug_Dir}/libuWS.a)
	dk_libRelease		(${uwebsockets_Release_Dir}/libuWS.a)
endif()

### GENERATE ###
dk_configure(${uwebsockets}
	${libuv_CMAKE}
	${openssl_CMAKE}
	${zlib_CMAKE})

### COMPILE ###
dk_build(${uwebsockets} uWS)

###### WITHOUT CMAKE #########
#DEBUG_dk_configure			(${uwebsockets})
#DEBUG_dk_build				(${uwebsockets})
##############################

