# https://github.com/openssl/openssl
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator


WIN_dk_import(https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z)
if(NOT WIN)
	dk_import(https://github.com/openssl/openssl.git)
endif()


### LINK ###
dk_include				(${OPENSSL}/include)
dk_include              (${OPENSSL}/${OS}/${RELEASE_DIR}/include)
WIN32_dk_libDebug		(${OPENSSL}/lib/libeay32MTd.lib)
WIN32_dk_libRelease		(${OPENSSL}/lib/libeay32MT.lib)
WIN64_dk_libDebug		(${OPENSSL}/lib64/libeay32MTd.lib)
WIN64_dk_libRelease		(${OPENSSL}/lib64/libeay32MT.lib)

WIN32_dk_libDebug		(${OPENSSL}/lib/ssleay32MTd.lib)
WIN32_dk_libRelease		(${OPENSSL}/lib/ssleay32MT.lib)
WIN64_dk_libDebug		(${OPENSSL}/lib64/ssleay32MTd.lib)
WIN64_dk_libRelease		(${OPENSSL}/lib64/ssleay32MT.lib)

APPLE_dk_libDebug		(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a)
APPLE_dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a)
APPLE_dk_libDebug		(${OPENSSL}/${OS}/${DEBUG_DIR}/libcrypto.a)
APPLE_dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a)
LINUX_dk_libDebug		(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a)
LINUX_dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a)
RASPBERRY_dk_libDebug	(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a)
RASPBERRY_dk_libRelease	(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a)
ANDROID_dk_libDebug		(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a)
ANDROID_dk_libRelease	(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a)


### 3RDPARTY LINK ###
#-DOPENSSL_ROOT_DIR=${OPENSSL} 
WIN32_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib)
WIN64_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib)
APPLE_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${RELEASE_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include")
LINUX_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${RELEASE_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include")
RASPBERRY_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${RELEASE_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include")
ANDROID_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${RELEASE_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include")


### GENERATE ###
### COMPILE ###
MAC_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(../../Configure no-shared --debug)
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(../../Configure no-shared --release)
MAC_RELEASE_dk_queueCommand(make)

IOS64_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
IOS64_DEBUG_dk_queueCommand(../../Configure ios64-xcrun no-shared --debug)
IOS64_DEBUG_dk_queueCommand(make)
IOS64_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
IOS64_RELEASE_dk_queueCommand(../../Configure ios64-xcrun no-shared --release)
IOS64_RELEASE_dk_queueCommand(make)

IOSSIM_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(../../Configure iossimulator-xcrun no-shared --debug)
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_dk_queueCommand(../../Configure iossimulator-xcrun no-shared --release)
IOSSIM_RELEASE_dk_queueCommand(make)

LINUX_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(../../Configure no-shared --debug)
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(../../Configure no-shared --release)
LINUX_RELEASE_dk_queueCommand(make)

RASPBERRY_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(../../Configure no-shared --debug)
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(../../Configure no-shared --release)
RASPBERRY_RELEASE_dk_queueCommand(make)

ANDROID_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueMsys(../../Configure no-shared --debug)
ANDROID_DEBUG_dk_queueMsys(make)
ANDROID_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueMsys(../../Configure no-shared --release)
ANDROID_RELEASE_dk_queueMsys(make)


####### openssl_binary ###############################################
# https://slproweb.com/products/Win32OpenSSL.html
# https://slproweb.com/download/Win64OpenSSL-3_0_4.exe
### INSTALL ###
# WIN_HOST_dk_set(OPENSSL_BINARY "C:/Program Files/OpenSSL-Win64")
# WIN_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/bin/openssl.exe)
# MAC_HOST_dk_set(OPENSSL_BINARY /usr/bin)
# MAC_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/openssl)
# LINUX_HOST_dk_set(OPENSSL_BINARY /usr/bin)
# LINUX_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/openssl)
# if(NOT EXISTS ${OPENSSL_BINARY_EXE})
# 	dk_info("Installing openssl_binary")
# 	if(WIN_HOST)	
# 		dk_download(https://slproweb.com/download/Win64OpenSSL-3_0_4.exe ${DKDOWNLOAD}/Win64OpenSSL-3_0_4.exe)
# 		dk_command(${DKDOWNLOAD}/Win64OpenSSL-3_0_4.exe)
# 	endif()
# 	if(MAC_HOST)
# 		dk_command(brew install openssl)
# 	endif()
# 	if(LINUX_HOST)
# 		dk_command(sudo apt-get -y install openssl)
# 	endif()
# endif()
# if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
# 	dk_assert("openssl_binary IS NOT FOUND OR INVALID")
# endif()
###################################################################