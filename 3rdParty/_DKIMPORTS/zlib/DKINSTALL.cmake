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


############ zlib ############
# https://github.com/madler/zlib.git
# http://www.zlib.net
# https://chromium.googlesource.com/chromium/src/third_party/+archive/refs/heads/main/zlib.tar.gz

### IMPORT ###
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate(Target_Config  "dk_Target_Config()")
dk_import(${zlib_Import})

### DKBIN ###
#set(ZLIB			 	"$ENV{DIGITALKNOB_DIR}/DKBIN/include/zlib")  	# C:/Users/Administrator/DigitalKnob/DKBIN/include/zlib
#set(ZLIB_INC		 	"$ENV{DIGITALKNOB_DIR}/DKBIN/include/zlib")  	# C:/Users/Administrator/DigitalKnob/DKBIN/include/zlib
#set(ZLIB_Config_Dir  	"${ZLIB_INC}/${Target_Config}")					# //DKBIN/include/zlib/Windows_X86_64_Clang (MULTI_CONFIG), //DKBIN/include/zlib/Windows_X86_64_Clang/Debug (SINGLE_CONFIG)
#set(ZLIB_LIB		 	"$ENV{DIGITALKNOB_DIR}/DKBIN/lib/zlib")	   		# C:/Users/Administrator/DigitalKnob/DKBIN/lib/zlib
#set(ZLIB_Debug_Dir		"${ZLIB_LIB}/${Target_Tuple}/${Debug_Dir}")		# C:/Users/Administrator/DigitalKnob/DKBIN/lib/zlib/Windows_X86_64_Clang/Debug
#set(ZLIB_Release_Dir 	"${ZLIB_LIB}/${Target_Tuple}/${Release_Dir}")	# C:/Users/Administrator/DigitalKnob/DKBIN/lib/zlib/Windows_X86_64_Clang/Release

### LINK ###
dk_include				(${ZLIB}								ZLIB_INCLUDE_DIR)
dk_include				(${ZLIB_Config_Dir}						ZLIB_INCLUDE_DIR2)
if(MSVC)
	if(Windows)	
		dk_libDebug		(${ZLIB_Debug_Dir}/zd.lib				ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_Release_Dir}/z.lib 				ZLIB_LIBRARY_RELEASE)
	endif()
else()
	if(Windows)
		dk_libDebug		(${ZLIB_Debug_Dir}/libzlibstatic.a		ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_Release_Dir}/libzlibstatic.a	ZLIB_LIBRARY_RELEASE)
	else()
		dk_libDebug		(${ZLIB_Debug_Dir}/libz.a				ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB_Release_Dir}/libz.a				ZLIB_LIBRARY_RELEASE)
	endif()
endif()
if(Debug)
	dk_set(ZLIB_LIBRARY ${ZLIB_LIBRARY_DEBUG})
endif()
if(Release)
	dk_set(ZLIB_LIBRARY ${ZLIB_LIBRARY_RELEASE})
endif()

### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindZLIB.html
dk_append(ZLIB_CMAKE 
	"-DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIR}"
	"-DZLIB_LIBRARY_DEBUG=${ZLIB_LIBRARY_DEBUG}" 
	"-DZLIB_LIBRARY_RELEASE=${ZLIB_LIBRARY_RELEASE}")
if(Windows AND MSVC)
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
dk_configure(${ZLIB} -DZLIB_BUILD_EXAMPLES=OFF)# -DUNIX=1 -DWIN32=0)

### COMPILE ###
dk_build(${ZLIB} zlibstatic)
