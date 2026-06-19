#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ jasper ############
# https://github.com/jasper-software/jasper.git
# https://github.com/jasper-software/jasper/archive/refs/heads/master.zip

dk_import()

dk_include			(${jasper}/include)
dk_include			(${jasper_Tuple_Dir})
if(Android)
	dk_libDebug		(${jasper_Tuple_Dir}/src/libjasper/jasperd.a)	
	dk_libRelease	(${jasper_Tuple_Dir}/src/libjasper/jasper.a)
elseif(Apple)
	dk_libDebug		(${jasper_Tuple_Dir}/src/libjasper/libjasper.a)
	dk_libRelease	(${jasper_Tuple_Dir}/src/libjasper/libjasper.a)
elseif(Emscripten)
	dk_libDebug		(${jasper_Debug_Dir}/src/libjasper/libjasper.a)
	dk_libRelease	(${jasper_Release_Dir}/src/libjasper/libjasper.a)
elseif(Linux)
	dk_libDebug		(${jasper_Debug_Dir}/src/libjasper/libjasper.a)
	dk_libRelease	(${jasper_Release_Dir}/src/libjasper/libjasper.a)
elseif(Raspberry)
	dk_libDebug		(${jasper_Debug_Dir}/src/libjasper/libjasper.a)
	dk_libRelease	(${jasper_Release_Dir}/src/libjasper/libjasper.a)
elseif(Windows)
	dk_libDebug		(${jasper_Tuple_Dir}/src/libjasper/jasperd.lib)
	dk_libRelease	(${jasper_Tuple_Dir}/src/libjasper/jasper.lib)
endif()

dk_configure()

dk_build()
