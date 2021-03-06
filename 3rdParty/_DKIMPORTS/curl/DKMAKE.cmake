## https://curl.se/

### DEPENDS ###
DKDEPEND(zlib)
DKDEPEND(openssl-vs2015)


### VERSION ###
DKSET(CURL_VERSION 7.34.0)
DKSET(CURL_NAME curl-${CURL_VERSION})
DKSET(CURL ${3RDPARTY}/${CURL_NAME})


### INSTALL ###
## https://curl.haxx.se/download/curl-7.34.0.zip
DKINSTALL(https://curl.haxx.se/download/${CURL_NAME}.zip curl ${CURL_NAME})


### DKPLUGINS LINK ###
DKDEFINE(CURL_STATICLIB)
DKINCLUDE(${CURL}/include)
DKINCLUDE(${CURL}/${OS}/include/curl)
WIN_DEBUG_LIB(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.lib)
WIN_RELEASE_LIB(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.lib)
APPLE_DEBUG_LIB(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.a)
APPLE_RELEASE_LIB(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)
LINUX_DEBUG_LIB(${CURL}/${OS}/${DEBUG_DIR}/lib/libcurl.a)
LINUX_RELEASE_LIB(${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
RASPBERRY_DEBUG_LIB(${CURL}/${OS}/${DEBUG_DIR}/lib/libcurl.a)
RASPBERRY_RELEASE_LIB(${CURL}/${OS}/${RELEASE_DIR}/lib/libcurl.a)
ANDROID_DEBUG_LIB(${CURL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libcurl.a)
ANDROID_RELEASE_LIB(${CURL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libcurl.a)
##ANDROID_DEBUG_LIB(${CURL}/${OS}/lib/${DEBUG_DIR}/libcurl.a)
##ANDROID_RELEASE_LIB(${CURL}/${OS}/lib/${RELEASE_DIR}/libcurl.a)



### COMPILE ###
WIN_PATH(${CURL}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON ${OPENSSL_WIN} ${ZLIB_WIN} ${CURL})
WIN64_COMMAND(${DKCMAKE_WIN64} -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_WIN} ${CURL})
WIN_VS(${CURL_NAME} CURL.sln libcurl)


MAC_PATH(${CURL}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_APPLE} ${CURL})
MAC_XCODE(${CURL_NAME} libcurl)


IOS_PATH(${CURL}/${OS})
IOS64_COMMAND(${DKCMAKE_IOS64} -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_APPLE} ${CURL})
IOS_XCODE_RELEASE(${CURL_NAME} libcurl)


IOSSIM_PATH(${CURL}/${OS})
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF DHAVE_GLIBC_STRERROR_R=advanced HAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced ${ZLIB_APPLE} ${CURL})
IOSSIM_XCODE(${CURL_NAME} libcurl)


LINUX_DEBUG_PATH(${CURL}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_LINUX} ${CURL})
LINUX_DEBUG_COMMAND(make libcurl)

LINUX_RELEASE_PATH(${CURL}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_LINUX} ${CURL})
LINUX_RELEASE_COMMAND(make libcurl)


RASPBERRY_DEBUG_PATH(${CURL}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_RASPBERRY} ${CURL})
RASPBERRY_DEBUG_COMMAND(make libcurl)

RASPBERRY_RELEASE_PATH(${CURL}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCURL_DISABLE_LDAP=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_RASPBERRY} ${CURL})
RASPBERRY_RELEASE_COMMAND(make libcurl)


ANDROID_NDK(${CURL_NAME})

##ANDROID_PATH(${CURL}/${OS})
##ANDROID32_COMMAND(${DKCMAKE_ANDROID32} "-DANDROID_COMPILER_FLAGS=-DANDROID32 -D_ANDROID -DHAVE_POSIX_STRERROR_R" -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_ANDROID} ${CURL})
##ANDROID64_COMMAND(${DKCMAKE_ANDROID64} "-DANDROID_COMPILER_FLAGS=-DANDROID64 -D_ANDROID -DHAVE_POSIX_STRERROR_R" -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON -DCMAKE_USE_OPENSSL=OFF ${ZLIB_ANDROID} ${CURL})
##ANDROID_VS(${CURL_NAME} CURL.sln libcurl)