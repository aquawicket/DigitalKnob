# https://github.com/htacg/tidy-html5
#
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip


#dk_set(TIDY-HTML5_DL https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip)
#dk_set(TIDY-HTML5_VERSION 5.8.0)
#dk_set(TIDY-HTML5_NAME tidy_html5_${TIDY-HTML5_VERSION})
#dk_set(TIDY-HTML5 ${3RDPARTY}/${TIDY-HTML5_NAME})
#dk_import(${TIDY-HTML5_DL} ${TIDY-HTML5})
dk_import(https://github.com/htacg/tidy-html5.git)


### LINK ###
dk_include(${TIDY-HTML5})
dk_include(${TIDY-HTML5}/include)
dk_include(${TIDY-HTML5}/${OS})
ANDROID_dk_include(${TIDY-HTML5}/${OS}/$(BUILD_TYPE)/jni)
WIN_dk_libDebug(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
WIN_dk_libRelease(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/tidy_static.lib)
APPLE_dk_libDebug(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
APPLE_dk_libRelease(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
LINUX_dk_libDebug(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
LINUX_dk_libRelease(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
RASPBERRY_dk_libDebug(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
RASPBERRY_dk_libRelease(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
ANDROID_dk_libDebug(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
ANDROID_dk_libRelease(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)


### GENERATE ###
dk_setPath(${TIDY-HTML5}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE} ${TIDY-HTML5})


### COMPILE ###
dk_visualStudio(${TIDY-HTML5_NAME} tidy.sln tidy-static)
#WIN_dk_visualStudio(${TIDY-HTML5_NAME} tidy.sln tidy-static)
dk_xcode(${TIDY-HTML5_NAME} tidy-static)
#MAC_dk_xcode(${TIDY-HTML5_NAME} tidy-static)
#IOS_dk_xcode(${TIDY-HTML5_NAME} tidy-static)
#IOSSIM_dk_xcode(${TIDY-HTML5_NAME} tidy-static)
LINUX_dk_queueCommand(make tidy-static)
RASPBERRY_dk_queueCommand(make tidy-static)
#ANDROID_dk_visualStudio(${TIDY-HTML5_NAME} tidy.sln tidy-static)
