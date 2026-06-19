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


############ freetype ############
# https://www.freetype.org/
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz
# https://github.com/freetype/freetype.git


### DEPEND ###
dk_depend(zlib)

### IMPORT ###
dk_import() #PATCH

### LINK ###
dk_include			(${freetype}/include						FREETYPE_INCLUDE_DIR)
dk_include			(${freetype_Tuple_Dir}/include/freetype2	FREETYPE_INCLUDE_DIR2)
if(Windows AND MSVC)
	dk_libDebug		(${freetype_Debug_Dir}/freetype.lib			FREETYPE_LIBRARY_DEBUG		FREETYPE_LIBRARY)
	dk_libRelease	(${freetype_Release_Dir}/freetype.lib		FREETYPE_LIBRARY_RELEASE	FREETYPE_LIBRARY)
else()
	dk_libDebug		(${freetype_Debug_Dir}/libfreetype.a		FREETYPE_LIBRARY_DEBUG		FREETYPE_LIBRARY)
	dk_libRelease	(${freetype_Release_Dir}/libfreetype.a		FREETYPE_LIBRARY_RELEASE	FREETYPE_LIBRARY)
endif()



### 3RDPARTY LINK ###
dk_set(freetype_CMAKE
	-DFREETYPE_DIR=${freetype}
	-DFREETYPE_INCLUDE_DIR=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIRS=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE_INCLUDE_DIR2}
	-DFREETYPE_LIBRARY_DEBUG=${FREETYPE_LIBRARY_DEBUG}
	-DFREETYPE_LIBRARY_RELEASE=${FREETYPE_LIBRARY_RELEASE}
	-DFREETYPE_LIBRARY=${FREETYPE_LIBRARY})
	

	
### GENERATE ###
dk_configure()


### COMPILE ###
dk_build(${freetype} freetype)



# rmlui expects to find ftconfig.h here, so we just copy it for now.
dk_debug("Look at freetype/DKINSTALL.cmake:62")
if(EXISTS ${freetype_Debug_Dir}/include AND NOT EXISTS ${freetype}/${Target_Tuple}/include)
	dk_copy(${freetype_Debug_Dir}/include ${freetype}/${Target_Tuple}/include)
endif()
if(EXISTS ${freetype_Release_Dir}/include AND NOT EXISTS ${freetype}/${Target_Tuple}/include)
	dk_copy(${freetype_Release_Dir}/include ${freetype}/${Target_Tuple}/include)
endif()
