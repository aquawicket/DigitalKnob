# https://github.com/libsdl-org/SDL_rtf.git


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/libsdl-org/SDL_rtf.git BRANCH main)


### LINK ###
dk_include				(${SDL_RTF})
ANDROID_dk_libDebug		(${SDL_RTF}/${OS}/lib/${DEBUG_DIR}/SDL_rtf.a)
ANDROID_dk_libRelease	(${SDL_RTF}/${OS}/lib/${RELEASE_DIR}/SDL_rtf.a)
EMSCRIPTEN_dk_libDebug	(${SDL_RTF}/${OS}/${DEBUG_DIR}/lib/SDL_rtf.a)
EMSCRIPTEN_dk_libRelease(${SDL_RTF}/${OS}/${RELEASE_DIR}/lib/SDL_rtf.a)
IOSSIM_dk_libDebug		(${SDL_RTF}/${OS}/lib/Debug/SDL_rtf.a)
IOSSIM_dk_libRelease	(${SDL_RTF}/${OS}/lib/Release/SDL_rtf.a)
LINUX_dk_libDebug		(${SDL_RTF}/${OS}/${DEBUG_DIR}/lib/SDL_rtf.a)
LINUX_dk_libRelease		(${SDL_RTF}/${OS}/${RELEASE_DIR}/lib/SDL_rtf.a)
MAC_dk_libDebug			(${SDL_RTF}/${OS}/lib/${DEBUG_DIR}/SDL_rtf.a)
MAC_dk_libRelease		(${SDL_RTF}/${OS}/lib/${RELEASE_DIR}/SDL_rtf.a)
RASPBERRY_dk_libDebug	(${SDL_RTF}/${OS}/${DEBUG_DIR}/lib/SDL_rtf.a)
RASPBERRY_dk_libRelease	(${SDL_RTF}/${OS}/${RELEASE_DIR}/lib/SDL_rtf.a)
WIN_dk_libDebug			(${SDL_RTF}/${OS}/lib/${DEBUG_DIR}/SDL_rtf.lib)
WIN_dk_libRelease		(${SDL_RTF}/${OS}/lib/${RELEASE_DIR}/SDL_rtf.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SDL_RTF})


### COMPILE ###
dk_build(${SDL_RTF})
