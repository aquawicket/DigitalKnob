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


############ libwebsockets ############
# https://libwebsockets.org
# https://github.com/warmcat/libwebsockets
# https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip
# https://github.com/warmcat/libwebsockets/archive/6b950e86.zip

#dk_depend(openssl)

dk_import()

dk_include			(${libwebsockets}/lib)
dk_include			(${libwebsockets}/${Target_Tuple})
if(MSVC)
	dk_libDebug		(${libwebsockets}/${Target_Tuple}/lib/${Debug_Dir}/websockets_static.lib)
	dk_libRelease	(${libwebsockets}/${Target_Tuple}/lib/${Release_Dir}/websockets_static.lib)
else()
	dk_libDebug		(${libwebsockets_Debug_Dir}/lib/libwebsockets_static.a)
	dk_libRelease	(${libwebsockets_Release_Dir}/lib/libwebsockets_static.a)
endif()

dk_configure(${libwebsockets} 
		-DLWS_WITH_MINIMAL_EXAMPLES=OFF
		-DLWS_WITH_SSL=OFF)

dk_build(${libwebsockets} websockets)
