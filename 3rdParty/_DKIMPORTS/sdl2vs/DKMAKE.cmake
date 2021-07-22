## https://github.com/fallahn/sdl2vs

### DEPENDS ###
DKDEPEND(SDL2)
DKDEPEND(SDL2_ttf)
DKDEPEND(SDL2_image)


### VERSION ###
DKSET(SDL2VS_VERSION master)
DKSET(SDL2VS ${3RDPARTY}/sdl2vs-${SDL2VS_VERSION})

### INSTALL ###
DKINSTALL(https://codeload.github.com/fallahn/sdl2vs/zip/${SDL2VS_VERSION} sdl2vs sdl2vs-${SDL2VS_VERSION})
DKCOPY(${3RDPARTY}/_DKIMPORTS/sdl2vs ${SDL2VS} TRUE)
DKREMOVE(${SDL2VS}/libsdl)
DKREMOVE(${SDL2VS}/SDL2_ttf)
DKREMOVE(${SDL2VS}/SDL2/src)
DKCOPY(${SDL2}/${OS}/${DEBUG_DIR}/libhidapi.so ${SDL2VS}/SDL2_GradleApp/app/src/main/jniLibs/armeabi-v7a/libhidapi.so TRUE)

### LINK ###

### COMPILE ###
##WIN_PATH(${SDL2VS}/${OS})
##WIN32_COMMAND(${DKCMAKE_WIN32} ${SDL2VS})
##WIN_VS(sdl2vs-${SDL2VS_VERSION} sdl2vs-${SDL2VS_VERSION}.sln)

