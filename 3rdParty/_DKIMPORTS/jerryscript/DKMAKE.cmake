# https://github.com/jerryscript-project/jerryscript.git
# https://jerryscript.net


### IMPORT ###
dk_import(https://github.com/jerryscript-project/jerryscript.git)


### LINK ###
dk_include				(${JERRYSCRIPT}/jerry-core/include)
dk_include				(${JERRYSCRIPT}/${OS})

# jerry-core
if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")	# replaces if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-core.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-core.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
endif()
APPLE_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-core.a)
APPLE_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-core.a)
EMSCRIPTEN_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
EMSCRIPTEN_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
LINUX_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
LINUX_dk_libRelease		(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
WIN_dk_libDebug			(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-core.lib)
WIN_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-core.lib)

# jerry-ext
if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")	# replaces if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-ext.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-ext.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
endif()
APPLE_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-ext.a)
APPLE_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-ext.a)
EMSCRIPTEN_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
EMSCRIPTEN_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
LINUX_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
LINUX_dk_libRelease		(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
WIN_dk_libDebug			(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-ext.lib)
WIN_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-ext.lib)

# jerry-port
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-port.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-port.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port.a)
endif()
APPLE_dk_libDebug		(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/libjerry-port.a)
APPLE_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/libjerry-port.a)
EMSCRIPTEN_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port.a)
EMSCRIPTEN_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port.a)
LINUX_dk_libDebug		(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port.a)
LINUX_dk_libRelease		(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libDebug	(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libRelease	(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port.a)
WIN_dk_libDebug			(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-port.lib)
WIN_dk_libRelease		(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-port.lib)


### GENERATE ###
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} ${JERRYSCRIPT})
APPLE_dk_queueCommand		(${DKCMAKE_BUILD} ${JERRYSCRIPT})
EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized" ${JERRYSCRIPT})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized" ${JERRYSCRIPT})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized" ${JERRYSCRIPT})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} ${JERRYSCRIPT})


### COMPILE ###
dk_build(${JERRYSCRIPT} jerry)
