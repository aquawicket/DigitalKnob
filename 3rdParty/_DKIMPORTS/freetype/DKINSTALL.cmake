#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


# https://www.freetype.org/
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz
# https://github.com/freetype/freetype.git


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/freetype/freetype.git)
dk_import(https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz PATCH)



### LINK ###
dk_include				(${FREETYPE_DIR}/include					FREETYPE_INCLUDE_DIR)
dk_include				(${FREETYPE_CONFIG_DIR}/include/freetype2	FREETYPE_INCLUDE_DIR2)
if(MSVC)
	if(Windows)
		dk_libDebug		(${FREETYPE_DEBUG_DIR}/freetype.lib			FREETYPE_LIBRARY_DEBUG)
		dk_libRelease	(${FREETYPE_RELEASE_DIR}/freetype.lib		FREETYPE_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${FREETYPE_DEBUG_DIR}/libfreetype.a		FREETYPE_LIBRARY_DEBUG)
	dk_libRelease		(${FREETYPE_RELEASE_DIR}/libfreetype.a		FREETYPE_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
dk_append(FREETYPE_CMAKE
	-DFREETYPE_DIR=${FREETYPE_DIR}
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
dk_configure(${FREETYPE})


### COMPILE ###
dk_build(${FREETYPE} freetype)



# rmlui expects to find ftconfig.h here, so we just copy it for now.
dk_debug("Look at freetype/DKINSTALL.cmake:62")
if(EXISTS ${FREETYPE_DEBUG_DIR}/include AND NOT EXISTS ${FREETYPE_DIR}/${Target_Tuple}/include)
	dk_copy(${FREETYPE_DEBUG_DIR}/include ${FREETYPE_DIR}/${Target_Tuple}/include)
endif()
if(EXISTS ${FREETYPE_RELEASE_DIR}/include AND NOT EXISTS ${FREETYPE_DIR}/${Target_Tuple}/include)
	dk_copy(${FREETYPE_RELEASE_DIR}/include ${FREETYPE_DIR}/${Target_Tuple}/include)
endif()
