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


############ jpeg ############
# http://www.ijg.org/
# https://www.ijg.org/files/jpegsr9d.zip
#
dk_validate(Target_Config  "dk_Target_Config()")



### IMPORT ###
dk_import(https://www.ijg.org/files/jpegsr9d.zip)


### LINK ###
dk_include			(${JPEG}										JPEG_INCLUDE_DIR)
dk_include			(${JPEG}/${Target_Tuple}									JPEG_INCLUDE_DIR2)
dk_include			(${JPEG.Release_Dir})
Android_dk_include	(${JPEG}/${Target_Tuple}/${Target_Type}/jni)
Unix_dk_libDebug	(${JPEG.Debug_Dir}/libjpeg-static.a	JPEG_LIBRARY_DEBUG)
Unix_dk_libRelease	(${JPEG.Release_Dir}/libjpeg-static.a	JPEG_LIBRARY_RELEASE)
Windows_dk_libDebug		(${JPEG.Debug_Dir}/jpeg-static.lib		JPEG_LIBRARY_DEBUG)
Windows_dk_libRelease	(${JPEG.Release_Dir}/jpeg-static.lib	JPEG_LIBRARY_RELEASE)


### 3RDPARTY LINK ###
Android_dk_set		(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} -DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2} -DJPEG_LIBRARY_DEBUG=${JPEG_LIBRARY_DEBUG} -DJPEG_LIBRARY_RELEASE=${JPEG_LIBRARY_RELEASE})
Apple_dk_set		(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} -DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2} -DJPEG_LIBRARY=${JPEG_LIBRARY_RELEASE})
Emscripten_dk_set	(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} -DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2} -DJPEG_LIBRARY=${JPEG_LIBRARY_RELEASE})
Linux_dk_set		(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} -DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2} -DJPEG_LIBRARY=${JPEG_LIBRARY_RELEASE})
Raspberry_dk_set	(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} -DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2} -DJPEG_LIBRARY=${JPEG_LIBRARY_RELEASE})
Windows_dk_set			(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} -DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2} -DJPEG_LIBRARY_DEBUG=${JPEG_LIBRARY_DEBUG} -DJPEG_LIBRARY_RELEASE=${JPEG_LIBRARY_RELEASE})


### GENERATE ###
dk_configure		(${JPEG})


### COMPILE ###
dk_build			(${JPEG} jpeg-static)
