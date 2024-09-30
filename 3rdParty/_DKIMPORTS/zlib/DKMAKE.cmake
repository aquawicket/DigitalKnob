#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/madler/zlib.git
# http://www.zlib.net/


### IMPORT ###
dk_import(https://github.com/madler/zlib/archive/d476828316d05d54c6fd6a068b121b30c147b5cd.zip)
#dk_import(https://github.com/madler/zlib/archive/refs/heads/master.zip)

### LINK ###
dk_include				(${ZLIB_DIR}							ZLIB_INCLUDE_DIR)
dk_include				(${ZLIB_CONFIG_DIR}						ZLIB_INCLUDE_DIR2)
if(MSVC)
	WIN_dk_libDebug		(${ZLIB_DEBUG_DIR}/zlibstaticd.lib		ZLIB_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${ZLIB_RELEASE_DIR}/zlibstatic.lib		ZLIB_LIBRARY_RELEASE)
else()
	if(MSYSTEM)
		dk_libDebug		(${ZLIB_DEBUG_DIR}/libzlibstatic.a		ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_RELEASE_DIR}/libzlibstatic.a	ZLIB_LIBRARY_RELEASE)
	else()
		dk_libDebug		(${ZLIB_DEBUG_DIR}/libz.a				ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_RELEASE_DIR}/libz.a				ZLIB_LIBRARY_RELEASE)
	endif()
endif()
DEBUG_dk_set	(ZLIB_LIBRARY ${ZLIB_LIBRARY_DEBUG})
RELEASE_dk_set	(ZLIB_LIBRARY ${ZLIB_LIBRARY_RELEASE})



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
dk_configure(${ZLIB_DIR} -DZLIB_BUILD_EXAMPLES=OFF)



### COMPILE ###
dk_build(${ZLIB_DIR} zlibstatic)
