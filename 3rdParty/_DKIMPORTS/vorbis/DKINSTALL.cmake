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


############ vorbis ############
# https://github.com/xiph/vorbis
# https://ftp.osuosl.org/pub/xiph/releases/vorbis
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip
dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(libgcc)
dk_validate(msys2 "dk_depend(msys2)")
dk_depend(ogg)

### IMPORT ###
#dk_import(https://github.com/xiph/vorbis.git)
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import("${VORBIS_DL}")

### LINK ###
dk_include				(${VORBIS}/include										VORBIS_INCLUDE_DIR)

if(MULTI_CONFIG)
	if(Windows AND MSVC)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/${Debug_Dir}/vorbis.lib			VORBIS_DEBUG_LIB)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/${Debug_Dir}/vorbisenc.lib		VORBISENC_DEBUG_LIB)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/${Debug_Dir}/vorbisfile.lib		VORBISFILE_DEBUG_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/${Release_Dir}/vorbis.lib			VORBIS_RELEASE_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/${Release_Dir}/vorbisenc.lib		VORBISENC_RELEASE_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/${Release_Dir}/vorbisfile.lib		VORBISFILE_RELEASE_LIB)
	else()
		dk_libDebug		(${VORBIS_Config_Dir}/lib/${Debug_Dir}/libvorbis.a			VORBIS_DEBUG_LIB)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/${Debug_Dir}/libvorbisenc.a		VORBISENC_DEBUG_LIB)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/${Debug_Dir}/libvorbisfile.a		VORBISFILE_DEBUG_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/${Release_Dir}/libvorbis.a		VORBIS_RELEASE_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/${Release_Dir}/libvorbisenc.a		VORBISENC_RELEASE_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/${Release_Dir}/libvorbisfile.a	VORBISFILE_RELEASE_LIB)
	endif()
else()
		dk_libDebug		(${VORBIS_Config_Dir}/lib/libvorbis.a						VORBIS_DEBUG_LIB)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/libvorbisenc.a					VORBISENC_DEBUG_LIB)
		dk_libDebug		(${VORBIS_Config_Dir}/lib/libvorbisfile.a					VORBISFILE_DEBUG_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/libvorbis.a						VORBIS_RELEASE_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/libvorbisenc.a					VORBISENC_RELEASE_LIB)
		dk_libRelease	(${VORBIS_Config_Dir}/lib/libvorbisfile.a					VORBISFILE_RELEASE_LIB)
endif()
	
if(Debug)
	dk_set(VORBIS_LIBRARY		${VORBIS_DEBUG_LIB})
	dk_set(DVORBISENC_LIBRARY	${VORBISFILE_DEBUG_LIB})
	dk_set(VORBISFILE_LIBRARY	${VORBISENC_DEBUG_LIB})
endif()
if(Release)
	dk_set(VORBIS_LIBRARY		${VORBISENC_RELEASE_LIB})
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
dk_configure(${VORBIS} ${OGG_CMAKE})

### BUILD ###
dk_build()
