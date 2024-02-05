# https://github.com/xiph/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies/
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip


### DEPEND ###
dk_depend(libgcc)
WIN_dk_depend(msys2)
dk_depend(ogg)


### IMPORT ###
dk_import(https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip)


### LINK ###
dk_include					(${VORBIS}/include														VORBIS_INCLUDE_DIR)

if(ANDROID)
	ANDROID_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbis.a			VORBIG_DEBUG_LIBRARY)
	ANDROID_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisenc.a		VORBIG_ENC_DEBUG_LIBRARY)
	ANDROID_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisfile.a		VORBIG_FILE_DEBUG_LIBRARY)
	ANDROID_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbis.a		VORBIG_RELEASE_LIBRARY)
	ANDROID_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisenc.a	VORBIG_ENC_RELEASE_LIBRARY)
	ANDROID_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisfile.a	VORBIG_FILE_RELEASE_LIBRARY)
else()
	dk_libDebug				(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a						VORBIG_DEBUG_LIBRARY)
	dk_libDebug				(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a					VORBIG_ENC_DEBUG_LIBRARY)
	dk_libDebug				(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a					VORBIG_FILE_DEBUG_LIBRARY)
	dk_libRelease			(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a					VORBIG_RELEASE_LIBRARY)
	dk_libRelease			(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a				VORBIG_ENC_RELEASE_LIBRARY)
	dk_libRelease			(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a				VORBIG_FILE_RELEASE_LIBRARY)
endif()



### 3RDPARTY LINK ###
DEBUG_dk_set	(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} -DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} -DVORBIS_LIBRARY=${VORBIG_DEBUG_LIBRARY}   -DVORBIS_LIBRARIES=${VORBIG_DEBUG_LIBRARY}   -DVORBISFILE_LIBRARY=${VORBIG_FILE_DEBUG_LIBRARY}   -DVORBISENC_LIBRARY=${VORBIG_ENC_DEBUG_LIBRARY})
RELEASE_dk_set	(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} -DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} -DVORBIS_LIBRARY=${VORBIG_RELEASE_LIBRARY} -DVORBIS_LIBRARIES=${VORBIG_RELEASE_LIBRARY} -DVORBISFILE_LIBRARY=${VORBIG_FILE_RELEASE_LIBRARY} -DVORBISENC_LIBRARY=${VORBIG_ENC_RELEASE_LIBRARY})

	
### GENERATE / COMPILE ###
if(DEBUG)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
DEBUG_dk_setPath			(${VORBIS}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG_INCLUDE_DIR} ${OGG_CONFIGURE})
DEBUG_dk_queueCommand		(make)
	
if(RELEASE)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
RELEASE_dk_setPath			(${VORBIS}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueCommand		(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG_INCLUDE_DIR} ${OGG_CONFIGURE})
RELEASE_dk_queueCommand		(make)
