#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_validate(Target_Tuple "dk_Target_Tuple()")
# https://github.com/jasper-software/jasper.git


### IMPORT ###
#dk_import(https://github.com/jasper-software/jasper.git)
dk_import(https://github.com/jasper-software/jasper/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${JASPER}/include)
dk_include				(${JASPER}/${Target_Tuple})
ANDROID_dk_libDebug		(${JASPER}/${Target_Tuple}/src/libjasper/jasperd.a)
ANDROID_dk_libRelease	(${JASPER}/${Target_Tuple}/src/libjasper/jasper.a)
APPLE_dk_libDebug		(${JASPER}/${Target_Tuple}/src/libjasper/libjasper.a)
APPLE_dk_libRelease		(${JASPER}/${Target_Tuple}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libDebug	(${JASPER_DEBUG_DIR}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libRelease(${JASPER_RELEASE_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libDebug		(${JASPER_DEBUG_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libRelease		(${JASPER_RELEASE_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libDebug	(${JASPER_DEBUG_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libRelease	(${JASPER_RELEASE_DIR}/src/libjasper/libjasper.a)
WIN_dk_libDebug			(${JASPER}/${Target_Tuple}/src/libjasper/jasperd.lib)
WIN_dk_libRelease		(${JASPER}/${Target_Tuple}/src/libjasper/jasper.lib)


### GENERATE ###
dk_configure(${JASPER_DIR})


### COMPILE ###
dk_build(${JASPER_DIR})
