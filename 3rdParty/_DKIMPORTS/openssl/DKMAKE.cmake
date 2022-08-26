# https://github.com/openssl/openssl
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z


WIN_dk_import(https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z)
if(NOT WIN)
	dk_import(https://github.com/openssl/openssl.git)
endif()


### LINK ###
dk_include				(${OPENSSL}/include)
WIN32_dk_libDebug		(${OPENSSL}/lib/libeay32MTd.lib)
WIN32_dk_libRelease		(${OPENSSL}/lib/libeay32MT.lib)
WIN64_dk_libDebug		(${OPENSSL}/lib64/libeay32MTd.lib)
WIN64_dk_libRelease		(${OPENSSL}/lib64/libeay32MT.lib)
APPLE_dk_libDebug		(${3RDPARTY}/openssl-mac/lib/libeay32MT.a)
APPLE_dk_libRelease		(${3RDPARTY}/openssl-mac/lib/libeay32MT.a)
LINUX_dk_libDebug		(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
LINUX_dk_libRelease		(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
RASPBERRY_dk_libDebug	(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
RASPBERRY_dk_libRelease	(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
ANDROID_dk_libDebug		(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
ANDROID_dk_libRelease	(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)

WIN32_dk_libDebug		(${OPENSSL}/lib/ssleay32MTd.lib)
WIN32_dk_libRelease		(${OPENSSL}/lib/ssleay32MT.lib)
WIN64_dk_libDebug		(${OPENSSL}/lib64/ssleay32MTd.lib)
WIN64_dk_libRelease		(${OPENSSL}/lib64/ssleay32MT.lib)
APPLE_dk_libDebug		(${3RDPARTY}/openssl-mac/lib/ssleay32MTd.a)
APPLE_dk_libRelease		(${3RDPARTY}/openssl-mac/lib/ssleay32MT.a)
LINUX_dk_libDebug		(${3RDPARTY}/openssl-linux/lib/ssleay32MTd.a)
LINUX_dk_libRelease		(${3RDPARTY}/openssl-linux/lib/ssleay32MT.a)
RASPBERRY_dk_libDebug	(${3RDPARTY}/openssl-linux/lib/ssleay32MTd.a)
RASPBERRY_dk_libRelease	(${3RDPARTY}/openssl-linux/lib/ssleay32MT.a)
ANDROID_dk_libDebug		(${3RDPARTY}/openssl-linux/lib/ssleay32MTd.a)
ANDROID_dk_libRelease	(${3RDPARTY}/openssl-linux/lib/ssleay32MT.a)


### 3RDPARTY LINK ###
#-DOPENSSL_ROOT_DIR=${OPENSSL} 
WIN32_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib)
WIN64_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib)
#APPLE_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)
#LINUX_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)
#RASPBERRY_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)
#ANDROID_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)


### GENERATE ###
MAC_DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand("../../configure")
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand("../../configure")
MAC_RELEASE_dk_queueCommand(make)

### COMPILE ###
