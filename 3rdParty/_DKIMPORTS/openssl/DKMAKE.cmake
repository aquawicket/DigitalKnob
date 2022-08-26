# https://github.com/openssl/openssl
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z


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
LINUX_dk_set		(OPENSSL_CMAKE -DOPENSSL_ROOT_DIR=${OPENSSL})
RASPBERRY_dk_set	(OPENSSL_CMAKE -DOPENSSL_ROOT_DIR=${OPENSSL})
ANDROID_dk_set		(OPENSSL_CMAKE -DOPENSSL_ROOT_DIR=${OPENSSL})


### GENERATE ###
### COMPILE ###
APPLE_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
APPLE_DEBUG_dk_queueCommand(../../Configure no-shared --debug)
APPLE_DEBUG_dk_queueCommand(make)
APPLE_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
APPLE_RELEASE_dk_queueCommand(../../Configure no-shared --release)
APPLE_RELEASE_dk_queueCommand(make)

LINUX_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand("../../Configure --no-shared --debug")
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand("../../Configure --no-shared --release")
LINUX_RELEASE_dk_queueCommand(make)

RASPBERRY_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand("../../Configure --no-shared --debug")
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand("../../Configure --no-shared --release")
RASPBERRY_RELEASE_dk_queueCommand(make)

ANDROID_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueMsys("../../Configure --no-shared --debug")
ANDROID_DEBUG_dk_queueMsys(make)
ANDROID_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueMsys("../../Configure --no-shared --release")
ANDROID_RELEASE_dk_queueMsys(make)
