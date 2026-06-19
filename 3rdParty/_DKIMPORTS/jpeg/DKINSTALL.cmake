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


############ jpeg ############
# http://www.ijg.org/
# https://www.ijg.org/files/jpegsr9d.zip

dk_import()

dk_include			(${jpeg}										JPEG_INCLUDE_DIR)
dk_include			(${jpeg_Tuple_Dir}								JPEG_INCLUDE_DIR2)
dk_include			(${jpeg_Release_Dir})
if(Android)
	dk_include		(${jpeg_Tuple_Dir}/${Target_Type}/jni)
elseif(Unix)
	dk_libDebug		(${jpeg_Debug_Dir}/libjpeg-static.a				JPEG_LIBRARY_DEBUG 		JPEG_LIBRARY)
	dk_libRelease	(${jpeg_Release_Dir}/libjpeg-static.a			JPEG_LIBRARY_RELEASE	JPEG_LIBRARY)
elseif(Windows)
	dk_libDebug		(${jpeg_Debug_Dir}/jpeg-static.lib				JPEG_LIBRARY_DEBUG		JPEG_LIBRARY)
	dk_libRelease	(${jpeg_Release_Dir}/jpeg-static.lib			JPEG_LIBRARY_RELEASE	JPEG_LIBRARY)
endif()


dk_set(jpeg_CMAKE 
	-DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR}
	-DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2}
	-DJPEG_LIBRARY_DEBUG=${JPEG_LIBRARY_DEBUG}
	-DJPEG_LIBRARY_RELEASE=${JPEG_LIBRARY_RELEASE})


dk_configure()

dk_build(${jpeg} jpeg-static)
