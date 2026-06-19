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
dk_validate(Target_Config  "dk_Target_Config()")


############ wxwidgets ############
# https://github.com/wxWidgets/wxWidgets.git
# https://github.com/wxWidgets/wxWidgets/archive/refs/heads/master.zip
function(DKINSTALL)

	dk_import()

	dk_include			(${wxwidgets}/include)
	if(Windows)
		dk_libDebug	(${wxwidgets_Debug_Dir}/wxwidgets.lib)
		dk_libRelease	(${wxwidgets_Release_Dir}/wxwidgets.lib)
	else()
		dk_libDebug		(${wxwidgets_Debug_Dir}/libwxwidgets.a)
		dk_libRelease	(${wxwidgets_Release_Dir}/libwxwidgets.a)
	endif()
	

	dk_configure()

	dk_build()
endfunction()
