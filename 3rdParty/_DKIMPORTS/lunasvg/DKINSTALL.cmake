#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/sammycage/lunasvg.git

#dk_import(https://github.com/sammycage/lunasvg.git)
#dk_import(https://github.com/sammycage/lunasvg/archive/refs/heads/master.zip)
dk_import(https://github.com/sammycage/lunasvg/archive/refs/tags/v2.4.1.zip)

dk_include			(${LUNASVG_DIR}/include					LUNASVG_INCLUDE_DIR)

if(MSVC)
	dk_libDebug		(${LUNASVG_DEBUG_DIR}/lunasvg.lib		LUNASVG_LIBRARY_DEBUG)
	dk_libRelease	(${LUNASVG_RELEASE_DIR}/liblunasvg.lib	LUNASVG_LIBRARY_RELEASE)
else()
	dk_libDebug		(${LUNASVG_DEBUG_DIR}/liblunasvg.a		LUNASVG_LIBRARY_DEBUG)
	dk_libRelease	(${LUNASVG_RELEASE_DIR}/liblunasvg.a	LUNASVG_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
dk_set		(LUNASVG_CMAKE -DLUNASVG_DIR=${LUNASVG_DIR} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_DEBUG} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_RELEASE})
if(Debug)
	dk_set	(LUNASVG_CMAKE -DLUNASVG_DIR=${LUNASVG_DIR} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_DEBUG} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_DEBUG})
endif()
if(Release)
	dk_set	(LUNASVG_CMAKE -DLUNASVG_DIR=${LUNASVG_DIR} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_RELEASE} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_RELEASE})
endif()

dk_configure(${LUNASVG})

dk_build(${LUNASVG})