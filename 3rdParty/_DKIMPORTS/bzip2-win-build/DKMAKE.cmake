#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ bzip2-win-build ############
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
dk_load(dk_builder)
if(UNIX)
	dk_undepend(bzip2-win-build)
	dk_return()
endif()

### DEPEND ###
dk_depend(libgcc)
dk_validate(MSYS2 "dk_depend(msys2)")

### IMPORT ###
dk_import(https://github.com/kiyolee/bzip2-win-build/archive/8baa40cf.zip)

### LINK ###
dk_include				(${BZIP2_WIN_BUILD_DIR}												BZIP2_INCLUDE_DIR)
if(WIN_X86)
	dk_libDebug		(${BZIP2_WIN_BUILD_TRIPLE_DIR}/${DEBUG_DIR}/libbz2-static.lib		BZIP2_LIBRARY_DEBUG)
endif()
if(WIN_X86)	
	dk_libRelease	(${BZIP2_WIN_BUILD_TRIPLE_DIR}/${RELEASE_DIR}/libbz2-static.lib		BZIP2_LIBRARY_RELEASE)
endif()
if(WIN_X86_64)
	dk_libDebug	(${BZIP2_WIN_BUILD_TRIPLE_DIR}/x64/${DEBUG_DIR}/libbz2-static.lib	BZIP2_LIBRARY_DEBUG)
endif()
if(WIN_X86_64)	
	dk_libRelease(${BZIP2_WIN_BUILD_TRIPLE_DIR}/x64/${RELEASE_DIR}/libbz2-static.lib	BZIP2_LIBRARY_RELEASE)
endif()
### 3RDPARTY LINK ###
dk_set(BZIP2_WIN_BUILD_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})
	
### COMPILE ###
if(WIN_X86)
	dk_define		(BZ_NO_STDIO)
	dk_copy			(${BZIP2_WIN_BUILD}/build-VS2022 ${BZIP2_WIN_BUILD_TRIPLE_DIR})
	dk_fileReplace	(${BZIP2_WIN_BUILD_TRIPLE_DIR}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dk_fileReplace	(${BZIP2_WIN_BUILD_TRIPLE_DIR}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_cd			(${BZIP2_WIN_BUILD_TRIPLE_DIR})
	dk_build		(${BZIP2_WIN_BUILD} libbz2-static)
endif()

if(WIN_X86_64)
	dk_copy			(${BZIP2_WIN_BUILD}/win32/bzip2.rc ${BZIP2_WIN_BUILD_TRIPLE_DIR}/bzip2.rc) #copy project files that came with bzip
	dk_copy			(${BZIP2_WIN_BUILD}/win32/bzip2recover.rc ${BZIP2_WIN_BUILD_TRIPLE_DIR}/bzip2recover.rc)
	dk_copy			(${BZIP2_WIN_BUILD}/win32/bzip2_version.h ${BZIP2_WIN_BUILD_TRIPLE_DIR}/bzip2_version.h)
	dk_copy			(${BZIP2_WIN_BUILD}/win32/libbz2.rc ${BZIP2_WIN_BUILD_TRIPLE_DIR}/libbz2.rc)
	dk_copy			(${BZIP2_WIN_BUILD}/build-VS2022 ${BZIP2_WIN_BUILD_TRIPLE_DIR})
	dk_fileReplace	(${BZIP2_WIN_BUILD_TRIPLE_DIR}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dk_fileReplace	(${BZIP2_WIN_BUILD_TRIPLE_DIR}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_cd		(${BZIP2_WIN_BUILD_TRIPLE_DIR})
	dk_build		(${BZIP2_WIN_BUILD} libbz2-static x64)
endif()
