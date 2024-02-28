# https://github.com/xiph/vorbis
# https://ftp.osuosl.org/pub/xiph/releases/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies

### DEPEND ###
dk_depend(libgcc)
WIN_dk_depend(msys2)
dk_depend(ogg)


### IMPORT ###
#dk_import(https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip)
#dk_import(https://github.com/xiph/vorbis.git)
dk_import(https://github.com/xiph/vorbis/releases/download/v1.3.7/libvorbis-1.3.7.zip)


### LINK ###
dk_include			(${VORBIS}/include											VORBIS_INCLUDE_DIR)

#if(ANDROID)
if(MULTI_CONFIG)
	dk_libDebug		(${VORBIS}/${OS}/lib/${DEBUG_DIR}/libvorbis.a				VORBIG_DEBUG_LIBRARY)
	dk_libDebug		(${VORBIS}/${OS}/lib/${DEBUG_DIR}/libvorbisenc.a			VORBIG_ENC_DEBUG_LIBRARY)
	dk_libDebug		(${VORBIS}/${OS}/lib/${DEBUG_DIR}/libvorbisfile.a			VORBIG_FILE_DEBUG_LIBRARY)
	dk_libRelease	(${VORBIS}/${OS}/lib/${RELEASE_DIR}/libvorbis.a				VORBIG_RELEASE_LIBRARY)
	dk_libRelease	(${VORBIS}/${OS}/lib/${RELEASE_DIR}/libvorbisenc.a			VORBIG_ENC_RELEASE_LIBRARY)
	dk_libRelease	(${VORBIS}/${OS}/lib/${RELEASE_DIR}/libvorbisfile.a			VORBIG_FILE_RELEASE_LIBRARY)
else()
	dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/libvorbis.a				VORBIG_DEBUG_LIBRARY)
	dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/libvorbisenc.a			VORBIG_ENC_DEBUG_LIBRARY)
	dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/libvorbisfile.a			VORBIG_FILE_DEBUG_LIBRARY)
	dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/libvorbis.a				VORBIG_RELEASE_LIBRARY)
	dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/libvorbisenc.a			VORBIG_ENC_RELEASE_LIBRARY)
	dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/libvorbisfile.a			VORBIG_FILE_RELEASE_LIBRARY)
endif()
#else()
#	dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a			VORBIG_DEBUG_LIBRARY)
#	dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a		VORBIG_ENC_DEBUG_LIBRARY)
#	dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a		VORBIG_FILE_DEBUG_LIBRARY)
#	dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a		VORBIG_RELEASE_LIBRARY)
#	dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a	VORBIG_ENC_RELEASE_LIBRARY)
#	dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a	VORBIG_FILE_RELEASE_LIBRARY)
#endif()



### 3RDPARTY LINK ###
DEBUG_dk_set	(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} -DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} -DVORBIS_LIBRARY=${VORBIG_DEBUG_LIBRARY}   -DVORBIS_LIBRARIES=${VORBIG_DEBUG_LIBRARY}   -DVORBISFILE_LIBRARY=${VORBIG_FILE_DEBUG_LIBRARY}   -DVORBISENC_LIBRARY=${VORBIG_ENC_DEBUG_LIBRARY})
RELEASE_dk_set	(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} -DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} -DVORBIS_LIBRARY=${VORBIG_RELEASE_LIBRARY} -DVORBIS_LIBRARIES=${VORBIG_RELEASE_LIBRARY} -DVORBISFILE_LIBRARY=${VORBIG_FILE_RELEASE_LIBRARY} -DVORBISENC_LIBRARY=${VORBIG_ENC_RELEASE_LIBRARY})

	
### GENERATE ###
#if(ANDROID)
	dk_queueCommand(${DKCMAKE_BUILD}
					#-DBUILD_SHARED_LIBS=OFF 	# "Build shared library" OFF
					${OGG_CMAKE} 
					${VORBIS})
#else()
#	if(DEBUG)
#		set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
#	endif()
#	DEBUG_dk_setPath			(${VORBIS}/${OS}/${DEBUG_DIR})
#	DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
#	if(RELEASE)
#		set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
#	endif()
#	RELEASE_dk_setPath			(${VORBIS}/${OS}/${RELEASE_DIR})
#	RELEASE_dk_queueCommand		(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
#endif()


dk_build		(${VORBIS})
