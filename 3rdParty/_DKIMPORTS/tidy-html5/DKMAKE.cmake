# https://github.com/htacg/tidy-html5
#
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip


dk_import(https://github.com/htacg/tidy-html5.git)

#dk_set(TIDY-HTML5_DL https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip)
#dk_set(TIDY-HTML5_VERSION 5.8.0)
#dk_set(TIDY-HTML5_NAME tidy_html5_${TIDY-HTML5_VERSION})
#dk_set(TIDY-HTML5 ${3RDPARTY}/${TIDY-HTML5_NAME})
#dk_install(${TIDY-HTML5_DL} tidy-html5 ${TIDY-HTML5})



### LINK ###
dk_include(${TIDY-HTML5})
dk_include(${TIDY-HTML5}/include)
dk_include(${TIDY-HTML5}/${OS})
ANDROID_dk_include(${TIDY-HTML5}/${OS}/$(BUILD_TYPE)/jni)
WIN_DEBUG_DKLIB(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
WIN_RELEASE_DKLIB(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/tidy_static.lib)
APPLE_DEBUG_DKLIB(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
APPLE_RELEASE_DKLIB(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
LINUX_DEBUG_DKLIB(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
LINUX_RELEASE_DKLIB(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
RASPBERRY_DEBUG_DKLIB(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
RASPBERRY_RELEASE_DKLIB(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
ANDROID_DEBUG_DKLIB(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
ANDROID_RELEASE_DKLIB(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)


### COMPILE ###
dk_setPath(${TIDY-HTML5}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE} ${TIDY-HTML5})


VS(${TIDY-HTML5_NAME} tidy.sln tidy-static)
#WIN_VS(${TIDY-HTML5_NAME} tidy.sln tidy-static)
XCODE(${TIDY-HTML5_NAME} tidy-static)
#MAC_XCODE(${TIDY-HTML5_NAME} tidy-static)
#IOS_XCODE(${TIDY-HTML5_NAME} tidy-static)
#IOSSIM_XCODE(${TIDY-HTML5_NAME} tidy-static)
LINUX_DKQCOMMAND(make tidy-static)
RASPBERRY_DKQCOMMAND(make tidy-static)
#ANDROID_VS(${TIDY-HTML5_NAME} tidy.sln tidy-static)
