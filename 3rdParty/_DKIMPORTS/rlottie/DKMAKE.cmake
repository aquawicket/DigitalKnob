#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ rlottie ############
# https://github.com/Samsung/rlottie.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/Samsung/rlottie/archive/e3026b1e.zip)

### PATCH ###
if(MSVC)
	dk_fileReplace(${RLOTTIE_DIR}/CMakeLists.txt "#set(CMAKE_CXX_FLAGS_RELEASE)" 	"set(CMAKE_CXX_FLAGS_RELEASE)")
	dk_fileReplace(${RLOTTIE_DIR}/CMakeLists.txt "#set(CMAKE_CXX_FLAGS_DEBUG)" 		"set(CMAKE_CXX_FLAGS_DEBUG)")
else()
	dk_fileReplace(${RLOTTIE_DIR}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_RELEASE" 	"#set(CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace(${RLOTTIE_DIR}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_DEBUG" 	"#set(CMAKE_CXX_FLAGS_DEBUG")
endif()

### LINK ###
dk_include			(${RLOTTIE_DIR}/inc						rlottie_DIR)
dk_include			(${RLOTTIE_CONFIG_DIR}					rlottie_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${RLOTTIE_DEBUG_DIR}/rlottie.lib)
	dk_libRelease	(${RLOTTIE_RELEASE_DIR}/rlottie.lib)
else()
	dk_libDebug		(${RLOTTIE_DEBUG_DIR}/librlottie.a)
	dk_libRelease	(${RLOTTIE_RELEASE_DIR}/librlottie.a)
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
