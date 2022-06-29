# https://github.com/xiph/flac
# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2-win.zip
# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz

### DEPENDS ###
dk_depend(nasm)
dk_depend(ogg)

#dk_import(https://github.com/xiph/flac)
dk_import(https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz)


### LINK ###
dk_include(${FLAC})
WIN_dk_libDebug(${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
WIN_dk_libRelease(${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
APPLE_dk_libDebug(${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
APPLE_dk_libRelease(${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
LINUX_dk_libDebug(${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
LINUX_dk_libRelease(${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
ANDROID_dk_libDebug(${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
ANDROID_dk_libRelease(${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)


### 3rd Party Link ###
WIN_dk_set(FLAC_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC}/include 
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a 
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
APPLE_dk_set(FLAC_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC}/include 
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a 
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
LINUX_DEBUG_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include
	-DFLAC_LIBRARY=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
LINUX_RELEASE_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include
	-DFLAC_LIBRARY=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
RASPBERRY_DEBUG_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include
	-DFLAC_LIBRARY=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
RASPBERRY_RELEASE_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include
	-DFLAC_LIBRARY=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
ANDROID_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include 
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a 
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)





### COMPILE ###
WIN_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
WIN_DEBUG_dk_msys(make)
WIN_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
WIN_RELEASE_dk_msys(make)


if(MAC)
	dk_removeSubstring(" -std=c17" "${DKCONFIGURE_BUILD}" DKCONFIGURE_BUILD)
endif()
MAC_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
MAC_RELEASE_dk_queueCommand(make)


IOS_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
IOS_DEBUG_dk_queueCommand(make)
IOS_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
IOS_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
IOS_RELEASE_dk_queueCommand(make)


IOSSIM_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
IOSSIM_RELEASE_dk_queueCommand(make)


LINUX_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
LINUX_RELEASE_dk_queueCommand(make)


RASPBERRY_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
RASPBERRY_RELEASE_dk_queueCommand(make)


ANDROID_DEBUG_dk_setPath(${FLAC}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_msys(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
ANDROID_DEBUG_dk_msys(make)
ANDROID_RELEASE_dk_setPath(${FLAC}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_msys(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
ANDROID_RELEASE_dk_msys(make)
