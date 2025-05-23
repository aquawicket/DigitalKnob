#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ zlib ############
# https://github.com/madler/zlib.git
# http://www.zlib.net
# https://chromium.googlesource.com/chromium/src/third_party/+archive/refs/heads/main/zlib.tar.gz

### IMPORT ###
#dk_validate(host_triple "dk_host_triple()")
#dk_validate(target_triple "dk_target_triple()")
dk_getFileParam("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt" ZLIB_IMPORT)
dk_import(${ZLIB_IMPORT} NAME zlib)

### DKBIN ###
#set(ZLIB			 	"$ENV{DIGITALKNOB_DIR}/DKBIN/include/zlib")  	# C:/Users/Administrator/digitalknob/DKBIN/include/zlib
#set(ZLIB_INC		 	"$ENV{DIGITALKNOB_DIR}/DKBIN/include/zlib")  	# C:/Users/Administrator/digitalknob/DKBIN/include/zlib
#set(ZLIB_CONFIG_DIR  	"${ZLIB_INC}/${CONFIG_PATH}")					# //DKBIN/include/zlib/win_x86_64_clang (MULTI_CONFIG), //DKBIN/include/zlib/win_x86_64_clang/Debug (SINGLE_CONFIG)
#set(ZLIB_LIB		 	"$ENV{DIGITALKNOB_DIR}/DKBIN/lib/zlib")	   		# C:/Users/Administrator/digitalknob/DKBIN/lib/zlib
#set(ZLIB_DEBUG_DIR		"${ZLIB_LIB}/${target_triple}/${DEBUG_DIR}")	# C:/Users/Administrator/digitalknob/DKBIN/lib/zlib/win_x86_64_clang/Debug
#set(ZLIB_RELEASE_DIR 	"${ZLIB_LIB}/${target_triple}/${RELEASE_DIR}")  # C:/Users/Administrator/digitalknob/DKBIN/lib/zlib/win_x86_64_clang/Release

### LINK ###
dk_include				(${ZLIB}								ZLIB_INCLUDE_DIR)
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
	"-DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIR}"
	"-DZLIB_LIBRARY_DEBUG=${ZLIB_LIBRARY_DEBUG}" 
	"-DZLIB_LIBRARY_RELEASE=${ZLIB_LIBRARY_RELEASE}")
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
dk_configure(${ZLIB} -DZLIB_BUILD_EXAMPLES=OFF -DUNIX=1 -DWIN32=0 NO_HALT)

### COMPILE ###
dk_build(${ZLIB} zlibstatic)
