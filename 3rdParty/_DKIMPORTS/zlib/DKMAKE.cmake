#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ zlib ############
# https://github.com/madler/zlib.git
# http://www.zlib.net/

### IMPORT ###
dk_validate(host_triple "dk_host_triple()")
dk_validate(triple "dk_target_triple()")
dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam("${DKIMPORTS_DIR}/zlib/dkconfig.txt" ZLIB_DL)
dk_import(${ZLIB_DL})
#dk_import(https://chromium.googlesource.com/chromium/src/third_party/+archive/refs/heads/main/zlib.tar.gz)

### LINK ###
dk_include				(${ZLIB_DIR}							ZLIB_INCLUDE_DIR)
dk_include				(${ZLIB_CONFIG_DIR}						ZLIB_INCLUDE_DIR2)
if(MSVC)
	if(WIN)	
		dk_libDebug		(${ZLIB_DEBUG_DIR}/zd.lib				ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_RELEASE_DIR}/z.lib 				ZLIB_LIBRARY_RELEASE)
	endif()
else()
#	if(MSYSTEM)
#		dk_libDebug		(${ZLIB_DEBUG_DIR}/libzlibstatic.a		ZLIB_LIBRARY_DEBUG)
#		dk_libRelease	(${ZLIB_RELEASE_DIR}/libzlibstatic.a	ZLIB_LIBRARY_RELEASE)
#	else()
		dk_libDebug		(${ZLIB_DEBUG_DIR}/libz.a				ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_RELEASE_DIR}/libz.a				ZLIB_LIBRARY_RELEASE)
#	endif()
endif()
if(DEBUG)
	dk_set(ZLIB_LIBRARY ${ZLIB_LIBRARY_DEBUG})
endif()
if(RELEASE)
	dk_set(ZLIB_LIBRARY ${ZLIB_LIBRARY_RELEASE})
endif()

### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindZLIB.html
dk_append(ZLIB_CMAKE 
	-DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIR}
	-DZLIB_LIBRARY_DEBUG=${ZLIB_LIBRARY_DEBUG} 
	-DZLIB_LIBRARY_RELEASE=${ZLIB_LIBRARY_RELEASE})
if(WIN AND MSVC)
	dk_append(ZLIB_CMAKE 
		"-DCMAKE_C_FLAGS=/I${ZLIB_INCLUDE_DIR} /I${ZLIB_INCLUDE_DIR2}" 
		"-DCMAKE_CXX_FLAGS=/I${ZLIB_INCLUDE_DIR} /I${ZLIB_INCLUDE_DIR2}")
else()
	dk_append(ZLIB_CMAKE
		"-DCMAKE_C_FLAGS=-I${ZLIB_INCLUDE_DIR} -I${ZLIB_INCLUDE_DIR2}" 
		"-DCMAKE_CXX_FLAGS=-I${ZLIB_INCLUDE_DIR} -I${ZLIB_INCLUDE_DIR2}")
endif()
dk_append(ZLIB_CMAKE
	-DZLIB_LIBRARY=${ZLIB_LIBRARY}
	-DZLIB_LIBRARIES=${ZLIB_LIBRARY}
	"-DCMAKE_EXE_LINKER_FLAGS=${ZLIB_LIBRARY}")

### GENERATE ###
dk_configure(${ZLIB_DIR} -DZLIB_BUILD_EXAMPLES=OFF -DUNIX=1 -DWIN32=0 NO_HALT)

### COMPILE ###
dk_build(${ZLIB_DIR} zlibstatic)
