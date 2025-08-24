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


dk_validate(Target_Tuple "dk_Target_Tuple()")
# https://github.com/jasper-software/jasper.git


### IMPORT ###
#dk_import(https://github.com/jasper-software/jasper.git)
dk_import(https://github.com/jasper-software/jasper/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${JASPER}/include)
dk_include				(${JASPER}/${Target_Tuple})
Android_dk_libDebug		(${JASPER}/${Target_Tuple}/src/libjasper/jasperd.a)
Android_dk_libRelease	(${JASPER}/${Target_Tuple}/src/libjasper/jasper.a)
Apple_dk_libDebug		(${JASPER}/${Target_Tuple}/src/libjasper/libjasper.a)
Apple_dk_libRelease		(${JASPER}/${Target_Tuple}/src/libjasper/libjasper.a)
Emscripten_dk_libDebug	(${JASPER.Debug_Dir}/src/libjasper/libjasper.a)
Emscripten_dk_libRelease(${JASPER.Release_Dir}/src/libjasper/libjasper.a)
Linux_dk_libDebug		(${JASPER.Debug_Dir}/src/libjasper/libjasper.a)
Linux_dk_libRelease		(${JASPER.Release_Dir}/src/libjasper/libjasper.a)
Raspberry_dk_libDebug	(${JASPER.Debug_Dir}/src/libjasper/libjasper.a)
Raspberry_dk_libRelease	(${JASPER.Release_Dir}/src/libjasper/libjasper.a)
Windows_dk_libDebug			(${JASPER}/${Target_Tuple}/src/libjasper/jasperd.lib)
Windows_dk_libRelease		(${JASPER}/${Target_Tuple}/src/libjasper/jasper.lib)


### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()
