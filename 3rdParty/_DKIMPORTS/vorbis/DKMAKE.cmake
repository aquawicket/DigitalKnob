# https://github.com/xiph/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies/
#
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip

### DEPENDS ###
WIN_dk_depend(mingw32)
WIN_dk_depend(mingw64)
WIN_dk_depend(msys)
#WIN_dk_depend(msys2)
dk_depend(libgcc)
dk_depend(ogg)


dk_import(https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip)


### dkplugin LINK ###
dk_include(${VORBIS}/include)
WIN_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
WIN_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
WIN_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
WIN_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
WIN_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
WIN_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
APPLE_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
APPLE_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
APPLE_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
APPLE_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
APPLE_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
APPLE_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
LINUX_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
LINUX_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
LINUX_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
LINUX_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
LINUX_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
LINUX_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
RASPBERRY_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
RASPBERRY_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
RASPBERRY_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
RASPBERRY_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
ANDROID_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisfile.a)
ANDROID_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisfile.a)
ANDROID_DEBUG_DKLIB(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisenc.a)
ANDROID_RELEASE_DKLIB(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisenc.a)


### 3RDPARTY LINK ###
WIN_DEBUG_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
WIN_RELEASE_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
APPLE_DEBUG_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
APPLE_RELEASE_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
LINUX_DEBUG_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
LINUX_RELEASE_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_DEBUG_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_RELEASE_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
ANDROID_DEBUG_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_INCLUDE_DIRS=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBIS_LIBRARIES=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
ANDROID_RELEASE_dk_set(VORBIS_CMAKE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_INCLUDE_DIRS=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBIS_LIBRARIES=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
	
	
### COMPILE ###
WIN_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
WIN_DEBUG_MSYS(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
WIN_DEBUG_MSYS(make)
WIN_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
WIN_RELEASE_MSYS(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
WIN_RELEASE_MSYS(make)


MAC_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
MAC_DEBUG_DKQCOMMAND(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
MAC_DEBUG_DKQCOMMAND(make)
MAC_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
MAC_RELEASE_DKQCOMMAND(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
MAC_RELEASE_DKQCOMMAND(make)


IOS_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
IOS_DEBUG_DKQCOMMAND(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
IOS_DEBUG_DKQCOMMAND(make)
IOS_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
IOS_RELEASE_DKQCOMMAND(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
IOS_RELEASE_DKQCOMMAND(make)


IOSSIM_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_DKQCOMMAND(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
IOSSIM_DEBUG_DKQCOMMAND(make)
IOSSIM_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_DKQCOMMAND(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
IOSSIM_RELEASE_DKQCOMMAND(make)


if(LINUX AND DEBUG)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
LINUX_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_DKQCOMMAND(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
LINUX_DEBUG_DKQCOMMAND(make)
if(LINUX AND RELEASE)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
LINUX_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_DKQCOMMAND(${DKCONFIGURE_BUILD} ${OGG_CONFIGURE})
LINUX_RELEASE_DKQCOMMAND(make)


if(RASPBERRY AND DEBUG)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
RASPBERRY_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_DKQCOMMAND(${DKCONFIGURE_BUILD} ${OGG__CONFIGURE})
RASPBERRY_DEBUG_DKQCOMMAND(make)
if(RASPBERRY AND RELEASE)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
RASPBERRY_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_DKQCOMMAND(${DKCONFIGURE_BUILD} ${OGG__CONFIGURE})
RASPBERRY_RELEASE_DKQCOMMAND(make)


#ANDROID_NDK(${VORBIS_NAME})
if(ANDROID)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
ANDROID_DEBUG_dk_setPath(${VORBIS}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_MSYS(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
ANDROID_DEBUG_MSYS(make)
if(ANDROID)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
ANDROID_RELEASE_dk_setPath(${VORBIS}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_MSYS(${DKCONFIGURE_BUILD} --with-ogg-includes=${OGG}/include ${OGG_CONFIGURE})
ANDROID_RELEASE_MSYS(make)
