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


############ bzip2 ############
# https://www.sourceware.org/bzip2
# https://gitlab.com/bzip2/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
# https://gitlab.com/bzip2/bzip2/-/archive/bzip2-1.0.8/bzip2-bzip2-1.0.8.zip
# https://gist.github.com/DanAlbert/c7b6b2d93d4f6d672707803a6715095e			# Android COMPILE

dk_validate(Host_Tuple "dk_Host_Tuple()")

### DEPEND ###
#dk_depend(libgcc)
dk_depend(python3)
#dk_depend(pytest)
dk_depend(msys2)

### IMPORT ###
#dk_import(${bzip2_Import})
dk_import()
dk_assertVar(BZIP2)

dk_include			(${BZIP2}/								BZIP2_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${BZIP2_Debug_Dir}/bz2_static.lib		BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${BZIP2_Release_Dir}/bz2_static.lib	BZIP2_LIBRARY_RELEASE)
else()
	dk_libDebug		(${BZIP2_Debug_Dir}/libbz2_static.a		BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${BZIP2_Release_Dir}/libbz2_static.a	BZIP2_LIBRARY_RELEASE)
endif()

### 3RDPARTY LINK ###
dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})
	
### CONFIGURE ###
if(Linux_Host)
	dk_configure(${BZIP2} 
		-DENABLE_SHARED_LIB=${BUILD_SHARED_LIBS} 
		-DENABLE_STATIC_LIB=${BUILD_STATIC_LIBS} 
		-DENABLE_TESTS=0 
		-DENABLE_STATIC_LIB=1)
else()
	dk_configure(${BZIP2} 
		-DENABLE_SHARED_LIB=${BUILD_SHARED_LIBS} 
		-DENABLE_STATIC_LIB=${BUILD_STATIC_LIBS} 
		${PYTHON3_CMAKE} 
		-DENABLE_TESTS=0 
		-DENABLE_STATIC_LIB=1)
endif()
	
### COMPILE ###
dk_build()
