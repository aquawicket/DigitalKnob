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


############ opus ############
# https://github.com/xiph/opus.git
# https://github.com/xiph/opus/archive/7db26934.zip

dk_import()

### LINK ###
dk_include			(${OPUS}/include					OpusFile_INCLUDE_PATH)
dk_include			(${OPUS}/${Target_Tuple})
if(MSVC)
	dk_libDebug		(${OPUS_Debug_Dir}/opus.lib			OpusFile_LIBRARY_DEBUG)
	dk_libRelease	(${OPUS_Release_Dir}/opus.lib		OpusFile_LIBRARY_RELEASE)
else()
	dk_libDebug		(${OPUS_Debug_Dir}/libopus.a		OpusFile_LIBRARY_DEBUG)
	dk_libRelease	(${OPUS_Release_Dir}/libopus.a		OpusFile_LIBRARY_RELEASE)
endif()
if(Debug)
	dk_set(OpusFile_LIBRARY ${OpusFile_LIBRARY_DEBUG})
endif()
if(Release)
	dk_set(OpusFile_LIBRARY ${OpusFile_LIBRARY_RELEASE})
endif()

dk_set(opus_CMAKE -DOpusFile_INCLUDE_PATH=${OpusFile_INCLUDE_PATH}  -DOpusFile_LIBRARY=${OpusFile_LIBRARY}) 


### GENERATE ###
dk_configure()

### COMPILE ###
dk_build()
