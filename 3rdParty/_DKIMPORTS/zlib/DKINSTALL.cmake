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


############ zlib ############
# https://github.com/madler/zlib.git
# http://www.zlib.net
# https://chromium.googlesource.com/chromium/src/third_party/+archive/refs/heads/main/zlib.tar.gz
# https://github.com/madler/zlib/archive/d476828.zip

### IMPORT ###
dk_import()

### DKBIN ###
#set(zlib			 	"${DIGITALKNOB_DIR}/DKBIN/include/zlib")  		# C:/Users/Administrator/DigitalKnob/DKBIN/include/zlib
#set(zlib_INC		 	"${DIGITALKNOB_DIR}/DKBIN/include/zlib")  		# C:/Users/Administrator/DigitalKnob/DKBIN/include/zlib
#set(zlib_Config_Dir  	"${zlib_INC}/${Target_Config}")					# //DKBIN/include/zlib/Windows_X86_64_Clang (MULTI_CONFIG), //DKBIN/include/zlib/Windows_X86_64_Clang/Debug (SINGLE_CONFIG)
#set(zlib_LIB		 	"${DIGITALKNOB_DIR}/DKBIN/lib/zlib")	   		# C:/Users/Administrator/DigitalKnob/DKBIN/lib/zlib
#set(zlib_Debug_Dir		"${zlib_LIB}/${Target_Tuple}/${Debug_Dir}")		# C:/Users/Administrator/DigitalKnob/DKBIN/lib/zlib/Windows_X86_64_Clang/Debug
#set(zlib_Release_Dir 	"${zlib_LIB}/${Target_Tuple}/${Release_Dir}")	# C:/Users/Administrator/DigitalKnob/DKBIN/lib/zlib/Windows_X86_64_Clang/Release

#dk_debug("Target_Config_Type = ${Target_Config_Type}")
#dk_debug("zlib               = ${zlib}")
#dk_debug("zlib_Tuple_Dir     = ${zlib_Tuple_Dir}")
#dk_debug("zlib_Build_Dir     = ${zlib_Build_Dir}")
#dk_debug("zlib_Config_Dir    = ${zlib_Config_Dir}")
#dk_debug("zlib_Debug_Dir     = ${zlib_Debug_Dir}")
#dk_debug("zlib_Release_Dir   = ${zlib_Release_Dir}")
#dk_pause()

### SINGLE_CONFIG & MULTI_CONFIG
# zlib               = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828
# zlib_Tuple_Dir     = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}
# zlib_Debug_Dir     = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}/Debug
# zlib_Release_Dir   = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}/Release

### SINGLE_CONFIG
# zlib_Config_Dir    = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}/Release
# zlib_Build_Dir     = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}/Release

### MULTI_CONFIG
# zlib_Config_Dir    = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}
# zlib_Build_Dir     = C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-d476828/${Target_Tuple}/Debug



### LINK ###
dk_include			(${zlib}								ZLIB_INCLUDE_DIR)
dk_include			(${zlib_Config_Dir}						ZLIB_INCLUDE_DIR2)
if(Windows AND MSVC)
	dk_libDebug		(${zlib_Debug_Dir}/zlibstaticd.lib		ZLIB_LIBRARY_DEBUG		ZLIB_LIBRARY)
	dk_libRelease	(${zlib_Release_Dir}/zlibstatic.lib		ZLIB_LIBRARY_RELEASE	ZLIB_LIBRARY)
else()
	dk_libDebug		(${zlib_Debug_Dir}/libz.a				ZLIB_LIBRARY_DEBUG		ZLIB_LIBRARY)
	dk_libRelease	(${zlib_Release_Dir}/libzs.a			ZLIB_LIBRARY_RELEASE	ZLIB_LIBRARY)
endif()


### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindZLIB.html
dk_set(zlib_CMAKE 
	"-DZLIB_INCLUDE_DIR=\"${ZLIB_INCLUDE_DIR}\""
	"-DZLIB_LIBRARY=\"${ZLIB_LIBRARY}\""
	"-DZLIB_LIBRARIES=\"${ZLIB_LIBRARY}\""
	"-DCMAKE_EXE_LINKER_FLAGS=\"${ZLIB_LIBRARY}\"")
if(Windows AND MSVC)
	dk_append(zlib_CMAKE
		"-DZLIB_LIBRARY_DEBUG=\"${ZLIB_LIBRARY_DEBUG}\"" 
		"-DZLIB_LIBRARY_RELEASE=\"${ZLIB_LIBRARY_RELEASE}\""
		"-DCMAKE_C_FLAGS=/I\"${ZLIB_INCLUDE_DIR}\" /I\"${ZLIB_INCLUDE_DIR2}\"" 
		"-DCMAKE_CXX_FLAGS=/I\"${ZLIB_INCLUDE_DIR}\" /I\"${ZLIB_INCLUDE_DIR2}\"")
else()
	dk_append(zlib_CMAKE
		"-DCMAKE_C_FLAGS=-I\"${ZLIB_INCLUDE_DIR}\" -I\"${ZLIB_INCLUDE_DIR2}\"" 
		"-DCMAKE_CXX_FLAGS=-I\"${ZLIB_INCLUDE_DIR}\" -I\"${ZLIB_INCLUDE_DIR2}\"")
endif()

### GENERATE ###
dk_configure(${zlib} -DZLIB_BUILD_EXAMPLES=OFF)# -DUNIX=1 -DWIN32=0)

### COMPILE ###
dk_build(${zlib} zlibstatic)
