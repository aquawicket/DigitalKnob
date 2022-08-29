# https://robertying.io/posts/compile-openssl-and-curl-for-android
# https://curl.se/
# https://curl.haxx.se/download/curl-7.34.0.zip
# https://github.com/curl/curl


dk_depend(ws2_32.lib)
dk_depend(system_configuration)
dk_depend(dl)
dk_depend(zlib)
#dk_depend(openssl)
dk_depend(openssl_binary)


dk_import(https://github.com/curl/curl/archive/refs/tags/curl-7_43_0.zip)
#dk_import(https://github.com/curl/curl.git)


### LINK ###
dk_define				(CURL_STATICLIB)
dk_include				(${CURL}/include)
dk_include				(${CURL}/${OS}/include/curl)
DEBUG_dk_include		(${CURL}/${OS}/${DEBUG_DIR}/include/curl)
RELEASE_dk_include		(${CURL}/${OS}/${RELEASE_DIR}/include/curl)

WIN_dk_libDebug			(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.lib)
WIN_dk_libRelease		(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.lib)
APPLE_dk_libDebug		(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.a)
APPLE_dk_libRelease		(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
LINUX_dk_libDebug		(${CURL}/${OS}/${DEBUG_DIR}/lib/libcurl.a)
LINUX_dk_libRelease		(${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
RASPBERRY_dk_libDebug	(${CURL}/${OS}/${DEBUG_DIR}/lib/libcurl.a)
RASPBERRY_dk_libRelease	(${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
ANDROID_dk_libDebug		(${CURL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libcurl.a)
ANDROID_dk_libRelease	(${CURL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libcurl.a)


### GENERATE ###
dk_setPath(${CURL}/${BUILD_DIR})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} -DCURL_STATICLIB=ON -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_DISABLE_LDAP=ON -DCURL_USE_OPENSSL=ON ${OPENSSL_CMAKE} ${ZLIB_CMAKE} -DCURL_STATIC_CRT=ON ${CURL})
APPLE_dk_queueCommand		(${DKCMAKE_BUILD} -DCURL_STATICLIB=ON -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_DISABLE_LDAP=ON -DCURL_USE_OPENSSL=OFF ${OPENSSL_CMAKE} ${ZLIB_CMAKE} ${CURL})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DCURL_STATICLIB=ON -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_DISABLE_LDAP=ON -DCURL_USE_OPENSSL=OFF ${OPENSSL_CMAKE} ${ZLIB_CMAKE} ${CURL})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DCURL_STATICLIB=ON -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_DISABLE_LDAP=ON -DCURL_USE_OPENSSL=OFF ${OPENSSL_CMAKE} ${ZLIB_CMAKE} ${CURL})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} -DCURL_STATICLIB=ON -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_DISABLE_LDAP=ON -DCURL_USE_OPENSSL=OFF ${OPENSSL_CMAKE} ${ZLIB_CMAKE} -DHAVE_POSIX_STRERROR_R=1 -DHAVE_GLIBC_STRERROR_R=advanced -DHAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced ${CURL})

### COMPILE ###
dk_visualStudio				(${CURL_NAME} libcurl) #windows, android
dk_xcode					(${CURL_NAME} libcurl) #mac, ios, iossim
dk_make						(${CURL_NAME} libcurl) #linux, raspberry


# arm64
#export TARGET_HOST=aarch64-linux-android
#export TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$HOST_TAG
#PATH=$TOOLCHAIN/bin:$PATH
#export AR=$TOOLCHAIN/bin/$TARGET_HOST-ar
#export AS=$TOOLCHAIN/bin/$TARGET_HOST-as
#export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
#export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
#export LD=$TOOLCHAIN/bin/$TARGET_HOST-ld
#export RANLIB=$TOOLCHAIN/bin/$TARGET_HOST-ranlib
#export STRIP=$TOOLCHAIN/bin/$TARGET_HOST-strip
#export SSL_DIR=$PWD/../openssl/build/arm64-v8a
#./configure --host=$TARGET_HOST --target=$TARGET_HOST --prefix=$PWD/build/arm64-v8a --disable-shared --with-ssl=$SSL_DIR
