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


############ embed ############
# https://github.com/batterycenter/embed
# https://github.com/batterycenter/embed/archive/465081903d97ff1ed05e1fd5d0b3c8032a4a26a6.zip

#dk_depend(libname)

dk_import			()

dk_include			(${embed}/include)
if(Unix)
	dk_libDebug		(${embed_Debug_Dir}/libembed.a)
	dk_libRelease	(${embed_Release_Dir}/libembed.a)
else()
	dk_libDebug		(${embed_Debug_Dir}/libembed.lib)
	dk_libRelease	(${embed_Release_Dir}/libembed.lib)
endif()

dk_configure()

dk_build()
