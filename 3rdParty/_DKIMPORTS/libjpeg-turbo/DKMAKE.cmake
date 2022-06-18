# https://github.com/libjpeg-turbo/libjpeg-turbo
# https://libjpeg-turbo.org/
# For ANDROID - https://github.com/DeviceFarmer/android-libjpeg-turbo
# https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz/download

#dk_import(https://github.com/libjpeg-turbo/libjpeg-turbo NOPATCH)
dk_set(LIBJPEG-TURBO_VERSION 2.1.1)
dk_set(LIBJPEG-TURBO_NAME libjpeg-turbo-${LIBJPEG-TURBO_VERSION})
dk_set(LIBJPEG-TURBO_DL https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz)
dk_set(LIBJPEG-TURBO ${3RDPARTY}/${LIBJPEG-TURBO_NAME})
dk_install(${LIBJPEG-TURBO_DL} libjpeg-turbo ${LIBJPEG-TURBO} NOPATCH)


### DKPLUGINS LINK ###
dk_include(${LIBJPEG-TURBO})
dk_include(${LIBJPEG-TURBO}/${OS})
dk_include(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR})
dk_include(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR})
ANDROID_dk_include(${LIBJPEG-TURBO}/${OS}/$(BUILD_TYPE)/jni)
WIN_DEBUG_DKLIB(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/turbojpeg-static.lib)
WIN_RELEASE_DKLIB(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/turbojpeg-static.lib)
APPLE_DEBUG_DKLIB(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
APPLE_RELEASE_DKLIB(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
LINUX_DEBUG_DKLIB(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
LINUX_RELEASE_DKLIB(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
RASPBERRY_DEBUG_DKLIB(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
RASPBERRY_RELEASE_DKLIB(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
##ANDROID_DEBUG_DKLIB(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libturbojpeg.a)
##ANDROID_RELEASE_DKLIB(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libturbojpeg.a)
ANDROID_DEBUG_DKLIB(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
ANDROID_RELEASE_DKLIB(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)


### 3RDPARTY LINK ###
WIN_dk_set(LIBJPEG-TURBO_CMAKE "-DCMAKE_C_FLAGS=/I${LIBJPEG-TURBO}/${OS}" -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_LIBRARY_RELEASE=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/turbojpeg-static.lib)
APPLE_dk_set(LIBJPEG-TURBO_CMAKE -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS} -DJPEG_LIBRARY_RELEASE=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
LINUX_DEBUG_dk_set(LIBJPEG-TURBO_CMAKE -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
LINUX_RELEASE_dk_set(LIBJPEG-TURBO_CMAKE -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
RASPBERRY_DEBUG_dk_set(LIBJPEG-TURBO_CMAKE -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
RASPBERRY_RELEASE_dk_set(LIBJPEG-TURBO_CMAKE -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
ANDROID_dk_set(LIBJPEG-TURBO_CMAKE -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)


### COMPILE ###
dk_setPath(${LIBJPEG-TURBO}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DWITH_SIMD=OFF ${LIBJPEG-TURBO})


WIN_VS(${LIBJPEG-TURBO_NAME} libjpeg-turbo.sln turbojpeg-static)
MAC_XCODE(${LIBJPEG-TURBO_NAME} turbojpeg-static)
IOS_XCODE(${LIBJPEG-TURBO_NAME} turbojpeg-static)
IOSSIM_XCODE(${LIBJPEG-TURBO_NAME} turbojpeg-static)
LINUX_dk_queueCommand(make turbojpeg-static)
RASPBERRY_dk_queueCommand(make turbojpeg-static)
ANDROID_VS(${LIBJPEG-TURBO_NAME} libjpeg-turbo.sln turbojpeg-static)
