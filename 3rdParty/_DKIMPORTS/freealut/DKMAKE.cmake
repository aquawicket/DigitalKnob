# https://github.com/vancegroup/freealut
#
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)


### VERSION ###
DKGITCLONE(https://github.com/vancegroup/freealut)

#dk_set(FREEALUT_VERSION 1.1.0)
#dk_set(FREEALUT_NAME freealut-${FREEALUT_VERSION})
#dk_set(FREEALUT_DL http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/${FREEALUT_NAME}.tar.gz)
#dk_set(FREEALUT ${3RDPARTY}/${FREEALUT_NAME})
#dk_install(${FREEALUT_DL} freealut ${FREEALUT})


### LINK ###
dk_define(AL_LIBTYPE_STATIC)
dk_include(${FREEALUT}/include)
WIN_DEBUG_DKLIB(${FREEALUT}/${OS}/${DEBUG_DIR}/alut_static.lib)
WIN_RELEASE_DKLIB(${FREEALUT}/${OS}/${RELEASE_DIR}/alut_static.lib)
APPLE_DEBUG_DKLIB(${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a)
APPLE_RELEASE_DKLIB(${FREEALUT}/${OS}/${RELEASE_DIR}/libalut_static.a)
LINUX_DEBUG_DKLIB(${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a)
LINUX_RELEASE_DKLIB(${FREEALUT}/${OS}/${RELEASE_DIR}/libalut_static.a)



### COMPILE ###
dk_setPath(${CRYPTO}/${BUILD_DIR})
WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL}/include/AL /I${MSINTTYPES}" ${OPENAL_WIN} ${FREEALUT})
#WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /GR /EHsc /I${OPENAL}/include/AL /I${MSINTTYPES} /DAL_LIBTYPE_STATIC" ${OPENAL_WIN} ${FREEALUT})
WIN_dk_VisualStudio(${FREEALUT_NAME} Alut.sln alut_static)


MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${OPENAL_MAC} ${FREEALUT})
MAC_XCODE(${FREEALUT_NAME} alut_static)


LINUX_dk_queueCommand(${DKCMAKE_BUILD} ${OPENAL_LINUX} ${FREEALUT})
LINUX_dk_queueCommand(make alut_static)
