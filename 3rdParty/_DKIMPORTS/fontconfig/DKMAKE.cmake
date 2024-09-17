include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL


if(APPLE)
	dk_depend(sudo)
	dk_command(${SUDO} port install fontconfig)
	return()
endif()

### IMPORT ###
#dk_import(https://gitlab.freedesktop.org/fontconfig/fontconfig.git BRANCH main)
dk_import(https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/main/fontconfig-main.zip)



### LINK ###
dk_include		(${FONTCONFIG}/fontconfig)
dk_libDebug		(${FONTCONFIG}/${triple}/${DEBUG_DIR}/lib/.libs/libfontconfig.a)
dk_libRelease	(${FONTCONFIG}/${triple}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### 3RDPARTY LINK ###
dk_set(FONTCONFIG_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG}/lib -DFONTCONFIG_LIBRARY=${FONTCONFIG}/${triple}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### GENERATE / COMPILE ###
DEBUG_dk_cd		(${FONTCONFIG})
DEBUG_dk_queueCommand	(autoupdate)
DEBUG_dk_queueCommand	(autoconf)

#DEBUG_dk_cd		(${FONTCONFIG}/${triple}/${DEBUG_DIR})
#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RELEASE_dk_cd		(${FONTCONFIG}/${triple}/${RELEASE_DIR})
#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure	(${FONTCONFIG_DIR})


dk_build		(${FONTCONFIG_DIR})
