# https://github.com/openssl/openssl.git
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator


### IMPORT ###
UNIX_dk_import	(https://github.com/openssl/openssl.git)
WIN_dk_import	(https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z)


### LINK ###
dk_include				(${OPENSSL}/include)
DEBUG_dk_include		(${OPENSSL}/${OS}/${DEBUG_DIR}/include)
RELEASE_dk_include      (${OPENSSL}/${OS}/${RELEASE_DIR}/include)

# libcrypto
UNIX_dk_libDebug		(${OPENSSL}/${OS}/${DEBUG_DIR}/libcrypto.a)
UNIX_dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a)

# libeay
WIN32_dk_libDebug		(${OPENSSL}/lib/libeay32MTd.lib)
WIN32_dk_libRelease		(${OPENSSL}/lib/libeay32MT.lib)
WIN64_dk_libDebug		(${OPENSSL}/lib64/libeay32MTd.lib)
WIN64_dk_libRelease		(${OPENSSL}/lib64/libeay32MT.lib)

# libssl
UNIX_dk_libDebug		(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a)
UNIX_dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a)
WIN32_dk_libDebug		(${OPENSSL}/lib/ssleay32MTd.lib)
WIN32_dk_libRelease		(${OPENSSL}/lib/ssleay32MT.lib)
WIN64_dk_libDebug		(${OPENSSL}/lib64/ssleay32MTd.lib)
WIN64_dk_libRelease		(${OPENSSL}/lib64/ssleay32MT.lib)


### 3RDPARTY LINK ###
#-DOPENSSL_ROOT_DIR=${OPENSSL}
UNIX_DEBUG_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${DEBUG_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${DEBUG_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a "-DCMAKE_C_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${DEBUG_DIR}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${DEBUG_DIR}/include")
UNIX_RELEASE_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${RELEASE_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a "-DCMAKE_C_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include")
WIN32_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib "-DCMAKE_C_FLAGS=-I${OPENSSL}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include")
WIN64_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib "-DCMAKE_C_FLAGS=-I${OPENSSL}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include")


### GENERATE ###
### COMPILE ###
DEBUG_dk_setPath				(${OPENSSL}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueShell		(../../Configure no-shared --debug)
EMSCRIPTEN_DEBUG_dk_queueShell	(../../Configure no-shared --debug)
IOS64_DEBUG_dk_queueShell		(../../Configure no-shared --debug ios64-xcrun)
IOSSIM_DEBUG_dk_queueShell		(../../Configure no-shared --debug iossimulator-xcrun)
LINUX_DEBUG_dk_queueShell		(../../Configure no-shared --debug)
MAC_DEBUG_dk_queueShell			(../../Configure no-shared --debug)
RASPBERRY_DEBUG_dk_queueShell	(../../Configure no-shared --debug)

UNIX_DEBUG_dk_queueShell	(make)


RELEASE_dk_setPath				(${OPENSSL}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueShell	(../../Configure no-shared --release)
EMSCRIPTEN_RELEASE_dk_queueShell(../../Configure no-shared --release)
IOS64_RELEASE_dk_queueShell		(../../Configure no-shared --release ios64-xcrun)
IOSSIM_RELEASE_dk_queueShell	(../../Configure no-shared --release iossimulator-xcrun)
LINUX_RELEASE_dk_queueShell		(../../Configure no-shared --release)
MAC_RELEASE_dk_queueShell		(../../Configure no-shared --release)
RASPBERRY_RELEASE_dk_queueShell	(../../Configure no-shared --release)

UNIX_RELEASE_dk_queueShell	(make)



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
