# https://github.com/xiph/flac.git
# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2-win.zip
# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz


### DEPEND ###
dk_depend(nasm)
dk_depend(ogg)


### IMPORT ###
dk_import(https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz)
#dk_import(https://github.com/xiph/flac.git)


### LINK ###
dk_include		(${FLAC})
dk_libDebug		(${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
dk_libRelease	(${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)


### 3rd Party Link ###
ANDROID_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include 
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a 
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
APPLE_dk_set(FLAC_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC}/include 
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a 
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)
EMSCRIPTEN_DEBUG_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include
	-DFLAC_LIBRARY=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a)
EMSCRIPTEN_RELEASE_dk_set(FLAC_CMAKE 
	-DFLAC_INCLUDE_DIR=${FLAC}/include
	-DFLAC_LIBRARY=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a
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
WIN_dk_set(FLAC_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC}/include 
	-DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a 
	-DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a)


### GENERATE / COMPILE ###
string(REPLACE "-std=c++17" "" FLAC_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "  " " " FLAC_BUILD "${FLAC_BUILD}")

DEBUG_dk_setPath		(${FLAC}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueshell		(${FLAC_BUILD} ${OGG_CONFIGURE})
DEBUG_dk_queueshell		(make)
RELEASE_dk_setPath		(${FLAC}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueshell	(${FLAC_BUILD} ${OGG_CONFIGURE})
RELEASE_dk_queueshell	(make)
