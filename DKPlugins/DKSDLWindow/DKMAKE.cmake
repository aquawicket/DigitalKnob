dk_depend(glew)
dk_depend(sdl)
dk_depend(DKWindow)

# add SDL_main to the top of the DKPlugins.h file for iOS
if(IOS)
	set(ios_sdl2main "#if IOS\n #include \"SDL_main.h\"\n #endif \n")
	dk_set(PLUGINS_FILE "${ios_sdl2main} ${PLUGINS_FILE}")
endif()

dk_generateCmake(DKSDLWindow)
dk_assets(DKSDLWindow)
