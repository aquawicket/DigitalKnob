# https://github.com/curl/curl
# https://curl.se/
# https://curl.haxx.se/download/curl-7.34.0.zip
# https://robertying.io/posts/compile-openssl-and-curl-for-android


### DEPEND ###
dk_depend(dl)
dk_depend(libssh)
dk_depend(openssl)
dk_depend(system_configuration)
dk_depend(ws2_32.lib)
dk_depend(zlib)


### IMPORT ###
UNIX_dk_import	(https://github.com/curl/curl/archive/refs/tags/curl-7_84_0.zip)
WIN_dk_import	(https://github.com/curl/curl/archive/refs/tags/curl-7_43_0.zip)
#dk_import		(https://github.com/curl/curl.git)


### LINK ###
dk_define			(CURL_STATICLIB)
dk_include			(${CURL}/include)
dk_include			(${CURL}/${OS}/include/curl)
DEBUG_dk_include	(${CURL}/${OS}/${DEBUG_DIR}/include/curl)
RELEASE_dk_include	(${CURL}/${OS}/${RELEASE_DIR}/include/curl)

if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.a)
	ANDROID_dk_libRelease	(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
	WIN_dk_libDebug			(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.lib)
	WIN_dk_libRelease		(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.lib)
elseif(XCODE_IDE)
	dk_libDebug				(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl-d.a)
	dk_libRelease			(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
else()
	dk_libDebug			(${CURL}/${OS}/${DEBUG_DIR}/lib/libcurl-d.a)
	dk_libRelease			(${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
endif()


### 3RDPARTY LINK ###
ANDROID_dk_set		(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
APPLE_dk_set		(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
EMSCRIPTEN_dk_set	(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
LINUX_dk_set		(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
RASPBERRY_dk_set	(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
WIN_dk_set			(CURL_CMAKE "-DCMAKE_C_FLAGS=/I${CURL}/${OS}/include/curl" "-DCMAKE_CXX_FLAGS=/I${CURL}/${OS}/include/curl" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.lib)


### GENERATE ###
ANDROID_dk_queueCommand(${DKCMAKE_BUILD} 
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	-DHAVE_POSIX_STRERROR_R=1
	-DHAVE_GLIBC_STRERROR_R=advanced
	-DHAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
EMSCRIPTEN_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
IOS_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	-DHAVE_POSIX_STRERROR_R=0
	#-DHAVE_POSIX_STRERROR_R=advanced
	#-DHAVE_POSIX_STRERROR_R__TRYRUN_OUTPUT=advanced
	-DHAVE_POLL_FINE_EXITCODE=advanced
	-DHAVE_POLL_FINE_EXITCODE__TRYRUN_OUTPUT=advanced
	-DHAVE_GLIBC_STRERROR_R=advanced
	-DHAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
IOSSIM_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	-DHAVE_POSIX_STRERROR_R=0
	#-DHAVE_POSIX_STRERROR_R=advanced
	#-DHAVE_POSIX_STRERROR_R__TRYRUN_OUTPUT=advanced
	-DHAVE_POLL_FINE_EXITCODE=advanced
	-DHAVE_POLL_FINE_EXITCODE__TRYRUN_OUTPUT=advanced
	-DHAVE_GLIBC_STRERROR_R=advanced
	-DHAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
LINUX_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
MAC_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=OFF
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})
WIN_dk_queueCommand(${DKCMAKE_BUILD}
	-DCURL_STATICLIB=ON
	-DBUILD_CURL_EXE=OFF
	-DBUILD_CURL_TESTS=OFF
	-DCURL_DISABLE_LDAP=ON
	-DCURL_USE_OPENSSL=ON
	-DCURL_STATIC_CRT=ON
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${CURL})


### COMPILE ###
dk_build(${CURL} libcurl)


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
