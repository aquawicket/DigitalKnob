#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/Samsung/rlottie.git


### IMPORT ###
dk_import(https://github.com/Samsung/rlottie/archive/e3026b1e1a516fff3c22d2b1b9f26ec864f89a82.zip)
#dk_import(https://github.com/Samsung/rlottie/archive/refs/heads/master.zip)


### PATCH ###
dk_fileReplace(${RLOTTIE_DIR}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_RELEASE \"\${CMAKE_CXX_FLAGS_RELEASE} /MT\")" "")
dk_fileReplace(${RLOTTIE_DIR}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_DEBUG \"\${CMAKE_CXX_FLAGS_DEBUG} /MTd\")" "")


### LINK ###
dk_include				(${RLOTTIE_DIR}/inc						RLOTTIE_INCLUDE_DIR)
dk_include				(${RLOTTIE_CONFIG_DIR})
if(MSVC)
	WIN_dk_libDebug		(${RLOTTIE_DEBUG_DIR}/rlottie.lib)
	WIN_dk_libRelease	(${RLOTTIE_RELEASE_DIR}/rlottie.lib)
else()
	dk_libDebug			(${RLOTTIE_DEBUG_DIR}/librlottie.a)
	dk_libRelease		(${RLOTTIE_RELEASE_DIR}/librlottie.a)
endif()


### 3RDPARTY LINK ###
#dk_set(RLOTTIE_CMAKE -Drlottie_DIR=${RLOTTIE_DEBUG_DIR} -Drlottie_INCLUDE_DIR=${RLOTTIE_INCLUDE_DIR})
dk_set(RLOTTIE_CMAKE -Drlottie_DIR=${RLOTTIE_CONFIG_DIR} -Drlottie_INCLUDE_DIR=${RLOTTIE_INCLUDE_DIR})


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
