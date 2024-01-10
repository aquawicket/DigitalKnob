# https://github.com/curl/curl
# https://curl.se/
# https://curl.haxx.se/download/curl-7.34.0.zip
# https://robertying.io/posts/compile-openssl-and-curl-for-android


### DEPEND ###
dk_depend(dl)
dk_depend(libssh)
dk_depend(openssl)
dk_depend(pthread)
dk_depend(system_configuration)
dk_depend(ws2_32.lib)
dk_depend(zlib)


### IMPORT ###
if(MSVC)
	WIN_dk_import	(https://github.com/curl/curl/archive/refs/tags/curl-7_43_0.zip)
else()
	dk_import		(https://github.com/curl/curl/archive/refs/tags/curl-7_84_0.zip)
endif()
#dk_import			(https://github.com/curl/curl.git)


### LINK ###
dk_define					(CURL_STATICLIB)
dk_include					(${CURL}/include)
dk_include					(${CURL}/${OS}/include/curl)
DEBUG_dk_include			(${CURL}/${OS}/${DEBUG_DIR}/include/curl)
RELEASE_dk_include			(${CURL}/${OS}/${RELEASE_DIR}/include/curl)

if(MSVC)
	ANDROID_dk_libDebug		(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.a)
	ANDROID_dk_libRelease	(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
	WIN_dk_libDebug			(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.lib)
	WIN_dk_libRelease		(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.lib)
elseif(APPLE)
	dk_libDebug				(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl-d.a)
	dk_libRelease			(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
else()
	dk_libDebug				(${CURL}/${OS}/${DEBUG_DIR}/lib/libcurl-d.a)
	dk_libRelease			(${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
endif()


### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set		(CURL_CMAKE "-DCMAKE_C_FLAGS=/I${CURL}/${OS}/include/curl" "-DCMAKE_CXX_FLAGS=/I${CURL}/${OS}/include/curl" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.lib)
	ANDROID_dk_set	(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
elseif(APPLE)
	APPLE_dk_set	(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
else()
	dk_set			(CURL_CMAKE "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include" "-DCMAKE_CXX_FLAGS=-I${CURL}/${OS}/include" -DCURL_INCLUDE_DIR=${CURL}/include -DCURL_LIBRARY=${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
endif()



### GENERATE ###
if(MSVC)
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
elseif(ANDROID)
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
elseif(IOS OR IOSSIM)
	dk_queueCommand(${DKCMAKE_BUILD}
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
else()
	dk_queueCommand(${DKCMAKE_BUILD}
		-DBUILD_RELEASE_DEBUG_DIRS=OFF
		-DBUILD_CURL_EXE=OFF
		-DBUILD_CURL_TESTS=OFF
		-DBUILD_DASHBOARD_REPORTS=OFF
		-DCMAKE_USE_GSSAPI=OFF
		-DCMAKE_USE_LIBSSH2=OFF
		-DCMAKE_USE_OPENLDAP=OFF
		-DCURL_DISABLE_COOKIES=OFF
		-DCURL_DISABLE_CRYPTO_AUTH=OFF
		-DCURL_DISABLE_DICT=OFF
		-DCURL_DISABLE_FILE=OFF
		-DCURL_DISABLE_FTP=OFF
		-DCURL_DISABLE_GOPHER=OFF
		-DCURL_DISABLE_HTTP=OFF
		-DCURL_DISABLE_IMAP=OFF
		-DCURL_DISABLE_LDAP=OFF
		-DCURL_DISABLE_LDAPS=OFF
		-DCURL_DISABLE_POP3=OFF
		-DCURL_DISABLE_PROXY=OFF
		-DCURL_DISABLE_RTSP=OFF
		-DCURL_DISABLE_SMTP=OFF
		-DCURL_DISABLE_TELNET=OFF
		-DCURL_DISABLE_TFTP=OFF
		-DCURL_DISABLE_VERBOSE_STRINGS=OFF
		-DCURL_HIDDEN_SYMBOLS=ON
		-DCURL_STATICLIB=ON
		-DCURL_USE_OPENSSL=OFF
		-DCURL_ZLIB=OFF
		-DDISABLED_THREADSAFE=OFF
		-DENABLE_ARES=OFF
		-DENABLE_CURLDEBUG=OFF
		-DENABLE_DEBUG=OFF
		-DENABLE_IPV6=OFF
		-DENABLE_MANUAL=OFF
		-DENABLE_SHARED=OFF
		-DENABLE_THREADED_RESOLVER=OFF
		-DENABLE_UNIX_SOCKETS=ON
		-DHTTP_ONLY=OFF
		-DUSE_WIN32_LDAP=ON
		${OPENSSL_CMAKE}
		${ZLIB_CMAKE}
		${CURL})
endif()




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
