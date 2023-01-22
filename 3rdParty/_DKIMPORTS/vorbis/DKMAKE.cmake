# https://github.com/xiph/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies/
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip


### DEPEND ###
dk_depend(libgcc)
WIN_dk_depend(msys)
WIN_dk_depend(msys2)
dk_depend(ogg)


### IMPORT ###
dk_import(https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip)


### LINK ###
dk_include				(${VORBIS}/include)
ANDROID_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisenc.a)
ANDROID_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisfile.a)
ANDROID_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisenc.a)
ANDROID_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisfile.a)
EMSCRIPTEN_dk_libDebug	(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
EMSCRIPTEN_dk_libDebug	(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
EMSCRIPTEN_dk_libDebug	(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
EMSCRIPTEN_dk_libRelease(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
EMSCRIPTEN_dk_libRelease(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
EMSCRIPTEN_dk_libRelease(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
APPLE_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
APPLE_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
APPLE_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
APPLE_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
APPLE_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
APPLE_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
LINUX_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
LINUX_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
LINUX_dk_libDebug		(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
LINUX_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
LINUX_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
LINUX_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
RASPBERRY_dk_libDebug	(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
RASPBERRY_dk_libDebug	(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_dk_libDebug	(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
RASPBERRY_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
RASPBERRY_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_dk_libRelease	(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
WIN_dk_libDebug			(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
WIN_dk_libDebug			(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
WIN_dk_libDebug			(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
WIN_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
WIN_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
WIN_dk_libRelease		(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)


### 3RDPARTY LINK ###
ANDROID_DEBUG_dk_set		(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_INCLUDE_DIRS=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBIS_LIBRARIES=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
ANDROID_RELEASE_dk_set		(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_INCLUDE_DIRS=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBIS_LIBRARIES=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
APPLE_DEBUG_dk_set			(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
APPLE_RELEASE_dk_set		(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
EMSCRIPTEN_DEBUG_dk_set		(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
EMSCRIPTEN_RELEASE_dk_set	(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
LINUX_DEBUG_dk_set			(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
LINUX_RELEASE_dk_set		(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_DEBUG_dk_set		(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_RELEASE_dk_set	(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
WIN_DEBUG_dk_set			(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
WIN_RELEASE_dk_set			(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
	
	
### GENERATE / COMPILE ###
if(DEBUG)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
DEBUG_dk_setPath		(${VORBIS}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueShell		(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
DEBUG_dk_queueShell		(make)
if(RELEASE)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
RELEASE_dk_setPath		(${VORBIS}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
RELEASE_dk_queueShell	(make)
