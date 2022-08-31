# https://github.com/vancegroup/freealut
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)


### VERSION ###
#dk_set(FREEALUT_VERSION 1.1.0)
#dk_set(FREEALUT_NAME freealut-${FREEALUT_VERSION})
#dk_set(FREEALUT_DL http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/${FREEALUT_NAME}.tar.gz)
#dk_set(FREEALUT ${3RDPARTY}/${FREEALUT_NAME})
#dk_import(${FREEALUT_DL} ${FREEALUT})
dk_import(https://github.com/vancegroup/freealut.git)


### LINK ###
dk_define			(AL_LIBTYPE_STATIC)
dk_include			(${FREEALUT}/include)
WIN_dk_libDebug		(${FREEALUT}/${OS}/${DEBUG_DIR}/alut_static.lib)
WIN_dk_libRelease	(${FREEALUT}/${OS}/${RELEASE_DIR}/alut_static.lib)
UNIX_dk_libDebug	(${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a)
UNIX_dk_libRelease	(${FREEALUT}/${OS}/${RELEASE_DIR}/libalut_static.a)


### GENERATE ###
dk_setPath(${CRYPTO}/${BUILD_DIR})
#WIN_dk_queueCommand	(${DKCMAKE_BUILD} ${OPENAL_CMAKE} "-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /GR /EHsc /I${OPENAL}/include/AL /I${MSINTTYPES} /DAL_LIBTYPE_STATIC" ${FREEALUT})
WIN_dk_queueCommand		(${DKCMAKE_BUILD} ${OPENAL_CMAKE} "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL}/include/AL /I${MSINTTYPES}" ${FREEALUT})
MAC_dk_queueCommand		(${DKCMAKE_BUILD} ${OPENAL_CMAKE} ${FREEALUT})
LINUX_dk_queueCommand	(${DKCMAKE_BUILD} ${OPENAL_CMAKE} ${FREEALUT})


### COMPILE ###
dk_visualStudio	(${FREEALUT_NAME} alut_static)
dk_xcode		(${FREEALUT_NAME} alut_static)
dk_make			(${FREEALUT_NAME} alut_static)
