# https://github.com/libsdl-org/SDL_ttf.git
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip


### DEPEND ###
dk_depend(freetype)
dk_depend(libwebp)
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/libsdl-org/SDL_ttf/archive/refs/tags/release-2.20.1.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf.git BRANCH main PATCH) # SDL3


### LINK ###
dk_include					(${SDL_TTF})
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
	ANDROID_dk_libRelease	(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)
	WIN_dk_libDebug			(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.lib)
	WIN_dk_libRelease		(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.lib)
elseif(XCODE_IDE)
	dk_libDebug				(${SDL_TTF}/${OS}/lib/Debug/SDL_ttf.a)
	dk_libRelease			(${SDL_TTF}/${OS}/lib/Release/SDL_ttf.a)
else()
	dk_libDebug				(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
	dk_libRelease			(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD}
	#-DSDLTTF_SUPPORT_WEBP=OFF
	${FREETYPE_CMAKE}
	${LIBWEBP_CMAKE}
	${SDL_CMAKE}
	${SDL_TTF}) 


### COMPILE ###
dk_build(${SDL_TTF} SDLTTF)
