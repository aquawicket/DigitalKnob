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
dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v0.14.8.zip PATCH)
#dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v20.36.0.zip)

### LINK ###
dk_include				(${UWEBSOCKETS})
dk_include				(${UWEBSOCKETS}/${Target_Tuple})
if(MSVC)
	Windows_dk_libDebug		(${UWEBSOCKETS_Debug_Dir}/uWS.lib)
	Windows_dk_libRelease	(${UWEBSOCKETS_Release_Dir}/uWS.lib)
else()
	dk_libDebug			(${UWEBSOCKETS_Debug_Dir}/libuWS.a)
	dk_libRelease		(${UWEBSOCKETS_Release_Dir}/libuWS.a)
endif()

### GENERATE ###
dk_configure(${UWEBSOCKETS}
	${LIBUV_CMAKE}
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE})

### COMPILE ###
dk_build(${UWEBSOCKETS} uWS)

###### WITHOUT CMAKE #########
#DEBUG_dk_configure			(${UWEBSOCKETS})
#DEBUG_dk_build				(${UWEBSOCKETS})
##############################

