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
dk_include		(${FLAC}																FLAC_INCLUDE_DIR)
dk_libDebug		(${FLAC}/${OS}/${DEBUG_DIR}/src/libFLAC/.libs/libFLAC-static.a			FLAC_LIBRARY_DEBUG)
dk_libRelease	(${FLAC}/${OS}/${RELEASE_DIR}/src/libFLAC/.libs/libFLAC-static.a		FLAC_LIBRARY_RELEASE)


### 3rd Party Link ###
if(MULTI_CONFIG)
	dk_set(FLAC_CMAKE 
		-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
		-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
		-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG}
		-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE})
else()
	DEBUG_dk_set(FLAC_CMAKE 
		-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
		-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
		-DFLAC_LIBRARY=${FLAC_LIBRARY_DEBUG}
		-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG})
	RELEASE_dk_set(FLAC_CMAKE 
		-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
		-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
		-DFLAC_LIBRARY=${FLAC_LIBRARY_RELEASE}
		-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE})
endif()



### GENERATE / COMPILE ###
string(REPLACE "-std=c++17" "" 	FLAC_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "  " 		" " FLAC_BUILD "${FLAC_BUILD}")

DEBUG_dk_setPath		(${FLAC}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueCommand	(${FLAC_BUILD} ${OGG_CONFIGURE})
DEBUG_dk_queueCommand   (make)

RELEASE_dk_setPath		(${FLAC}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueCommand	(${FLAC_BUILD} ${OGG_CONFIGURE})
RELEASE_dk_queueCommand	(make)

