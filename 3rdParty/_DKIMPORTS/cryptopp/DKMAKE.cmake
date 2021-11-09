# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp
#
# https://github.com/webstorage119/website-1/raw/master/cryptopp600.zip
# https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_6_0.zip

if(IOSSIM)
	#DKDEPEND(libmd)
	#DKDEPEND(macports)
endif()

### VERSION ###
DKSET(CRYPTO_VERSION 600)
DKSET(CRYPTO_NAME cryptopp${CRYPTO_VERSION})
DKSET(CRYPTO_DL https://github.com/webstorage119/website-1/raw/master/${CRYPTO_NAME}.zip)

#DKSET(CRYPTO_VERSION 8_6_0)
#DKSET(CRYPTO_NAME CRYPTOPP_${CRYPTO_VERSION})
#DKSET(CRYPTO_DL https://github.com/weidai11/cryptopp/archive/refs/tags/${CRYPTO_NAME}.zip)

DKSET(CRYPTO ${3RDPARTY}/${CRYPTO_NAME})


### INSTALL ###
DKINSTALL(${CRYPTO_DL} cryptopp ${CRYPTO})


### LINK ###
WIN_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
WIN_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)
APPLE_DEBUG_LIB(${CRYPTO}/${OS}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
APPLE_RELEASE_LIB(${CRYPTO}/${OS}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
LINUX_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/libcryptopp-static.a)
LINUX_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/libcryptopp-static.a)
RASPBERRY_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/libcryptopp-static.a)
RASPBERRY_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/libcryptopp-static.a)
ANDROID_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/libcryptopp-static.a)
ANDROID_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/libcryptopp-static.a)


### COMPILE ###
WIN_PATH(${CRYPTO}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} ${CRYPTO})
WIN64_COMMAND(${DKCMAKE_WIN64} ${CRYPTO})
WIN_VS(${CRYPTO_NAME} cryptopp.sln cryptopp-static)


MAC_PATH(${CRYPTO}/${OS})
MAC32_COMMAND(${DKCMAKE_MAC32} ${CRYPTO})
MAC64_COMMAND(${DKCMAKE_MAC64} ${CRYPTO})
MAC_XCODE(${CRYPTO_NAME} cryptopp-static)


IOS_PATH(${CRYPTO}/${OS})
IOS32_COMMAND(${DKCMAKE_MAC32} ${CRYPTO})
IOS64_COMMAND(${DKCMAKE_MAC64} ${CRYPTO})
IOS_XCODE(${CRYPTO_NAME} cryptopp-static)


IOSSIM_PATH(${CRYPTO}/${OS})
IOSSIM32_COMMAND(${DKCMAKE_MAC32} ${LIBMD_APPLE} ${CRYPTO})
IOSSIM64_COMMAND(${DKCMAKE_MAC64} ${LIBMD_APPLE} ${CRYPTO})
IOSSIM_XCODE(${CRYPTO_NAME} cryptopp-static)


LINUX_DEBUG_PATH(${CRYPTO}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} ${CRYPTO})
LINUX_DEBUG_COMMAND(make cryptopp-static)
LINUX_RELEASE_PATH(${CRYPTO}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} ${CRYPTO})
LINUX_RELEASE_COMMAND(make cryptopp-static)


RASPBERRY_DEBUG_PATH(${CRYPTO}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${DKCMAKE_RASPBERRY_DEBUG} ${CRYPTO})
RASPBERRY_DEBUG_COMMAND(make cryptopp-static)
RASPBERRY_RELEASE_PATH(${CRYPTO}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${DKCMAKE_RASPBERRY_RELEASE} ${CRYPTO})
RASPBERRY_RELEASE_COMMAND(make cryptopp-static)


ANDROID_PATH(${CRYPTO}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} "-DCMAKE_CXX_FLAGS=/I${ANDROIDNDK}/sources/android/cpufeatures"  ${CRYPTO})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} "-DCMAKE_CXX_FLAGS=/I${ANDROIDNDK}/sources/android/cpufeatures" ${CRYPTO})
ANDROID_VS(${CRYPTO_NAME} cryptopp.sln cryptopp-static)
