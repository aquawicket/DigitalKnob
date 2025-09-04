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


###### sdl_rtf ######
# https://github.com/libsdl-org/SDL_rtf.git

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_rtf.git BRANCH main)
dk_import(https://github.com/libsdl-org/SDL_rtf/archive/refs/heads/main.zip)


### LINK ###
dk_include					(${SDL_RTF})
if(MSVC)
	Windows_dk_libDebug			(${SDL_RTF_Config_Dir}/lib/${Debug_Dir}/SDL_rtf.lib)
	Windows_dk_libRelease		(${SDL_RTF_Config_Dir}/lib/${Release_Dir}/SDL_rtf.lib)
elseif(Apple)
	Iossim_dk_libDebug		(${SDL_RTF_Config_Dir}/lib/Debug/SDL_rtf.a)
	Iossim_dk_libRelease	(${SDL_RTF_Config_Dir}/lib/Release/SDL_rtf.a)
	Mac_dk_libDebug			(${SDL_RTF_Config_Dir}/lib/${Debug_Dir}/SDL_rtf.a)
	Mac_dk_libRelease		(${SDL_RTF_Config_Dir}/lib/${Release_Dir}/SDL_rtf.a)
elseif(Android)
	Android_dk_libDebug		(${SDL_RTF_Config_Dir}/lib/${Debug_Dir}/SDL_rtf.a)
	Android_dk_libRelease	(${SDL_RTF_Config_Dir}/lib/${Release_Dir}/SDL_rtf.a)
else()
	Emscripten_dk_libDebug	(${SDL_RTF_Config_Dir}/lib/SDL_rtf.a)
	Emscripten_dk_libRelease(${SDL_RTF_Config_Dir}/lib/SDL_rtf.a)
endif()



### GENERATE ###
dk_configure(${SDL_RTF} ${sdl_CMAKE})


### COMPILE ###
dk_build()
