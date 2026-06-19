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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

#dk_depend(glew)
dk_depend(sdl)
dk_depend(DKWindow)

# DKCMake/DKGenerate.cmake will build android with or without GUI per the CMAKE_ANDROID_GUI variable.
if(Android)
	dk_set(CMAKE_ANDROID_GUI 1)
	dk_validate(openjdk "dk_depend(openjdk)")
	dk_validate(openjdk-8 "dk_depend(openjdk-8)")
	dk_depend(android-cmdline-tools)
endif()

# add SDL_main to the top of the DKPlugins.h file for iOS
if(Ios)
	set(ios_sdl2main "#if IOS\n #include \"SDL_main.h\"\n #endif \n")
	dk_set(PLUGINS_FILE "${ios_sdl2main} ${PLUGINS_FILE}")
endif()



############ DKSDLWindow ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()
