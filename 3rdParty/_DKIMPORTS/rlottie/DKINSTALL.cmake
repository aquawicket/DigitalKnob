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


############ rlottie ############
# https://github.com/Samsung/rlottie.git
dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://github.com/Samsung/rlottie/archive/e3026b1e.zip)

### PATCH ###
if(MSVC)
	dk_fileReplace(${RLOTTIE}/CMakeLists.txt "#set(CMAKE_CXX_FLAGS_RELEASE)" 	"set(CMAKE_CXX_FLAGS_RELEASE)")
	dk_fileReplace(${RLOTTIE}/CMakeLists.txt "#set(CMAKE_CXX_FLAGS_DEBUG)" 		"set(CMAKE_CXX_FLAGS_DEBUG)")
else()
	dk_fileReplace(${RLOTTIE}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_RELEASE" 	"#set(CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace(${RLOTTIE}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_DEBUG" 	"#set(CMAKE_CXX_FLAGS_DEBUG")
endif()

### LINK ###
dk_include			(${RLOTTIE}/inc							rlottie_DIR)
dk_include			(${RLOTTIE.Config_Dir}					rlottie_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${RLOTTIE.Debug_Dir}/rlottie.lib)
	dk_libRelease	(${RLOTTIE.Release_Dir}/rlottie.lib)
else()
	dk_libDebug		(${RLOTTIE.Debug_Dir}/librlottie.a)
	dk_libRelease	(${RLOTTIE.Release_Dir}/librlottie.a)
endif()

### 3RDPARTY LINK ###
dk_set(RLOTTIE_CMAKE -Drlottie_DIR=${rlottie_DIR} -Drlottie_INCLUDE_DIR=${rlottie_INCLUDE_DIR})

### GENERATE ###
dk_configure(${RLOTTIE}
	-DLOTTIE_MODULE=ON		# "Enable LOTTIE MODULE SUPPORT" ON
	-DLOTTIE_THREAD=ON 		# "Enable LOTTIE THREAD SUPPORT" ON
	-DLOTTIE_CACHE=ON  		# "Enable LOTTIE CACHE SUPPORT" ON
	-DLOTTIE_TEST=OFF 		# "Build LOTTIE AUTOTESTS" OFF
	-DLOTTIE_CCACHE=OFF 	# "Enable LOTTIE ccache SUPPORT" OFF
	-DLOTTIE_ASAN=OFF) 		# "Compile with asan" OFF

### COMPILE ###
dk_build(${RLOTTIE} rlottie)
