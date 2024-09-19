include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://www.freetype.org/
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz
# https://github.com/freetype/freetype.git


### DEPEND ###


### IMPORT ###
#dk_import(https://github.com/freetype/freetype.git)
dk_import(https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz)



### LINK ###
dk_include				(${FREETYPE_DIR}/include					FREETYPE_INCLUDE_DIR)
dk_include				(${FREETYPE_CONFIG_DIR}/include/freetype2	DFREETYPE_INCLUDE_DIR_freetype2)

if(MSVC)
	WIN_dk_libDebug		(${FREETYPE_DEBUG_DIR}/freetype.lib			FREETYPE_DEBUG_LIBRARY)
	WIN_dk_libRelease	(${FREETYPE_RELEASE_DIR}/freetype.lib		FREETYPE_RELEASE_LIBRARY)
else()
	dk_libDebug			(${FREETYPE_DEBUG_DIR}/libfreetype.a		FREETYPE_DEBUG_LIBRARY)
	dk_libRelease		(${FREETYPE_RELEASE_DIR}/libfreetype.a		FREETYPE_RELEASE_LIBRARY)
endif()
dk_set					(DFREETYPE_INCLUDE_DIR_ft2build				${FREETYPE_INCLUDE_DIR})
DEBUG_dk_set			(FREETYPE_LIBRARY							${FREETYPE_DEBUG_LIBRARY})
RELEASE_dk_set			(FREETYPE_LIBRARY							${FREETYPE_RELEASE_LIBRARY})


### 3RDPARTY LINK ###
dk_append(FREETYPE_CMAKE
	-DFREETYPE_DIR=${FREETYPE_DIR}
	-DFREETYPE_INCLUDE_DIR=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIRS=${FREETYPE_INCLUDE_DIR}
	-DFREETYPE_INCLUDE_DIR_freetype2=${DFREETYPE_INCLUDE_DIR_freetype2}
	-DFREETYPE_INCLUDE_DIR_ft2build=${DFREETYPE_INCLUDE_DIR_ft2build}
	-DFREETYPE_LIBRARY=${FREETYPE_LIBRARY}
	-DFREETYPE_LIBRARY_DEBUG=${FREETYPE_DEBUG_LIBRARY}
	-DFREETYPE_LIBRARY_RELEASE=${FREETYPE_RELEASE_LIBRARY})

	
	

	
### GENERATE ###
dk_configure(${FREETYPE_DIR})


### COMPILE ###
dk_build(${FREETYPE_DIR} freetype)



# rmlui expects to find ftconfig.h here, so we just copy it for now.
#dk_fixme("freetype/DKMAKE.cmake:62")
#if(EXISTS ${FREETYPE_DEBUG_DIR}/include AND NOT EXISTS ${FREETYPE_DIR}/${triple}/include)
#	dk_copy(${FREETYPE_DEBUG_DIR}/include ${FREETYPE_DIR}/${triple}/include)
#endif()
#if(EXISTS ${FREETYPE_RELEASE_DIR}/include AND NOT EXISTS ${FREETYPE_DIR}/${triple}/include)
#	dk_copy(${FREETYPE_RELEASE_DIR}/include ${FREETYPE_DIR}/${triple}/include)
#endif()
