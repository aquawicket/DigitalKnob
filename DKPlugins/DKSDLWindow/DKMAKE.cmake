dk_depend(glew)
dk_depend(sdl)
dk_depend(DKWindow)

# DKCMake/DKGenerate.cmake will build android with or without GUI per the CMAKE_ANDROID_GUI variable.
ANDROID_dk_set(CMAKE_ANDROID_GUI 1)
ANDROID_dk_depend(openjdk)
ANDROID_dk_depend(openjdk-8u41)
ANDROID_dk_depend(android-cmdline-tools)

# add SDL_main to the top of the DKPlugins.h file for iOS
if(IOS)
	set(ios_sdl2main "#if IOS\n #include \"SDL_main.h\"\n #endif \n")
	dk_set(PLUGINS_FILE "${ios_sdl2main} ${PLUGINS_FILE}")
endif()

dk_generateCmake(DKSDLWindow)
