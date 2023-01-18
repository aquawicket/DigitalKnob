# https://www.freetype.org/
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz
# https://github.com/freetype/freetype.git


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
dk_import	(https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz PATCH)
#dk_import	(https://github.com/freetype/freetype.git)


### LINK ###
dk_include			(${FREETYPE}/include)
dk_include			(${FREETYPE}/${OS}/include/freetype2)
UNIX_dk_libDebug	(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
UNIX_dk_libRelease	(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
WIN_dk_libDebug		(${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib)
WIN_dk_libRelease	(${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib)


### 3RDPARTY LINK ###
UNIX_dk_set	(FREETYPE_CMAKE -DFREETYPE_DIR=${FREETYPE} -DFREETYPE_INCLUDE_DIR=${FREETYPE}/include -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a -DFREETYPE_LIBRARY=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
WIN_dk_set	(FREETYPE_CMAKE -DFREETYPE_DIR=${FREETYPE} -DFREETYPE_INCLUDE_DIR=${FREETYPE}/include -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib)

	
### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${FREETYPE})


### COMPILE ###
dk_build(${FREETYPE} freetype)
