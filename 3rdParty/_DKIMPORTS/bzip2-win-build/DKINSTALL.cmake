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


############ bzip2-win-build ############
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
dk_validate(Target_Config  "dk_Target_Config()")
if(Unix)
	dk_disable(bzip2-win-build)
	dk_return()
endif()

### DEPEND ###
dk_depend(libgcc)
dk_validate(msys2 "dk_depend(msys2)")

### IMPORT ###
dk_import(https://github.com/kiyolee/bzip2-win-build/archive/8baa40cf.zip)

### LINK ###
dk_include				(${BZIP2_WIN_BUILD}											BZIP2_INCLUDE_DIR)
if(Windows_X86)
	dk_libDebug		(${BZIP2_WIN_BUILD_Tuple_Dir}/${Debug_Dir}/libbz2-static.lib		BZIP2_LIBRARY_DEBUG)
endif()
if(Windows_X86)	
	dk_libRelease	(${BZIP2_WIN_BUILD_Tuple_Dir}/${Release_Dir}/libbz2-static.lib		BZIP2_LIBRARY_RELEASE)
endif()
if(Windows_X86_64)
	dk_libDebug	(${BZIP2_WIN_BUILD_Tuple_Dir}/x64/${Debug_Dir}/libbz2-static.lib		BZIP2_LIBRARY_DEBUG)
endif()
if(Windows_X86_64)	
	dk_libRelease(${BZIP2_WIN_BUILD_Tuple_Dir}/x64/${Release_Dir}/libbz2-static.lib	BZIP2_LIBRARY_RELEASE)
endif()
### 3RDPARTY LINK ###
dk_set(BZIP2_WIN_BUILD_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})
	
### COMPILE ###
if(Windows_X86)
	dk_define		(BZ_NO_STDIO)
	dk_copy			(${BZIP2_WIN_BUILD}/build-VS2022 ${BZIP2_WIN_BUILD_Tuple_Dir})
	dk_fileReplace	(${BZIP2_WIN_BUILD_Tuple_Dir}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dk_fileReplace	(${BZIP2_WIN_BUILD_Tuple_Dir}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_chdir		(${BZIP2_WIN_BUILD_Tuple_Dir})
	dk_build		(${BZIP2_WIN_BUILD} libbz2-static)
endif()

if(Windows_X86_64)
	dk_copy			(${BZIP2_WIN_BUILD}/win32/bzip2.rc ${BZIP2_WIN_BUILD_Tuple_Dir}/bzip2.rc) #copy project files that came with bzip
	dk_copy			(${BZIP2_WIN_BUILD}/win32/bzip2recover.rc ${BZIP2_WIN_BUILD_Tuple_Dir}/bzip2recover.rc)
	dk_copy			(${BZIP2_WIN_BUILD}/win32/bzip2_version.h ${BZIP2_WIN_BUILD_Tuple_Dir}/bzip2_version.h)
	dk_copy			(${BZIP2_WIN_BUILD}/win32/libbz2.rc ${BZIP2_WIN_BUILD_Tuple_Dir}/libbz2.rc)
	dk_copy			(${BZIP2_WIN_BUILD}/build-VS2022 ${BZIP2_WIN_BUILD_Tuple_Dir})
	dk_fileReplace	(${BZIP2_WIN_BUILD_Tuple_Dir}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dk_fileReplace	(${BZIP2_WIN_BUILD_Tuple_Dir}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_chdir		(${BZIP2_WIN_BUILD_Tuple_Dir})
	dk_build		(${BZIP2_WIN_BUILD} libbz2-static x64)
endif()
