# https://gitlab.freedesktop.org/fontconfig/fontconfig.git
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/INSTALL


### IMPORT ###
dk_import(https://gitlab.freedesktop.org/fontconfig/fontconfig.git BRANCH main)


### LINK ###
dk_include		(${FONTCONFIG}/fontconfig)
dk_libDebug		(${FONTCONFIG}/${OS}/${DEBUG_DIR}/lib/.libs/libfontconfig.a)
dk_libRelease	(${FONTCONFIG}/${OS}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### 3RDPARTY LINK ###
dk_set		(FONTCONFIG_CMAKE -DFONTCONFIG_INCLUDE_DIR=${FONTCONFIG}/lib -DFONTCONFIG_LIBRARY=${FONTCONFIG}/${OS}/${RELEASE_DIR}/lib/.libs/libfontconfig.a)


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath		(${FONTCONFIG})
WIN_DEBUG_dk_queueMsys		(./autogen.sh)
WIN_DEBUG_dk_setPath		(${FONTCONFIG}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_queueMsys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_queueMsys		(make)

WIN_RELEASE_dk_setPath		(${FONTCONFIG})
WIN_RELEASE_dk_queueMsys	(./autogen.sh)
WIN_RELEASE_dk_setPath		(${FONTCONFIG}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_queueMsys	(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_queueMsys	(make)
