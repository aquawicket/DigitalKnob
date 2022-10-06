# https://github.com/htacg/tidy-html5.git
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip


### IMPORT 
dk_import(https://github.com/htacg/tidy-html5.git)


### LINK ###
dk_include				(${TIDY-HTML5})
dk_include				(${TIDY-HTML5}/include)
dk_include				(${TIDY-HTML5}/${OS})
ANDROID_dk_include		(${TIDY-HTML5}/${OS}/$(BUILD_TYPE)/jni)
WIN_dk_libDebug			(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
WIN_dk_libRelease		(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/tidy_static.lib)
APPLE_dk_libDebug		(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
APPLE_dk_libRelease		(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
LINUX_dk_libDebug		(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
LINUX_dk_libRelease		(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
RASPBERRY_dk_libDebug	(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
RASPBERRY_dk_libRelease	(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
ANDROID_dk_libDebug		(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
ANDROID_dk_libRelease	(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)


### GENERATE ###
dk_setPath		(${TIDY-HTML5}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE} ${TIDY-HTML5})


### COMPILE ###
dk_visualStudio	(${TIDY-HTML5_NAME} tidy-static) # windows, android
dk_xcode		(${TIDY-HTML5_NAME} tidy-static) # mac, ios, iossim
dk_make			(${TIDY-HTML5_NAME} tidy-static) # linux, raspberry
