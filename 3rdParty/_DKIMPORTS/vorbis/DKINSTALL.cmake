#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ vorbis ############
# https://github.com/xiph/vorbis
# https://ftp.osuosl.org/pub/xiph/releases/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip
# https://github.com/xiph/vorbis/releases/download/v1.3.7/libvorbis-1.3.7.zip

### DEPEND ###
dk_depend(libgcc)
dk_validate(msys2 "dk_depend(msys2)")
dk_depend(ogg)

### IMPORT ###
dk_import()

### LINK ###
dk_include				(${vorbis}/include											VORBIS_INCLUDE_DIR)

if(MULTI_CONFIG)
	if(Windows AND MSVC)
		dk_libDebug		(${vorbis_Config_Dir}/lib/${Debug_Dir}/vorbis.lib			VORBIS_DEBUG_LIB		VORBIS_LIBRARY)
		dk_libDebug		(${vorbis_Config_Dir}/lib/${Debug_Dir}/vorbisenc.lib		VORBISENC_DEBUG_LIB		VORBISENC_LIBRARY)
		dk_libDebug		(${vorbis_Config_Dir}/lib/${Debug_Dir}/vorbisfile.lib		VORBISFILE_DEBUG_LIB	VORBISFILE_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/${Release_Dir}/vorbis.lib			VORBIS_RELEASE_LIB		VORBIS_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/${Release_Dir}/vorbisenc.lib		VORBISENC_RELEASE_LIB	VORBISENC_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/${Release_Dir}/vorbisfile.lib		VORBISFILE_RELEASE_LIB	VORBISFILE_LIBRARY)
	else()
		dk_libDebug		(${vorbis_Config_Dir}/lib/${Debug_Dir}/libvorbis.a			VORBIS_DEBUG_LIB		VORBIS_LIBRARY)
		dk_libDebug		(${vorbis_Config_Dir}/lib/${Debug_Dir}/libvorbisenc.a		VORBISENC_DEBUG_LIB		VORBISENC_LIBRARY)
		dk_libDebug		(${vorbis_Config_Dir}/lib/${Debug_Dir}/libvorbisfile.a		VORBISFILE_DEBUG_LIB	VORBISFILE_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/${Release_Dir}/libvorbis.a		VORBIS_RELEASE_LIB		VORBIS_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/${Release_Dir}/libvorbisenc.a		VORBISENC_RELEASE_LIB	VORBISENC_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/${Release_Dir}/libvorbisfile.a	VORBISFILE_RELEASE_LIB	VORBISFILE_LIBRARY)
	endif()
else()
		dk_libDebug		(${vorbis_Config_Dir}/lib/libvorbis.a						VORBIS_DEBUG_LIB		VORBIS_LIBRARY)
		dk_libDebug		(${vorbis_Config_Dir}/lib/libvorbisenc.a					VORBISENC_DEBUG_LIB		VORBISENC_LIBRARY)
		dk_libDebug		(${vorbis_Config_Dir}/lib/libvorbisfile.a					VORBISFILE_DEBUG_LIB	VORBISFILE_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/libvorbis.a						VORBIS_RELEASE_LIB		VORBIS_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/libvorbisenc.a					VORBISENC_RELEASE_LIB	VORBISENC_LIBRARY)
		dk_libRelease	(${vorbis_Config_Dir}/lib/libvorbisfile.a					VORBISFILE_RELEASE_LIB	VORBISFILE_LIBRARY)
endif()
	
dk_set(VORBIS_LIBRARIES	${VORBIS_LIBRARY} ${VORBISENC_LIBRARY} ${VORBISFILE_LIBRARY})

### 3RDPARTY LINK ###
dk_set(vorbis_CMAKE 
	-DVORBIS_INCLUDE_DIR=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_INCLUDE_DIRS=${VORBIS_INCLUDE_DIR} 
	-DVORBIS_LIBRARY=${VORBIS_LIBRARY}
	-DVORBIS_LIBRARIES=${VORBIS_LIBRARIES}
	-DVORBISFILE_LIBRARY=${VORBISFILE_LIBRARY}
	-DVORBISENC_LIBRARY=${VORBISENC_LIBRARY})
	
### GENERATE ###
dk_configure(${vorbis} ${ogg_CMAKE})

### BUILD ###
dk_build()
