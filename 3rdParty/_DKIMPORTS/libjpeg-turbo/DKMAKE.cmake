## https://libjpeg-turbo.org/
## https://github.com/libjpeg-turbo/libjpeg-turbo
## For ANDROID - https://github.com/DeviceFarmer/android-libjpeg-turbo


### VERSION ###
DKSET(JPEG_VERSION 1.5.3)
##DKSET(JPEG_VERSION 2.1.0)
DKSET(JPEG ${3RDPARTY}/libjpeg-turbo-${JPEG_VERSION})


### INSTALL ###
## https://sourceforge.net/projects/libjpeg-turbo/files/1.5.3/libjpeg-turbo-1.5.3.tar.gz
## https://sourceforge.net/projects/libjpeg-turbo/files/2.1.0/libjpeg-turbo-2.1.0.tar.gz
DKINSTALL(https://sourceforge.net/projects/libjpeg-turbo/files/${JPEG_VERSION}/libjpeg-turbo-${JPEG_VERSION}.tar.gz libjpeg-turbo libjpeg-turbo-${JPEG_VERSION})


### DKPLUGINS LINK ###
DKINCLUDE(${JPEG})
DKINCLUDE(${JPEG}/${OS})
ANDROID_INCLUDE(${JPEG}/${OS}/$(BUILD_TYPE)/jni)
WIN_DEBUG_LIB(${JPEG}/${OS}/${DEBUG_DIR}/turbojpeg-static.lib)
WIN_RELEASE_LIB(${JPEG}/${OS}/${RELEASE_DIR}/turbojpeg-static.lib)
APPLE_DEBUG_LIB(${JPEG}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
APPLE_RELEASE_LIB(${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
LINUX_DEBUG_LIB(${JPEG}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
LINUX_RELEASE_LIB(${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
RASPBERRY_DEBUG_LIB(${JPEG}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
RASPBERRY_RELEASE_LIB(${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
##ANDROID_DEBUG_LIB(${JPEG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libturbojpeg.a)
##ANDROID_RELEASE_LIB(${JPEG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libturbojpeg.a)
ANDROID_DEBUG_LIB(${JPEG}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
ANDROID_RELEASE_LIB(${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)


### 3RDPARTY LINK ###
DKSET(JPEG_WIN -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/turbojpeg-static.lib)
DKSET(JPEG_APPLE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
DKSET(JPEG_LINUX -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS}/${RELEASE_DIR} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
DKSET(JPEG_RASPBERRY -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS}/${RELEASE_DIR} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
DKSET(JPEG_ANDROID -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libturbojpeg.a)


### COMPILE ###
WIN_PATH(${JPEG}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} -DWITH_SIMD=OFF ${JPEG})
WIN64_COMMAND(${DKCMAKE_WIN64} -DWITH_SIMD=OFF ${JPEG})
WIN_VS(libjpeg-turbo-${JPEG_VERSION} libjpeg-turbo.sln turbojpeg-static)


MAC_PATH(${JPEG}/${OS})
MAC_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 ${JPEG})
MAC_XCODE_DEBUG(libjpeg-turbo-${JPEG_VERSION} turbojpeg-static)
MAC_XCODE_RELEASE(libjpeg-turbo-${JPEG_VERSION} turbojpeg-static)


IOS_PATH(${JPEG}/${OS})
IOS_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS ${JPEG})
IOS_XCODE_DEBUG(libjpeg-turbo-${JPEG_VERSION} turbojpeg-static)
IOS_XCODE_RELEASE(libjpeg-turbo-${JPEG_VERSION} turbojpeg-static)


IOSSIM_PATH(${JPEG}/${OS})
IOSSIM_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR ${JPEG})
IOSSIM64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR64 ${JPEG})
IOSSIM_XCODE_DEBUG(libjpeg-turbo-${JPEG_VERSION} turbojpeg-static)
IOSSIM_XCODE_RELEASE(libjpeg-turbo-${JPEG_VERSION} turbojpeg-static)


LINUX_DEBUG_PATH(${JPEG}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG ${JPEG})
LINUX_DEBUG_COMMAND(make turbojpeg-static)

LINUX_RELEASE_PATH(${JPEG}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE ${JPEG})
LINUX_RELEASE_COMMAND(make turbojpeg-static)


RASPBERRY_DEBUG_PATH(${JPEG}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG ${JPEG})
RASPBERRY_DEBUG_COMMAND(make turbojpeg-static)

RASPBERRY_RELEASE_PATH(${JPEG}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE ${JPEG})
RASPBERRY_RELEASE_COMMAND(make turbojpeg-static)


#ANDROID_NDK(libjpeg-turbo-${JPEG_VERSION})
ANDROID_PATH(${JPEG}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} -DWITH_SIMD=OFF ${JPEG})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} -DWITH_SIMD=OFF ${JPEG})
ANDROID_VS(libjpeg-turbo-${JPEG_VERSION} libjpeg-turbo.sln turbojpeg-static)