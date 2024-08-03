include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.freetype.org/
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz
# https://github.com/freetype/freetype.git


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/freetype/freetype.git)
dk_import(https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz PATCH)



### LINK ###
dk_include				(${FREETYPE}/include								FREETYPE_INCLUDE_DIR)
dk_include				(${FREETYPE}/${OS}/include/freetype2				FREETYPE_INCLUDE_DIR2)
if(MSVC)
	WIN_dk_libDebug		(${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib		FREETYPE_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib		FREETYPE_LIBRARY_RELEASE)
else()
	dk_libDebug			(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a		FREETYPE_LIBRARY_DEBUG)
	dk_libRelease		(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a		FREETYPE_LIBRARY_RELEASE)
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
if(DEBUG)
	dk_append(FREETYPE_CMAKE -DFREETYPE_LIBRARY=${FREETYPE_LIBRARY_DEBUG})
elseif(RELEASE)
	dk_append(FREETYPE_CMAKE -DFREETYPE_LIBRARY=${FREETYPE_LIBRARY_RELEASE})
endif()	
	
	

	
### GENERATE ###
dk_configure(${FREETYPE})


### COMPILE ###
dk_build(${FREETYPE} freetype)



# rmlui expects to find ftconfig.h here, so we just copy it for now.
if(EXISTS ${FREETYPE}/${OS}/${DEBUG_DIR}/include AND NOT EXISTS ${FREETYPE}/${OS}/include)
	dk_copy(${FREETYPE}/${OS}/${DEBUG_DIR}/include ${FREETYPE}/${OS}/include)
endif()
if(EXISTS ${FREETYPE}/${OS}/${RELEASE_DIR}/include AND NOT EXISTS ${FREETYPE}/${OS}/include)
	dk_copy(${FREETYPE}/${OS}/${RELEASE_DIR}/include ${FREETYPE}/${OS}/include)
endif()
