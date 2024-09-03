include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/sammycage/lunasvg.git

#dk_import(https://github.com/sammycage/lunasvg.git)
#dk_import(https://github.com/sammycage/lunasvg/archive/refs/heads/master.zip)
dk_import(https://github.com/sammycage/lunasvg/archive/refs/tags/v2.4.1.zip)

dk_include		(${LUNASVG}/include								    LUNASVG_INCLUDE_DIR)
dk_libDebug		(${LUNASVG}/${triple}/${DEBUG_DIR}/liblunasvg.a		LUNASVG_LIBRARY_DEBUG)
dk_libRelease	(${LUNASVG}/${triple}/${RELEASE_DIR}/liblunasvg.a	LUNASVG_LIBRARY_RELEASE)


### 3RDPARTY LINK ###
dk_set			(LUNASVG_CMAKE -DLUNASVG_DIR=${LUNASVG} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_DEBUG} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_RELEASE})
DEBUG_dk_set	(LUNASVG_CMAKE -DLUNASVG_DIR=${LUNASVG} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_DEBUG} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_DEBUG})
RELEASE_dk_set	(LUNASVG_CMAKE -DLUNASVG_DIR=${LUNASVG} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_RELEASE} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_RELEASE})

dk_configure(${LUNASVG})

dk_build(${LUNASVG})