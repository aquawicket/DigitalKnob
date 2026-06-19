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


############ boxer ############
# https://github.com/aaronmjacobs/Boxer.git
# https://github.com/aaronmjacobs/Boxer/archive/5561c0fa1262f9b182a56cd0b06bcdca84a029a6.zip

if(Android OR Raspberry)
	dk_disable(boxer)
	dk_return()
endif()


dk_depend(cocoa)
dk_depend(libgtk-3-dev)


dk_import()


dk_include			(${boxer}/include)
dk_include			(${boxer_Config_Dir})

if(MSVC)
	dk_libDebug		(${boxer_Debug_Dir}/Boxer.lib)
	dk_libRelease	(${boxer_Release_Dir}/Boxer.lib)
else()
	dk_libDebug		(${boxer_Debug_Dir}/libBoxer.a)
	dk_libRelease	(${boxer_Release_Dir}/libBoxer.a)
endif()


dk_configure		(${boxer})


dk_build			(${boxer} Boxer)
