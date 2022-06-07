# https://github.com/fmtlib/fmt

DKGITCLONE(https://github.com/fmtlib/fmt.git)

# Head only includes
DKINCLUDE(${FMT}/include)

#TODO: this library can be compiled

### LINK ###
WIN_DEBUG_DKLIB(${FMT}/${OS}/${DEBUG_DIR}/fmt.lib)
WIN_RELEASE_DKLIB(${FMT}/${OS}/${RELEASE_DIR}/fmt.lib)
UNIX_DEBUG_DKLIB(${FMT}/${OS}/${DEBUG_DIR}/fmt.a)
UNIX_RELEASE_DKLIB(${FMT}/${OS}/${RELEASE_DIR}/fmt.a)


### GENERATE ###
DKSETPATH(${FMT}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${FMT})


### COMPILE ###
WIN_VS(${FMT_NAME} fmt.sln fmt)
MAC_XCODE(${FMT_NAME} fmt)
IOS_XCODE(${FMT_NAME} fmt)
IOSSIM_XCODE(${FMT_NAME} fmt)
LINUX_DKQCOMMAND(make fmt)
RASPBERRY_DKQCOMMAND(make fmt)
ANDROID_VS(${FMT_NAME} fmt.sln fmt)