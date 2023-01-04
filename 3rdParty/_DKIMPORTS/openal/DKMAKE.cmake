# https://openal.org/
# https://openal-soft.org/
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
# https://www.openal-soft.org/openal-releases/openal-soft-1.15.1.tar.bz2
# https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2


### DEPEND ###
dk_depend(winmm.lib)


### IMPORT ###
if(ANDROID)
	dk_import(https://openal.org/downloads/OpenAL11CoreSDK.zip)
else()
	dk_import(https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2)
endif()


### LINK ###
dk_define					(AL_LIBTYPE_STATIC)
dk_include					(${OPENAL}/include)
dk_include					(${OPENAL}/include/AL)
ANDROID_DEBUG_dk_include	(${OPENAL}/${OS}/${DEBUG_DIR}/jni)
ANDROID_RELEASE_dk_include	(${OPENAL}/${OS}/${RELEASE_DIR}/jni)
file(REMOVE ${OPENAL}/include/AL/stdint.h)
file(REMOVE ${OPENAL}/include/AL/inttypes.h)
WIN_dk_libDebug				(${OPENAL}/${OS}/${DEBUG_DIR}/OpenAL32.lib)
WIN_dk_libRelease			(${OPENAL}/${OS}/${RELEASE_DIR}/OpenAL32.lib)
APPLE_dk_libDebug			(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
APPLE_dk_libRelease			(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_dk_libDebug			(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_dk_libRelease			(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
RASPBERRY_dk_libDebug		(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
RASPBERRY_dk_libRelease		(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
#ANDROID_dk_libDebug		(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
#ANDROID_dk_libRelease		(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
ANDROID_dk_libDebug			(${OPENAL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a)
ANDROID_dk_libRelease		(${OPENAL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a)
EMSCRIPTEN_dk_libDebug		(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
EMSCRIPTEN_dk_libRelease	(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)


### 3RDPARTY LINK ###
WIN_dk_set					(OPENAL_CMAKE "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL}/include/AL" "-DCMAKE_CXX_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
APPLE_dk_set				(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include/AL" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_DEBUG_dk_set			(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_RELEASE_dk_set		(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
RASPBERRY_DEBUG_dk_set		(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
RASPBERRY_RELEASE_dk_set	(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
ANDROID_dk_set				(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include/AL" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
EMSCRIPTEN_DEBUG_dk_set		(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
EMSCRIPTEN_RELEASE_dk_set	(OPENAL_CMAKE "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" "-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL}/include" -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)


### GENERATE ###
WIN_dk_queueCommand			(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DFORCE_STATIC_VCRT=ON "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC" ${OPENAL})
UNIX_dk_queueCommand		(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})


### COMPILE ###
WIN_dk_visualStudio	(${OPENAL_FOLDER} OpenAL) # windows
ANDROID_dk_ndk		(${OPENAL_FOLDER}) 		  # android
dk_xcode			(${OPENAL_FOLDER} OpenAL) # mac, ios, iossim
dk_make				(${OPENAL_FOLDER} OpenAL) # linux, rasperry, emscripten
