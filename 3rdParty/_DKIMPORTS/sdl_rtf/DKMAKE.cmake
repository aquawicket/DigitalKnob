include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/libsdl-org/SDL_rtf.git


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_rtf.git BRANCH main)
dk_import(https://github.com/libsdl-org/SDL_rtf/archive/refs/heads/main.zip)


### LINK ###
dk_include					(${SDL_RTF})
if(MSVC)
	WIN_dk_libDebug			(${SDL_RTF}/${triple}/lib/${DEBUG_DIR}/SDL_rtf.lib)
	WIN_dk_libRelease		(${SDL_RTF}/${triple}/lib/${RELEASE_DIR}/SDL_rtf.lib)
elseif(APPLE)
	IOSSIM_dk_libDebug		(${SDL_RTF}/${triple}/lib/Debug/SDL_rtf.a)
	IOSSIM_dk_libRelease	(${SDL_RTF}/${triple}/lib/Release/SDL_rtf.a)
	MAC_dk_libDebug			(${SDL_RTF}/${triple}/lib/${DEBUG_DIR}/SDL_rtf.a)
	MAC_dk_libRelease		(${SDL_RTF}/${triple}/lib/${RELEASE_DIR}/SDL_rtf.a)
elseif(ANDROID)
	ANDROID_dk_libDebug		(${SDL_RTF}/${triple}/lib/${DEBUG_DIR}/SDL_rtf.a)
	ANDROID_dk_libRelease	(${SDL_RTF}/${triple}/lib/${RELEASE_DIR}/SDL_rtf.a)
else()
	EMSCRIPTEN_dk_libDebug	(${SDL_RTF}/${triple}/${DEBUG_DIR}/lib/SDL_rtf.a)
	EMSCRIPTEN_dk_libRelease(${SDL_RTF}/${triple}/${RELEASE_DIR}/lib/SDL_rtf.a)
endif()



### GENERATE ###
dk_configure(${SDL_RTF} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL_RTF})
