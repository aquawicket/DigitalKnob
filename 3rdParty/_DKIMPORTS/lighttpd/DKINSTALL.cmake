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


############ lighttpd ############
# https://github.com/lighttpd/lighttpd1.4.git
# https://github.com/lighttpd/lighttpd1.4/archive/refs/heads/master.zip

dk_import()

dk_include			(${lighttpd}/lib)
dk_include			(${lighttpd_Build_Dir})
if(Windows)
	dk_libDebug		(${lighttpd}/${Target_Tuple}/lib/${Debug_Dir}/liblighttpd.lib)
	dk_libRelease	(${lighttpd}/${Target_Tuple}/lib/${Release_Dir}/liblighttpd.lib)
else()
	dk_libDebug		(${lighttpd}/${Target_Tuple}/lib/${Debug_Dir}/liblighttpd.a)
	dk_libRelease	(${lighttpd}/${Target_Tuple}/lib/${Release_Dir}/liblighttpd.a)
endif()

dk_configure() # -DLWS_WITH_SSL=OFF

dk_build(${lighttpd} LIGHTTPD)
