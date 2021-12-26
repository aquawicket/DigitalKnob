# https://github.com/openssl/openssl
# https://www.openssl.org/
#
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.1.zip


### VERSION ###
#WIN_SET(OPENSSL_VERSION 3.0.1)
#DKSET(OPENSSL_NAME openssl-${OPENSSL_VERSION})
#WIN_SET(OPENSSL_DL https://github.com/openssl/openssl/archive/refs/tags/${OPENSSL_NAME}.zip)

WIN_SET(OPENSSL_VERSION 1.0.2h-vs2015)
DKSET(OPENSSL_NAME openssl-${OPENSSL_VERSION})
WIN_SET(OPENSSL_DL https://www.npcglib.org/~stathis/downloads/${OPENSSL_NAME}.7z)

DKSET(OPENSSL ${3RDPARTY}/${OPENSSL_NAME})


### INSTALL ###
DKINSTALL(${OPENSSL_DL} openssl ${OPENSSL})


### DKPLUGINS LINK ###
DKINCLUDE(${OPENSSL}/include)
WIN32_DEBUG_LIB(${OPENSSL}/lib/libeay32MTd.lib)
WIN32_RELEASE_LIB(${OPENSSL}/lib/libeay32MT.lib)
WIN64_DEBUG_LIB(${OPENSSL}/lib64/libeay32MTd.lib)
WIN64_RELEASE_LIB(${OPENSSL}/lib64/libeay32MT.lib)
#APPLE_DEBUG_LIB(${3RDPARTY}/openssl-mac/lib/libeay32MT.a)
#APPLE_RELEASE_LIB(${3RDPARTY}/openssl-mac/lib/libeay32MT.a)
#LINUX_DEBUG_LIB(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
#LINUX_RELEASE_LIB(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
#RASPBERRY_DEBUG_LIB(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
#RASPBERRY_RELEASE_LIB(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
#ANDROID_DEBUG_LIB(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)
#ANDROID_RELEASE_LIB(${3RDPARTY}/openssl-linux/lib/libeay32MT.a)

WIN32_DEBUG_LIB(${OPENSSL}/lib/ssleay32MTd.lib)
WIN32_RELEASE_LIB(${OPENSSL}/lib/ssleay32MT.lib)
WIN64_DEBUG_LIB(${OPENSSL}/lib64/ssleay32MTd.lib)
WIN64_RELEASE_LIB(${OPENSSL}/lib64/ssleay32MT.lib)
#APPLE_DEBUG_LIB(${3RDPARTY}/openssl-mac/lib/ssleay32MTd.a)
#APPLE_RELEASE_LIB(${3RDPARTY}/openssl-mac/lib/ssleay32MT.a)
#LINUX_DEBUG_LIB(${3RDPARTY}/openssl-linux/lib/ssleay32MTd.a)
#LINUX_RELEASE_LIB(${3RDPARTY}/openssl-linux/lib/ssleay32MT.a)
#RASPBERRY_DEBUG_LIB(${3RDPARTY}/openssl-linux/lib/ssleay32MTd.a)
#RASPBERRY_RELEASE_LIB(${3RDPARTY}/openssl-linux/lib/ssleay32MT.a)
#ANDROID_DEBUG_LIB(${3RDPARTY}/openssl-linux/lib/ssleay32MTd.a)
#ANDROID_RELEASE_LIB(${3RDPARTY}/openssl-linux/lib/ssleay32MT.a)


### 3RDPARTY LINK ###
#-DOPENSSL_ROOT_DIR=${OPENSSL} 
WIN32_SET(OPENSSL_CMAKE -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib)

WIN64_SET(OPENSSL_CMAKE -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib)

#APPLE_SET(OPENSSL_CMAKE -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)

#LINUX_SET(OPENSSL_CMAKE -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)

#RASPBERRY_SET(OPENSSL_CMAKE -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)

#ANDROID_SET(OPENSSL_CMAKE -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.a -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.a -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.a -DSSL_EAY_RELEAS=${OPENSSL}/lib/ssleay32MT.a)



### COMPILE ###
# TODO