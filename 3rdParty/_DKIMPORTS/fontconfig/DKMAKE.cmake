include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL


if(APPLE)
	dk_command(sudo port install fontconfig)
	return()
endif()

### IMPORT ###
#dk_import(https://gitlab.freedesktop.org/fontconfig/fontconfig.git BRANCH main)
dk_import(https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/main/fontconfig-main.zip)



### LINK ###
dk_include		(${FONTCONFIG}/fontconfig)
dk_libDebug		(${FONTCONFIG}/${OS}/${DEBUG_DIR}/lib/.libs/libfontconfig.a)
dk_libRelease	(${FONTCONFIG}/${OS}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### 3RDPARTY LINK ###
dk_set(FONTCONFIG_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG}/lib -DFONTCONFIG_LIBRARY=${FONTCONFIG}/${OS}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### GENERATE / COMPILE ###
DEBUG_dk_cd		(${FONTCONFIG})
DEBUG_TARGET_dk_queueCommand	(autoupdate)
DEBUG_TARGET_dk_queueCommand	(autoconf)

#DEBUG_dk_cd		(${FONTCONFIG}/${OS}/${DEBUG_DIR})
#DEBUG_TARGET_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RELEASE_dk_cd		(${FONTCONFIG}/${OS}/${RELEASE_DIR})
#RELEASE_TARGET_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure	(${FONTCONFIG})


dk_build		(${FONTCONFIG})
