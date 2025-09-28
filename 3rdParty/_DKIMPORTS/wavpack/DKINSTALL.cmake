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


############ wavpack ############
# https://github.com/dbry/WavPack/archive/d9c4a35.zip
# https://github.com/dbry/WavPack/archive/2fbee4e.zip

dk_import()

### LINK ###
dk_include			(${WAVPACK}/include						WAVPACK_INCLUDE_DIR)
dk_validate			(Target_Tuple "dk_Target_Tuple()")
if(Windows AND MSVC)
	dk_libDebug		(${WAVPACK_Debug_Dir}/wavpack.lib		WAVPACK_LIBRARY_DEBUG)
	dk_libRelease	(${WAVPACK_Release_Dir}/wavpack.lib		WAVPACK_LIBRARY_RELEASE)
else()
	dk_libDebug		(${WAVPACK_Debug_Dir}/libwavpack.a		WAVPACK_LIBRARY_DEBUG)
	dk_libRelease	(${WAVPACK_Release_Dir}/libwavpack.a	WAVPACK_LIBRARY_RELEASE)
endif()
set(wavpack_INCLUDE_PATH ${WAVPACK_INCLUDE_DIR})
if(Debug)
	set(wavpack_LIBRARY	${WAVPACK_LIBRARY_DEBUG})
elseif(Release)
	set(wavpack_LIBRARY	${WAVPACK_LIBRARY_RELEASE})
endif()



### 3rd Party Link ###
dk_set(wavpack_CMAKE
	-Dwavpack_INCLUDE_PATH=${wavpack_INCLUDE_PATH}
	-Dwavpack_LIBRARY=${wavpack_LIBRARY}
)
	
	
	
### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()
