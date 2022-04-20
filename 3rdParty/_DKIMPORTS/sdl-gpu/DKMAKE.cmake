# https://github.com/grimfang4/sdl-gpu


DKDEPEND(sdl)

#DKIMPORT(https://github.com/grimfang4/sdl-gpu)
DKIMPORT(https://github.com/grimfang4/sdl-gpu/archive/b21d5bed8d1bbbbc236060a04ce076950faac05c.zip)
#DKIMPORT(https://github.com/grimfang4/sdl-gpu/archive/b21d5bed8d1bbbbc236060a04ce076950faac05c.zip)
#DKSET(SDL-GPU_VERSION master)
#DKSET(SDL-GPU_NAME sdl-gpu-${SDL-GPU_VERSION})
#DKSET(SDL-GPU_DL https://github.com/grimfang4/sdl-gpu/archive/refs/heads/master.zip)
#DKSET(SDL-GPU ${3RDPARTY}/${SDL-GPU_NAME})
#DKINSTALL(${SDL-GPU_DL} sdl-gpu ${SDL-GPU})


### DKPLUGINS LINK ###
DKINCLUDE(${SDL-GPU}/include)
WIN_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/Debug/SDL2_gpu_s.lib)
WIN_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/Release/SDL2_gpu_s.lib)
MAC_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Debug/libSDL2_gpu.a)
MAC_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Release/libSDL2_gpu.a)
IOS_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Debug/libSDL2_gpu_s.a)
IOS_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Release/libSDL2_gpu_s.a)
IOSSIM_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Debug/libSDL2_gpu_s.a)
IOSSIM_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Release/libSDL2_gpu_s.a)
LINUX_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Debug/libSDL2_gpu_s.a)
LINUX_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Release/libSDL2_gpu_s.a)
RASPBERRY_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Debug/libSDL2_gpu_s.a)
RASPBERRY_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu/lib/Release/libSDL2_gpu_s.a)
ANDROID_DEBUG_DKLIB(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/Debug/libSDL2_gpu_s.a)
ANDROID_RELEASE_DKLIB(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/Release/libSDL2_gpu_s.a)
#DKLIB(${SDL-GPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)



### COMPILE ###
DKSETPATH(${SDL-GPU}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SDL-GPU})


WIN_VS(${SDL-GPU_NAME} SDL_gpu.sln SDL_gpu)
MAC_XCODE(${SDL-GPU_NAME} SDL_gpu)
IOS_XCODE(${SDL-GPU_NAME} SDL_gpu)
IOSSIM_XCODE(${SDL-GPU_NAME} SDL_gpu)
LINUX_DKQCOMMAND(make SDL_gpu)
RASPBERRY_DKQCOMMAND(make SDL_gpu)
ANDROID_VS(${SDL-GPU_NAME} SDL_gpu.sln SDL_gpu)
