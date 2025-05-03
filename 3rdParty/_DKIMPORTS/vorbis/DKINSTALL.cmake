#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ vorbis ############
# https://github.com/xiph/vorbis
# https://ftp.osuosl.org/pub/xiph/releases/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip
dk_load(dk_builder)

### DEPEND ###
dk_depend(libgcc)
dk_validate(MSYS2 "dk_depend(msys2)")
dk_depend(ogg)

### IMPORT ###
#dk_import(https://github.com/xiph/vorbis.git)
dk_getFileParams("$ENV{DKIMPORTS_DIR}/vorbis/dkconfig.txt")
dk_import("${VORBIS_DL}")

### LINK ###
dk_include				(${VORBIS_DIR}/include										VORBIS_INCLUDE_DIR)

if(MULTI_CONFIG)
	if(WIN AND MSVC)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/vorbis.lib			VORBIS_DEBUG_LIB)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/vorbisenc.lib		VORBISENC_DEBUG_LIB)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/vorbisfile.lib		VORBISFILE_DEBUG_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/vorbis.lib			VORBIS_RELEASE_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/vorbisenc.lib		VORBISENC_RELEASE_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/vorbisfile.lib		VORBISFILE_RELEASE_LIB)
	else()
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbis.a			VORBIS_DEBUG_LIB)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbisenc.a		VORBISENC_DEBUG_LIB)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbisfile.a		VORBISFILE_DEBUG_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbis.a		VORBIS_RELEASE_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbisenc.a		VORBISENC_RELEASE_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbisfile.a	VORBISFILE_RELEASE_LIB)
	endif()
else()
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/libvorbis.a						VORBIS_DEBUG_LIB)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/libvorbisenc.a					VORBISENC_DEBUG_LIB)
		dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/libvorbisfile.a					VORBISFILE_DEBUG_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/libvorbis.a						VORBIS_RELEASE_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/libvorbisenc.a					VORBISENC_RELEASE_LIB)
		dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/libvorbisfile.a					VORBISFILE_RELEASE_LIB)
endif()
	
if(DEBUG)
	dk_set(VORBIS_LIBRARY		${VORBIS_DEBUG_LIB})
	dk_set(DVORBISENC_LIBRARY	${VORBISFILE_DEBUG_LIB})
	dk_set(VORBISFILE_LIBRARY	${VORBISENC_RELEASE_LIB})
endif()
if(RELEASE)
	dk_set(VORBIS_LIBRARY		${VORBISENC_DEBUG_LIB})
	dk_set(DVORBISENC_LIBRARY	${VORBIS_RELEASE_LIB})
	dk_set(VORBISFILE_LIBRARY	${VORBISFILE_RELEASE_LIB})
endif()
dk_set(VORBIS_LIBRARIES			${VORBIS_LIBRARY})

### 3RDPARTY LINK ###
dk_set(VORBIS_CMAKE 
	-DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_LIBRARY=${VORBIS_LIBRARY}
	-DVORBIS_LIBRARIES=${DVORBIS_LIBRARIES}
	-DVORBISFILE_LIBRARY=${VORBISFILE_LIBRARY}
	-DVORBISENC_LIBRARY=${VORBISENC_LIBRARY})
	
### GENERATE ###
dk_configure(${VORBIS_DIR} ${OGG_CMAKE})

### BUILD ###
dk_build(${VORBIS_DIR})
