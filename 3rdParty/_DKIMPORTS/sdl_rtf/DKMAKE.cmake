#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/libsdl-org/SDL_rtf.git


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_rtf.git BRANCH main)
dk_import(https://github.com/libsdl-org/SDL_rtf/archive/refs/heads/main.zip)


### LINK ###
dk_include					(${SDL_RTF_DIR})
if(MSVC)
	WIN_dk_libDebug			(${SDL_RTF_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_rtf.lib)
	WIN_dk_libRelease		(${SDL_RTF_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_rtf.lib)
elseif(APPLE)
	IOSSIM_dk_libDebug		(${SDL_RTF_CONFIG_DIR}/lib/Debug/SDL_rtf.a)
	IOSSIM_dk_libRelease	(${SDL_RTF_CONFIG_DIR}/lib/Release/SDL_rtf.a)
	MAC_dk_libDebug			(${SDL_RTF_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_rtf.a)
	MAC_dk_libRelease		(${SDL_RTF_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_rtf.a)
elseif(ANDROID)
	ANDROID_dk_libDebug		(${SDL_RTF_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_rtf.a)
	ANDROID_dk_libRelease	(${SDL_RTF_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_rtf.a)
else()
	EMSCRIPTEN_dk_libDebug	(${SDL_RTF_CONFIG_DIR}/lib/SDL_rtf.a)
	EMSCRIPTEN_dk_libRelease(${SDL_RTF_CONFIG_DIR}/lib/SDL_rtf.a)
endif()



### GENERATE ###
dk_configure(${SDL_RTF} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL_RTF})
