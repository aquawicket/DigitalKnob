# https://openal.org/
# https://openal-soft.org/
#
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
# https://www.openal-soft.org/openal-releases/openal-soft-1.15.1.tar.bz2
# https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2
### VERSION ###
dk_set(OPENAL_VERSION 1.21.1)
dk_set(OPENAL_NAME openal-${OPENAL_VERSION})
dk_set(OPENAL_DL https://www.openal-soft.org/openal-releases/openal-soft-${OPENAL_VERSION}.tar.bz2)
dk_set(OPENAL ${3RDPARTY}/${OPENAL_NAME})


WIN_dk_depend(winmm.lib)


### INSTALL ###
#dk_import(${OPENAL_DL} ${OPENAL})
dk_import(${OPENAL_DL} ${OPENAL})

### LINK ###
dk_include(${OPENAL}/include)
dk_include(${OPENAL}/include/AL)
dk_define(AL_LIBTYPE_STATIC)
file(REMOVE ${OPENAL}/include/AL/stdint.h)
file(REMOVE ${OPENAL}/include/AL/inttypes.h)
WIN_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/OpenAL32.lib)
WIN_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/OpenAL32.lib)
APPLE_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
APPLE_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
RASPBERRY_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
RASPBERRY_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)


WIN_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
APPLE_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_DEBUG_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_RELEASE_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
RASPBERRY_DEBUG_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
RASPBERRY_RELEASE_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
ANDROID_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)


### COMPILE ###
dk_setPath(${OPENAL}/${BUILD_DIR})


WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC" -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
WIN_dk_visualStudio(${OPENAL_NAME} OpenAL)

MAC_dk_queueCommand(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
MAC_dk_xcode(${OPENAL_NAME} OpenAL)

IOS_dk_queueCommand(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
IOS_dk_xcode(${OPENAL_NAME} OpenAL)

IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
IOSSIM_dk_xcode(${OPENAL_NAME} OpenAL)

LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
LINUX_dk_queueCommand(make)

RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
RASPBERRY_dk_queueCommand(make)

ANDROID_dk_queueCommand(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
ANDROID_dk_visualStudio(${OPENAL_NAME} OpenAL)
