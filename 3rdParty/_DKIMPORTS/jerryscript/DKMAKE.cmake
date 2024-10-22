#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/jerryscript-project/jerryscript.git
# https://jerryscript.net


### IMPORT ###
#dk_import(https://github.com/jerryscript-project/jerryscript.git)
dk_import(https://github.com/jerryscript-project/jerryscript/archive/refs/heads/master.zip)


### LINK ###
dk_include					(${JERRYSCRIPT}/jerry-core/include)
dk_include					(${JERRYSCRIPT}/${triple})

# jerry-core
if(MSVC)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/libjerry-core.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/libjerry-core.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-core.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
endif()
APPLE_dk_libDebug			(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/libjerry-core.a)
APPLE_dk_libRelease			(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/libjerry-core.a)
EMSCRIPTEN_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-core.a)
EMSCRIPTEN_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
LINUX_dk_libDebug			(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-core.a)
LINUX_dk_libRelease			(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libRelease		(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
WIN_dk_libDebug				(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/jerry-core.lib)
WIN_dk_libRelease			(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/jerry-core.lib)

# jerry-ext
if(MSVC)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/libjerry-ext.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/libjerry-ext.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-ext.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
endif()
APPLE_dk_libDebug			(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/libjerry-ext.a)
APPLE_dk_libRelease			(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/libjerry-ext.a)
EMSCRIPTEN_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-ext.a)
EMSCRIPTEN_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
LINUX_dk_libDebug			(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-ext.a)
LINUX_dk_libRelease			(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libRelease		(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
WIN_dk_libDebug				(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/jerry-ext.lib)
WIN_dk_libRelease			(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/jerry-ext.lib)

# jerry-port
if(MSVC)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/libjerry-port.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/libjerry-port.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-port.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
endif()
APPLE_dk_libDebug			(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/libjerry-port.a)
APPLE_dk_libRelease			(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/libjerry-port.a)
EMSCRIPTEN_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-port.a)
EMSCRIPTEN_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
LINUX_dk_libDebug			(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-port.a)
LINUX_dk_libRelease			(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libDebug		(${JERRYSCRIPT}/${triple}/${DEBUG_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libRelease		(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
WIN_dk_libDebug				(${JERRYSCRIPT}/${triple}/lib/${DEBUG_DIR}/jerry-port.lib)
WIN_dk_libRelease			(${JERRYSCRIPT}/${triple}/lib/${RELEASE_DIR}/jerry-port.lib)


### GENERATE ###
ANDROID_dk_configure		(${JERRYSCRIPT_DIR})
APPLE_dk_configure			(${JERRYSCRIPT_DIR})
EMSCRIPTEN_dk_configure		(${JERRYSCRIPT_DIR} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
LINUX_dk_configure			(${JERRYSCRIPT_DIR} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
RASPBERRY_dk_configure		(${JERRYSCRIPT_DIR} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
WIN_dk_configure			(${JERRYSCRIPT_DIR})


### COMPILE ###
dk_build					(${JERRYSCRIPT_DIR} jerry)
