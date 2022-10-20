# https://github.com/jerryscript-project/jerryscript.git
# https://jerryscript.net


### IMPORT ###
dk_import(https://github.com/jerryscript-project/jerryscript.git)


### LINK ###
dk_include				(${JERRYSCRIPT}/jerry-core/include)
dk_include				(${JERRYSCRIPT}/${OS})

# jerry-core
WIN_dk_libDebug			(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-core.lib)
WIN_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-core.lib)
APPLE_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-core.a)
APPLE_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-core.a)
LINUX_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
LINUX_dk_libRelease		(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-core.a)
ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-core.a)

# jerry-ext
WIN_dk_libDebug			(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-ext.lib)
WIN_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-ext.lib)
APPLE_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-ext.a)
APPLE_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-ext.a)
LINUX_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
LINUX_dk_libRelease		(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-ext.a)
ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-ext.a)

# jerry-port
WIN_dk_libDebug			(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-port.lib)
WIN_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-port.lib)
APPLE_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-port.a)
APPLE_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-port.a)
LINUX_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port.a)
LINUX_dk_libRelease		(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port.a)
ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-port.a)
ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-port.a)


### GENERATE ###
dk_setPath					(${JERRYSCRIPT}/${BUILD_DIR})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} ${JERRYSCRIPT})
APPLE_dk_queueCommand		(${DKCMAKE_BUILD} ${JERRYSCRIPT})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized" ${JERRYSCRIPT})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized" ${JERRYSCRIPT})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} ${JERRYSCRIPT})


### COMPILE ###
dk_visualStudio	(${JERRYSCRIPT_NAME} jerry) # windows, android
dk_xcode		(${JERRYSCRIPT_NAME} jerry) # mac, ios, iossim
dk_make			(${JERRYSCRIPT_NAME} jerry) # linux, raspberry
