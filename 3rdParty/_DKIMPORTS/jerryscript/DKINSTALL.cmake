#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/jerryscript-project/jerryscript.git
# https://jerryscript.net


### IMPORT ###
#dk_import(https://github.com/jerryscript-project/jerryscript.git)
dk_import(https://github.com/jerryscript-project/jerryscript/archive/refs/heads/master.zip)


### LINK ###
dk_include					(${JERRYSCRIPT}/jerry-core/include)
dk_include					(${JERRYSCRIPT}/${Target_Tuple})

# jerry-core
if(MSVC)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-core.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-core.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-core.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
endif()
APPLE_dk_libDebug			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-core.a)
APPLE_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-core.a)
EMSCRIPTEN_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-core.a)
EMSCRIPTEN_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
LINUX_dk_libDebug			(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-core.a)
LINUX_dk_libRelease			(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libRelease		(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-core.a)
Windows_dk_libDebug				(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/jerry-core.lib)
Windows_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/jerry-core.lib)

# jerry-ext
if(MSVC)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-ext.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-ext.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-ext.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
endif()
APPLE_dk_libDebug			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-ext.a)
APPLE_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-ext.a)
EMSCRIPTEN_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-ext.a)
EMSCRIPTEN_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
LINUX_dk_libDebug			(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-ext.a)
LINUX_dk_libRelease			(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libRelease		(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-ext.a)
Windows_dk_libDebug				(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/jerry-ext.lib)
Windows_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/jerry-ext.lib)

# jerry-port
if(MSVC)
	ANDROID_dk_libDebug		(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-port.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-port.a)
else()
	ANDROID_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-port.a)
	ANDROID_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
endif()
APPLE_dk_libDebug			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-port.a)
APPLE_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-port.a)
EMSCRIPTEN_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-port.a)
EMSCRIPTEN_dk_libRelease	(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
LINUX_dk_libDebug			(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-port.a)
LINUX_dk_libRelease			(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libDebug		(${JERRYSCRIPT_DEBUG_DIR}/lib/libjerry-port.a)
RASPBERRY_dk_libRelease		(${JERRYSCRIPT_RELEASE_DIR}/lib/libjerry-port.a)
Windows_dk_libDebug				(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/jerry-port.lib)
Windows_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/jerry-port.lib)


### GENERATE ###
ANDROID_dk_configure		(${JERRYSCRIPT_DIR})
Apple_dk_configure			(${JERRYSCRIPT_DIR})
EMSCRIPTEN_dk_configure		(${JERRYSCRIPT_DIR} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
LINUX_dk_configure			(${JERRYSCRIPT_DIR} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
RASPBERRY_dk_configure		(${JERRYSCRIPT_DIR} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
Windows_dk_configure			(${JERRYSCRIPT_DIR})


### COMPILE ###
dk_build					(${JERRYSCRIPT_DIR} jerry)
