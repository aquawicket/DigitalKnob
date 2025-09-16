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


dk_validate(Target_Config  "dk_Target_Config()")
if(NOT Mac_Host)
	dk_disable(metal-cpp)
	dk_return()
endif()

# https://developer.apple.com/metal/cpp/
# https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip

### VERSION ###
dk_set(METAL_CPP_FOLDER metal-cpp_macOS12_iOS15)
dk_set(METAL_CPP_DL https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip)
dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
dk_set(METAL_CPP $ENV{DK3RDPARTY_DIR}/${METAL_CPP_FOLDER})


### INSTALL ###
dk_import(${METAL_CPP_DL} ${METAL_CPP})

dk_include(${METAL_CPP})
