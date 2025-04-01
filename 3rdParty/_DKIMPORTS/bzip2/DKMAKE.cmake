#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ bzip2 ############
dk_validate(host_triple "dk_host_triple()")
# https://www.sourceware.org/bzip2
# https://gitlab.com/bzip2/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
# https://gitlab.com/bzip2/bzip2/-/archive/bzip2-1.0.8/bzip2-bzip2-1.0.8.zip
# https://gist.github.com/DanAlbert/c7b6b2d93d4f6d672707803a6715095e			# ANDROID COMPILE

### DEPEND ###
#dk_depend(libgcc)
dk_depend(python3)
dk_depend(pytest)
dk_validate(MSYS2 "dk_depend(msys2)")

### IMPORT ###
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParam("$ENV{DKIMPORTS_DIR}/bzip2/dkconfig.txt" BZIP2_DL)
dk_import(${BZIP2_DL})

dk_include		(${BZIP2_DIR}/							BZIP2_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${BZIP2_DEBUG_DIR}/bz2_static.lib		BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${BZIP2_RELEASE_DIR}/bz2_static.lib	BZIP2_LIBRARY_RELEASE)
else()
	dk_libDebug		(${BZIP2_DEBUG_DIR}/libbz2_static.a		BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${BZIP2_RELEASE_DIR}/libbz2_static.a	BZIP2_LIBRARY_RELEASE)
endif()

### 3RDPARTY LINK ###
dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})
	
### CONFIGURE ###
if(LINUX_HOST)
	dk_configure(${BZIP2_DIR} -DENABLE_SHARED_LIB=${BUILD_SHARED_LIBS} -DENABLE_STATIC_LIB=${BUILD_STATIC_LIBS})
else()
	dk_configure(${BZIP2_DIR} -DENABLE_SHARED_LIB=${BUILD_SHARED_LIBS} -DENABLE_STATIC_LIB=${BUILD_STATIC_LIBS} ${PYTHON3_CMAKE})
endif()
	
### COMPILE ###
dk_build(${BZIP2_DIR})
