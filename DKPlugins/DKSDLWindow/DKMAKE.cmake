dk_depend(glew)
dk_depend(sdl)
dk_depend(DKWindow)

# DKCMake/DKGenerate.cmake will build android with or without GUI per the CMAKE_ANDROID_GUI variable.
if(ANDROID)
	set(CMAKE_ANDROID_GUI 1)
	dk_depend(openjdk)
	dk_depend(openjdk-8u41)
	dk_depend(android-cmdline-tools)
endif()

# add SDL_main to the top of the DKPlugins.h file for iOS
if(IOS)
	set(ios_sdl2main "#if IOS\n #include \"SDL_main.h\"\n #endif \n")
	dk_set(PLUGINS_FILE "${ios_sdl2main} ${PLUGINS_FILE}")
endif()

dk_generateCmake(DKSDLWindow)
