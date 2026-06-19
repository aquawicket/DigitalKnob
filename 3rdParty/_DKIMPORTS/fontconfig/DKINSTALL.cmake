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


############ fontconfig ############
# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL

if(Apple)
	dk_installPackage(fontconfig)
	dk_return()
endif()

dk_import()

dk_include		(${fontconfig}/fontconfig								FONTCONFIG_INCLUDE_DIR)
dk_libDebug		(${fontconfig_Debug_Dir}/lib/.libs/libfontconfig.a		FONTCONFIG_DEBUG_LIBRARY	FONTCONFIG_LIBRARY)
dk_libRelease	(${fontconfig_Release_Dir}/lib/.libs/libfontconfig.a	FONTCONFIG_RELEASE_LIBRARY	FONTCONFIG_LIBRARY)


### 3RDPARTY LINK ###
dk_set			(fontconfig_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG_INCLUDE_DIR} -DFONTCONFIG_LIBRARY=${FONTCONFIG_LIBRARY})

### GENERATE / COMPILE ###
#dk_chdir		(${fontconfig})
#dk_exec		(autoupdate)
#dk_exec		(autoconf)

dk_configure	(${fontconfig})

dk_build		(${fontconfig})
