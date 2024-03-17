# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL


if(APPLE)
	dk_command(sudo port install fontconfig)
	return()
endif()

### IMPORT ###
dk_import(https://gitlab.freedesktop.org/fontconfig/fontconfig.git BRANCH main)


### LINK ###
dk_include		(${FONTCONFIG}/fontconfig)
dk_libDebug		(${FONTCONFIG}/${OS}/${DEBUG_DIR}/lib/.libs/libfontconfig.a)
dk_libRelease	(${FONTCONFIG}/${OS}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### 3RDPARTY LINK ###
dk_set(FONTCONFIG_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG}/lib -DFONTCONFIG_LIBRARY=${FONTCONFIG}/${OS}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${FONTCONFIG})
DEBUG_dk_queueCommand	(autoupdate)
DEBUG_dk_queueCommand	(autoconf)

#DEBUG_dk_setPath		(${FONTCONFIG}/${OS}/${DEBUG_DIR})
#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RELEASE_dk_setPath		(${FONTCONFIG}/${OS}/${RELEASE_DIR})
#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure	(${FONTCONFIG})


dk_build		(${FONTCONFIG})
