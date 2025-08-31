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


# https://www.freetype.org/
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz
# https://github.com/freetype/freetype.git
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

### DEPEND ###
dk_depend(zlib)


### IMPORT ###
#dk_import(${freetype_Import} PATCH)
dk_import()

### LINK ###
dk_include				(${FREETYPE}/include					FREETYPE_INCLUDE_DIR)
dk_include				(${FREETYPE_Config_Dir}/include/freetype2	FREETYPE_INCLUDE_DIR2)
if(MSVC)
	if(Windows)
		dk_libDebug		(${FREETYPE_Debug_Dir}/freetype.lib			FREETYPE_LIBRARY_DEBUG)
		dk_libRelease	(${FREETYPE_Release_Dir}/freetype.lib		FREETYPE_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${FREETYPE_Debug_Dir}/libfreetype.a		FREETYPE_LIBRARY_DEBUG)
	dk_libRelease		(${FREETYPE_Release_Dir}/libfreetype.a		FREETYPE_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
dk_append(FREETYPE_CMAKE
	-DFREETYPE_DIR=${FREETYPE}
	-DFREETYPE_INCLUDE_DIR=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIRS=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE_INCLUDE_DIR2}
	-DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_LIBRARY_DEBUG=${FREETYPE_LIBRARY_DEBUG}
	-DFREETYPE_LIBRARY_RELEASE=${FREETYPE_LIBRARY_RELEASE})
if(Debug)
	dk_append(FREETYPE_CMAKE
		-DFREETYPE_LIBRARY=${FREETYPE_LIBRARY_DEBUG})
elseif(Release)
	dk_append(FREETYPE_CMAKE
		-DFREETYPE_LIBRARY=${FREETYPE_LIBRARY_RELEASE})
endif()	
	
	

	
### GENERATE ###
dk_configure()


### COMPILE ###
dk_build(${FREETYPE} freetype)



# rmlui expects to find ftconfig.h here, so we just copy it for now.
dk_debug("Look at freetype/DKINSTALL.cmake:62")
if(EXISTS ${FREETYPE_Debug_Dir}/include AND NOT EXISTS ${FREETYPE}/${Target_Tuple}/include)
	dk_copy(${FREETYPE_Debug_Dir}/include ${FREETYPE}/${Target_Tuple}/include)
endif()
if(EXISTS ${FREETYPE_Release_Dir}/include AND NOT EXISTS ${FREETYPE}/${Target_Tuple}/include)
	dk_copy(${FREETYPE_Release_Dir}/include ${FREETYPE}/${Target_Tuple}/include)
endif()
