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


dk_importVariables(INSTALL_PATH ${CMAKE_CURRENT_LIST_DIR})
dk_validate(Target_Config  "dk_Target_Config()")

if(Android)
	dk_depend(log)
	#dk_depend(sdl)		# SDL_AndroidGetExternalStorageState()
	set(CMAKE_POSITION_INDEPENDENT_CODE ON)		# https://stackoverflow.com/a/38297422
endif()
if(Ios OR Iossim)
	dk_depend(uikit)
	#LIST(APPEND DK_SRC DK/DKiOS.mm)
endif()
if(Linux)
	#dk_depend(mesa)
	#dk_depend(libgl1-mesa-dev)
	dk_depend(libx11-dev)
	#dk_depend(libxrandr-dev)
	dk_depend(libasound2-dev) # TODO: Move to DKAudio
	dk_depend(libxtst-dev)
	#dk_depend(simple-getch)
	dk_depend(libstdc++fs)
endif()
if(Mac)
	dk_depend(core_foundation)
	dk_depend(core_services)
	dk_depend(core_graphics)
	dk_depend(carbon)		# for DKOSinfo.cpp Gestalt()
	dk_depend(iokit)		# for DKMac.cpp IO*() and kIO*()
endif()
if(Raspberry)
	#dk_depend(mesa)
	#dk_depend(libgl1-mesa-dev)
	dk_depend(libx11-dev)
	#dk_depend(libxrandr-dev)
	dk_depend(libasound2-dev) # TODO: Move to DKAudio
	dk_depend(libxtst-dev)
	#dk_depend(simple-getch)
endif()
if(Windows)
	dk_depend(psapi)		# GetProcessMemoryInfo()
	dk_depend(pdh)			# PdhOpenQueryA()
	dk_depend(dxva2)		# GetNumberOfPhysicalMonitorsFromHMONITOR()
endif()

dk_depend(backward-cpp)
#dk_depend(boxer)
dk_depend(fmt)




# TODO:  dk_configure and dk_build both use a path as a parameter.  However, dk_generateCmake only uses a folder name of the plugin.
# To make things more conformed and less restrictive, Lets change dk_generateCmake to also use a path as a parameter.
# All 4 of those functions below should be able to take ("${CMAKE_CURRENT_LIST_DIR}") as the input parameter.


dk_generateCmake()
dk_assets()
dk_configure()
dk_build()




