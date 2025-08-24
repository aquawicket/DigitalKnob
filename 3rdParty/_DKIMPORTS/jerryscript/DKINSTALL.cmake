#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Target_Config  "dk_Target_Config()")
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
	Android_dk_libDebug		(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-core.a)
	Android_dk_libRelease	(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-core.a)
else()
	Android_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-core.a)
	Android_dk_libRelease	(${JERRYSCRIPT.Release_Dir}/lib/libjerry-core.a)
endif()
Apple_dk_libDebug			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-core.a)
Apple_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-core.a)
Emscripten_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-core.a)
Emscripten_dk_libRelease	(${JERRYSCRIPT.Release_Dir}/lib/libjerry-core.a)
Linux_dk_libDebug			(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-core.a)
Linux_dk_libRelease			(${JERRYSCRIPT.Release_Dir}/lib/libjerry-core.a)
Raspberry_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-core.a)
Raspberry_dk_libRelease		(${JERRYSCRIPT.Release_Dir}/lib/libjerry-core.a)
Windows_dk_libDebug				(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/jerry-core.lib)
Windows_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/jerry-core.lib)

# jerry-ext
if(MSVC)
	Android_dk_libDebug		(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-ext.a)
	Android_dk_libRelease	(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-ext.a)
else()
	Android_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-ext.a)
	Android_dk_libRelease	(${JERRYSCRIPT.Release_Dir}/lib/libjerry-ext.a)
endif()
Apple_dk_libDebug			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-ext.a)
Apple_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-ext.a)
Emscripten_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-ext.a)
Emscripten_dk_libRelease	(${JERRYSCRIPT.Release_Dir}/lib/libjerry-ext.a)
Linux_dk_libDebug			(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-ext.a)
Linux_dk_libRelease			(${JERRYSCRIPT.Release_Dir}/lib/libjerry-ext.a)
Raspberry_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-ext.a)
Raspberry_dk_libRelease		(${JERRYSCRIPT.Release_Dir}/lib/libjerry-ext.a)
Windows_dk_libDebug				(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/jerry-ext.lib)
Windows_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/jerry-ext.lib)

# jerry-port
if(MSVC)
	Android_dk_libDebug		(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-port.a)
	Android_dk_libRelease	(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-port.a)
else()
	Android_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-port.a)
	Android_dk_libRelease	(${JERRYSCRIPT.Release_Dir}/lib/libjerry-port.a)
endif()
Apple_dk_libDebug			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/libjerry-port.a)
Apple_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/libjerry-port.a)
Emscripten_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-port.a)
Emscripten_dk_libRelease	(${JERRYSCRIPT.Release_Dir}/lib/libjerry-port.a)
Linux_dk_libDebug			(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-port.a)
Linux_dk_libRelease			(${JERRYSCRIPT.Release_Dir}/lib/libjerry-port.a)
Raspberry_dk_libDebug		(${JERRYSCRIPT.Debug_Dir}/lib/libjerry-port.a)
Raspberry_dk_libRelease		(${JERRYSCRIPT.Release_Dir}/lib/libjerry-port.a)
Windows_dk_libDebug				(${JERRYSCRIPT}/${Target_Tuple}/lib/${Debug_Dir}/jerry-port.lib)
Windows_dk_libRelease			(${JERRYSCRIPT}/${Target_Tuple}/lib/${Release_Dir}/jerry-port.lib)


### GENERATE ###
Android_dk_configure		(${JERRYSCRIPT})
Apple_dk_configure			(${JERRYSCRIPT})
Emscripten_dk_configure		(${JERRYSCRIPT} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
Linux_dk_configure			(${JERRYSCRIPT} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
Raspberry_dk_configure		(${JERRYSCRIPT} "-DCMAKE_CXX_FLAGS=-Werror=maybe-uninitialized")
Windows_dk_configure			(${JERRYSCRIPT})


### COMPILE ###
dk_build					(${JERRYSCRIPT} jerry)
