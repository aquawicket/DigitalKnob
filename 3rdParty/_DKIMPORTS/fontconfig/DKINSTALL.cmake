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


############ fontconfig ############
# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL

dk_validate(Target_Config  "dk_Target_Config()")

if(Apple)
	dk_installPackage(fontconfig)
	dk_return()
endif()

### IMPORT ###
dk_import		(${FONTCONFIG_DL}										FONTCONFIG_INCLUDE_DIR)

### LINK ###
dk_include		(${FONTCONFIG}/fontconfig)
dk_libDebug		(${FONTCONFIG_Debug_Dir}/lib/.libs/libfontconfig.a		FONTCONFIG_DEBUG_LIBRARY)
dk_libRelease	(${FONTCONFIG_Release_Dir}/lib/.libs/libfontconfig.a	FONTCONFIG_RELEASE_LIBRARY)
if(Debug)
	set(FONTCONFIG_LIBRARY ${FONTCONFIG_DEBUG_LIBRARY})
endif()
if(Release)
	set(FONTCONFIG_LIBRARY ${FONTCONFIG_RELEASE_LIBRARY})
endif()

### 3RDPARTY LINK ###
dk_set			(FONTCONFIG_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG_INCLUDE_DIR} -DFONTCONFIG_LIBRARY=${FONTCONFIG_LIBRARY})

### GENERATE / COMPILE ###
dk_chdir		(${FONTCONFIG})
#dk_exec		(autoupdate)
#dk_exec		(autoconf)
dk_configure	(${FONTCONFIG})
dk_build		(${FONTCONFIG})
