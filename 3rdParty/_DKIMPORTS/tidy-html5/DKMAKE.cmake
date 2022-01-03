# https://github.com/htacg/tidy-html5
#
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip

### VERSION ###
DKSET(TIDY_MAJOR 5)
DKSET(TIDY_MINOR 8)
DKSET(TIDY_BUILD 0)
DKSET(TIDY_DL https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip)



### INSTALL ###
DKSET(TIDY_VERSION ${TIDY_MAJOR}.${TIDY_MINOR}.${TIDY_BUILD})
DKSET(TIDY_NAME tidy_html5_${TIDY_VERSION})
DKSET(TIDY ${3RDPARTY}/${TIDY_NAME})
DKINSTALL(${TIDY_DL} tidy-html5 ${TIDY})



### LINK ###
DKINCLUDE(${TIDY})
DKINCLUDE(${TIDY}/include)
DKINCLUDE(${TIDY}/${OS})
ANDROID_DKINCLUDE(${TIDY}/${OS}/$(BUILD_TYPE)/jni)
WIN_DEBUG_DKLIB(${TIDY}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
WIN_RELEASE_DKLIB(${TIDY}/${OS}/${RELEASE_DIR}/tidy_static.lib)
APPLE_DEBUG_DKLIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidy.a)
APPLE_RELEASE_DKLIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidy.a)
LINUX_DEBUG_DKLIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidy.a)
LINUX_RELEASE_DKLIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidy.a)
RASPBERRY_DEBUG_DKLIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidy.a)
RASPBERRY_RELEASE_DKLIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidy.a)
ANDROID_DEBUG_DKLIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidy.a)
ANDROID_RELEASE_DKLIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidy.a)


### COMPILE ###
DKSETPATH(${TIDY}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE} ${TIDY})


WIN_VS(${TIDY_NAME} tidy.sln tidy-static)
MAC_XCODE(${TIDY_NAME} tidy-static)
IOS_XCODE(${TIDY_NAME} tidy-static)
IOSSIM_XCODE(${TIDY_NAME} tidy-static)
LINUX_DKQCOMMAND(make tidy-static)
RASPBERRY_DKQCOMMAND(make tidy-static)
ANDROID_VS(${TIDY_NAME} tidy.sln tidy-static)
