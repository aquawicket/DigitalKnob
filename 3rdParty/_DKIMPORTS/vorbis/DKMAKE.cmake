#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/xiph/vorbis
# https://ftp.osuosl.org/pub/xiph/releases/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip

### DEPEND ###
dk_depend(libgcc)
dk_depend(msys2)
dk_depend(ogg)


### IMPORT ###
#dk_import(https://github.com/xiph/vorbis.git)
dk_import(https://github.com/xiph/vorbis/releases/download/v1.3.7/libvorbis-1.3.7.zip)


### LINK ###
dk_include					(${VORBIS_DIR}/include										VORBIS_INCLUDE_DIR)
dk_include					(${VORBIS_DIR}/include										VORBIS_INCLUDE_DIR2)

#if(ANDROID)
if(MULTI_CONFIG)
	if(MSVC)
		WIN_dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/vorbis.lib			VORBIS_DEBUG_LIB)
		WIN_dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/vorbisenc.lib		VORBISENC_DEBUG_LIB)
		WIN_dk_libDebug		(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/vorbisfile.lib		VORBISFILE_DEBUG_LIB)
		WIN_dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/vorbis.lib			VORBIS_RELEASE_LIB)
		WIN_dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/vorbisenc.lib		VORBISENC_RELEASE_LIB)
		WIN_dk_libRelease	(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/vorbisfile.lib		VORBISFILE_RELEASE_LIB)
	else()
		dk_libDebug			(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbis.a			VORBIS_DEBUG_LIB)
		dk_libDebug			(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbisenc.a		VORBISENC_DEBUG_LIB)
		dk_libDebug			(${VORBIS_CONFIG_DIR}/lib/${DEBUG_DIR}/libvorbisfile.a		VORBISFILE_DEBUG_LIB)
		dk_libRelease		(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbis.a		VORBIS_RELEASE_LIB)
		dk_libRelease		(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbisenc.a		VORBISENC_RELEASE_LIB)
		dk_libRelease		(${VORBIS_CONFIG_DIR}/lib/${RELEASE_DIR}/libvorbisfile.a	VORBISFILE_RELEASE_LIB)
	endif()
else()
		dk_libDebug			(${VORBIS_CONFIG_DIR}/lib/libvorbis.a						VORBIS_DEBUG_LIB)
		dk_libDebug			(${VORBIS_CONFIG_DIR}/lib/libvorbisenc.a					VORBISENC_DEBUG_LIB)
		dk_libDebug			(${VORBIS_CONFIG_DIR}/lib/libvorbisfile.a					VORBISFILE_DEBUG_LIB)
		dk_libRelease		(${VORBIS_CONFIG_DIR}/lib/libvorbis.a						VORBIS_RELEASE_LIB)
		dk_libRelease		(${VORBIS_CONFIG_DIR}/lib/libvorbisenc.a					VORBISENC_RELEASE_LIB)
		dk_libRelease		(${VORBIS_CONFIG_DIR}/lib/libvorbisfile.a					VORBISFILE_RELEASE_LIB)
endif()

		
DEBUG_dk_set(VORBIS_LIBRARY			${VORBIS_DEBUG_LIB})
RELEASE_dk_set(VORBIS_LIBRARY		${VORBISENC_DEBUG_LIB})
DEBUG_dk_set(DVORBISENC_LIBRARY		${VORBISFILE_DEBUG_LIB})
RELEASE_dk_set(DVORBISENC_LIBRARY	${VORBIS_RELEASE_LIB})
DEBUG_dk_set(VORBISFILE_LIBRARY		${VORBISENC_RELEASE_LIB})
RELEASE_dk_set(VORBISFILE_LIBRARY	${VORBISFILE_RELEASE_LIB})
dk_set(VORBIS_LIBRARIES				${VORBIS_LIBRARY})

### 3RDPARTY LINK ###
dk_set(VORBIS_CMAKE 
	-DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR2} 
	-DVORBIS_LIBRARY=${VORBIS_LIBRARY}
	-DVORBIS_LIBRARIES=${DVORBIS_LIBRARIES}
	-DVORBISFILE_LIBRARY=${VORBISFILE_LIBRARY}
	-DVORBISENC_LIBRARY=${VORBISENC_LIBRARY})

	
### GENERATE ###
dk_configure(${VORBIS_DIR} ${OGG_CMAKE})



### BUILD ###
dk_build(${VORBIS_DIR})

