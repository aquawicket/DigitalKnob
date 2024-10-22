#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/jasper-software/jasper.git


### IMPORT ###
#dk_import(https://github.com/jasper-software/jasper.git)
dk_import(https://github.com/jasper-software/jasper/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${JASPER}/include)
dk_include				(${JASPER}/${triple})
ANDROID_dk_libDebug		(${JASPER}/${triple}/src/libjasper/jasperd.a)
ANDROID_dk_libRelease	(${JASPER}/${triple}/src/libjasper/jasper.a)
APPLE_dk_libDebug		(${JASPER}/${triple}/src/libjasper/libjasper.a)
APPLE_dk_libRelease		(${JASPER}/${triple}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libDebug	(${JASPER}/${triple}/${DEBUG_DIR}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libRelease(${JASPER_RELEASE_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libDebug		(${JASPER}/${triple}/${DEBUG_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libRelease		(${JASPER_RELEASE_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libDebug	(${JASPER}/${triple}/${DEBUG_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libRelease	(${JASPER_RELEASE_DIR}/src/libjasper/libjasper.a)
WIN_dk_libDebug			(${JASPER}/${triple}/src/libjasper/jasperd.lib)
WIN_dk_libRelease		(${JASPER}/${triple}/src/libjasper/jasper.lib)


### GENERATE ###
dk_configure(${JASPER_DIR})


### COMPILE ###
dk_build(${JASPER_DIR})
