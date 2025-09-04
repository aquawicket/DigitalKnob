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
dk_include				(${freetype}/include						FREETYPE_INCLUDE_DIR)
dk_include				(${freetype_Config_Dir}/include/freetype2	FREETYPE_INCLUDE_DIR2)
if(MSVC)
	if(Windows)
		dk_libDebug		(${freetype_Debug_Dir}/freetype.lib			FREETYPE_LIBRARY_DEBUG)
		dk_libRelease	(${freetype_Release_Dir}/freetype.lib		FREETYPE_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${freetype_Debug_Dir}/libfreetype.a		FREETYPE_LIBRARY_DEBUG)
	dk_libRelease		(${freetype_Release_Dir}/libfreetype.a		FREETYPE_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
dk_append(freetype_CMAKE
	-Dfreetype_DIR=${freetype}
	-Dfreetype_INCLUDE_DIR=${freetype_INCLUDE_DIR}
	-Dfreetype_INCLUDE_DIRS=${freetype_INCLUDE_DIR}
	-Dfreetype_INCLUDE_DIR_freetype2=${freetype_INCLUDE_DIR2}
	-Dfreetype_INCLUDE_DIR_ft2build=${freetype_INCLUDE_DIR}
	-Dfreetype_LIBRARY_DEBUG=${freetype_LIBRARY_DEBUG}
	-Dfreetype_LIBRARY_RELEASE=${freetype_LIBRARY_RELEASE})
if(Debug)
	dk_append(freetype_CMAKE
		-Dfreetype_LIBRARY=${FREETYPE_LIBRARY_DEBUG})
elseif(Release)
	dk_append(freetype_CMAKE
		-DFREETYPE_LIBRARY=${FREETYPE_LIBRARY_RELEASE})
endif()	
	
	

	
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
