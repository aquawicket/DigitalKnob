#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ fontconfig ############
# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL

dk_load(dk_builder)

if(APPLE)
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} port install fontconfig)
	dk_installPackage(fontconfig)
	return()
endif()

### IMPORT ###
dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam ("${DKIMPORTS_DIR}/fontconfig/fontconfig.txt" 			FONTCONFIG_DL)
dk_import		(${FONTCONFIG_DL}										FONTCONFIG_INCLUDE_DIR)

### LINK ###
dk_include		(${FONTCONFIG}/fontconfig)
dk_libDebug		(${FONTCONFIG_DEBUG_DIR}/lib/.libs/libfontconfig.a		FONTCONFIG_DEBUG_LIBRARY)
dk_libRelease	(${FONTCONFIG_RELEASE_DIR}/lib/.libs/libfontconfig.a	FONTCONFIG_RELEASE_LIBRARY)
if(DEBUG)
	set(FONTCONFIG_LIBRARY ${FONTCONFIG_DEBUG_LIBRARY})
endif()
if(RELEASE)
	set(FONTCONFIG_LIBRARY ${FONTCONFIG_RELEASE_LIBRARY})
endif()


### 3RDPARTY LINK ###
dk_set(FONTCONFIG_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG_INCLUDE_DIR} -DFONTCONFIG_LIBRARY=${FONTCONFIG_LIBRARY})

### GENERATE / COMPILE ###
DEBUG_dk_cd				(${FONTCONFIG_DIR})
DEBUG_dk_queueCommand	(autoupdate)
DEBUG_dk_queueCommand	(autoconf)

#DEBUG_dk_cd			(${FONTCONFIG}/${triple}/${DEBUG_DIR})
#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RELEASE_dk_cd			(${FONTCONFIG}/${triple}/${RELEASE_DIR})
#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure			(${FONTCONFIG_DIR})

dk_build				(${FONTCONFIG_DIR})
