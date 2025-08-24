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


############ libwebsockets ############
# https://libwebsockets.org
# https://github.com/warmcat/libwebsockets
# https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip
dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
#dk_depend(openssl)

### IMPORT ###
dk_import(https://github.com/warmcat/libwebsockets/archive/6b950e86.zip)

### LINK ###
dk_include			(${LIBWEBSOCKETS}/lib)
dk_include			(${LIBWEBSOCKETS}/${Target_Tuple})
if(MSVC)
	dk_libDebug		(${LIBWEBSOCKETS}/${Target_Tuple}/lib/${Debug_Dir}/websockets_static.lib)
	dk_libRelease	(${LIBWEBSOCKETS}/${Target_Tuple}/lib/${Release_Dir}/websockets_static.lib)
else()
	dk_libDebug		(${LIBWEBSOCKETS.Debug_Dir}/lib/libwebsockets_static.a)
	dk_libRelease	(${LIBWEBSOCKETS.Release_Dir}/lib/libwebsockets_static.a)
endif()

### GENERATE ###
dk_configure(${LIBWEBSOCKETS} 
		-DLWS_WITH_MINIMAL_EXAMPLES=OFF
		-DLWS_WITH_SSL=OFF)

### COMPILE ###
dk_build(${LIBWEBSOCKETS} websockets)
