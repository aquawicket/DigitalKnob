#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

############ uwebsockets ############
# https://github.com/uNetworking/uWebSockets
dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(libuv)
dk_depend(openssl)
dk_depend(zlib)

### IMPORT ###
dk_import() #PATCH

### LINK ###
dk_include				(${uwebsockets})
dk_include				(${uwebsockets}/${Target_Tuple})
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

