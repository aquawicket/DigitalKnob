include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/xiph/vorbis
# https://ftp.osuosl.org/pub/xiph/releases/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies

### DEPEND ###
dk_depend(libgcc)
dk_depend(msys2)
dk_depend(ogg)


### IMPORT ###
#dk_import(https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip)
#dk_import(https://github.com/xiph/vorbis.git)
dk_import(https://github.com/xiph/vorbis/releases/download/v1.3.7/libvorbis-1.3.7.zip)


### LINK ###
dk_include			(${VORBIS_DIR}/include										VORBIS_INCLUDE_DIR)

#if(ANDROID)
if(MULTI_CONFIG)
	dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbis.a			VORBIS_DEBUG_LIB)
	dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbisenc.a		VORBIS_ENC_DEBUG_LIB)
	dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbisfile.a		VORBIS_FILE_DEBUG_LIB)
	dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbis.a		VORBIS_RELEASE_LIB)
	dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbisenc.a		VORBIS_ENC_RELEASE_LIB)
	dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbisfile.a	VORBIS_FILE_RELEASE_LIB)
else()
	dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/libvorbis.a						VORBIS_DEBUG_LIB)
	dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/libvorbisenc.a					VORBIS_ENC_DEBUG_LIB)
	dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/libvorbisfile.a					VORBIS_FILE_DEBUG_LIB)
	dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/libvorbis.a						VORBIS_RELEASE_LIB)
	dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/libvorbisenc.a					VORBIS_ENC_RELEASE_LIB)
	dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/libvorbisfile.a					VORBIS_FILE_RELEASE_LIB)
endif()
#else()
#	dk_libDebug		(${VORBIS}/${triple}/${DEBUG_DIR}/lib/.libs/libvorbis.a			VORBIS_DEBUG_LIB)
#	dk_libDebug		(${VORBIS}/${triple}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a		VORBIS_ENC_DEBUG_LIB)
#	dk_libDebug		(${VORBIS}/${triple}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a		VORBIS_FILE_DEBUG_LIB)
#	dk_libRelease	(${VORBIS}/${triple}/${RELEASE_DIR}/lib/.libs/libvorbis.a		VORBIS_RELEASE_LIB)
#	dk_libRelease	(${VORBIS}/${triple}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a	VORBIS_ENC_RELEASE_LIB)
#	dk_libRelease	(${VORBIS}/${triple}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a	VORBIS_FILE_RELEASE_LIB)
#endif()



### 3RDPARTY LINK ###
DEBUG_dk_set(VORBIS_CMAKE 
	-DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_LIBRARY=${VORBIS_DEBUG_LIB}
	-DVORBIS_LIBRARIES=${VORBIS_DEBUG_LIB}
	-DVORBISFILE_LIBRARY=${VORBIS_FILE_DEBUG_LIB}
	-DVORBISENC_LIBRARY=${VORBIS_ENC_DEBUG_LIB})
	
RELEASE_dk_set(VORBIS_CMAKE 
	-DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR}
	-DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR}
	-DVORBIS_LIBRARY=${VORBIS_RELEASE_LIB}
	-DVORBIS_LIBRARIES=${VORBIS_RELEASE_LIB}
	-DVORBISFILE_LIBRARY=${VORBIS_FILE_RELEASE_LIB}
	-DVORBISENC_LIBRARY=${VORBIS_ENC_RELEASE_LIB})

	
### GENERATE ###
#if(ANDROID)
dk_configure(${VORBIS} ${OGG_CMAKE})
#else()
#	if(DEBUG)
#		set(ENV{PKG_CONFIG_PATH} "${OGG}/${triple}/${DEBUG_DIR}")
#	endif()
#	DEBUG_dk_cd			(${VORBIS}/${triple}/${DEBUG_DIR})
#	DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
#	if(RELEASE)
#		set(ENV{PKG_CONFIG_PATH} "${OGG}/${triple}/${RELEASE_DIR}")
#	endif()
#	RELEASE_dk_cd			(${VORBIS}/${triple}/${RELEASE_DIR})
#	RELEASE_dk_queueCommand		(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
#endif()


dk_build		(${VORBIS})
