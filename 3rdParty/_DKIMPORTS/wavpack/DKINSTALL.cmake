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


############ wavpack ############
# https://github.com/dbry/WavPack/archive/d9c4a35e822bb274b8c94fc95ff16c5b4c04d346.zip
# https://github.com/dbry/WavPack/archive/2fbee4eb2b6f2f4674958e2a577df86ec5027556.zip

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
