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


############ bzip2-win-build ############
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip

if(Unix)
	dk_disable(bzip2-win-build)
	dk_return()
endif()

### DEPEND ###
dk_depend(libgcc)
dk_validate(msys2 "dk_depend(msys2)")

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${bzip2-win-build}													BZIP2_INCLUDE_DIR)
if(Windows_X86)
	dk_libDebug		(${bzip2-win-build_Debug_Dir}/libbz2-static.lib						BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${bzip2-win-build_Release_Dir}/libbz2-static.lib					BZIP2_LIBRARY_RELEASE)
endif()
if(Windows_X86_64)
	dk_libDebug		(${bzip2-win-build_Tuple_Dir}/x64/${Debug_Dir}/libbz2-static.lib	BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${bzip2-win-build_Tuple_Dir}/x64/${Release_Dir}/libbz2-static.lib	BZIP2_LIBRARY_RELEASE)
endif()
### 3RDPARTY LINK ###
dk_set(bzip2-win-build_CMAKE 
	-DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} 
	-DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} 
	-DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})
	
### COMPILE ###
if(Windows_X86)
	dk_define		(BZ_NO_STDIO)
	dk_copy			(${bzip2-win-build}/build-VS2022 ${bzip2-win-build_Tuple_Dir})
	dk_fileReplace	(${bzip2-win-build_Tuple_Dir}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dk_fileReplace	(${bzip2-win-build_Tuple_Dir}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_chdir		(${bzip2-win-build_Tuple_Dir})
	dk_build		(${bzip2-win-build} libbz2-static)
endif()

if(Windows_X86_64)
	dk_copy			(${bzip2-win-build}/win32/bzip2.rc ${bzip2-win-build_Tuple_Dir}/bzip2.rc) #copy project files that came with bzip
	dk_copy			(${bzip2-win-build}/win32/bzip2recover.rc ${bzip2-win-build_Tuple_Dir}/bzip2recover.rc)
	dk_copy			(${bzip2-win-build}/win32/bzip2_version.h ${bzip2-win-build_Tuple_Dir}/bzip2_version.h)
	dk_copy			(${bzip2-win-build}/win32/libbz2.rc ${bzip2-win-build_Tuple_Dir}/libbz2.rc)
	dk_copy			(${bzip2-win-build}/build-VS2022 ${bzip2-win-build_Tuple_Dir})
	dk_fileReplace	(${bzip2-win-build_Tuple_Dir}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dk_fileReplace	(${bzip2-win-build_Tuple_Dir}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_chdir		(${bzip2-win-build_Tuple_Dir})
	dk_build		(${bzip2-win-build} libbz2-static x64)
endif()
