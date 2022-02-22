DKDEPEND(glew)
DKDEPEND(sdl)
DKDEPEND(DKWindow)

# add SDL_main to the top of the DKPlugins.h file for iOS
if(IOS)
	set(ios_sdl2main "#ifdef IOS\n #include \"SDL_main.h\"\n #endif \n")
	DKSET(PLUGINS_FILE "${ios_sdl2main} ${PLUGINS_FILE}")
endif()

generateCmake(DKSDLWindow)
