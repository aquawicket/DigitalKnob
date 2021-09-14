# Deprecated:  migrated to cef_binary
return()

# https://cef-builds.spotifycdn.com/cef_binary_81.3.3%2Bg072a5f5%2Bchromium-81.0.4044.138_linuxarm.tar.bz2

### VERSION ###
DKSET(CEF_VERSION 81.3.3+g072a5f5+chromium-81.0.4044.138)
DKSET(CEF_NAME cef_binary_${CEF_VERSION}_linuxarm)
DKSET(CEF_DL https://cef-builds.spotifycdn.com/${CEF_NAME}.tar.bz2)
DKSET(CEF ${3RDPARTY}/${CEF_NAME})


### INSTALL ###
DKINSTALL(${CEF_DL} cef_binary_linuxarm ${CEF})


### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)
DKINCLUDE(${CEF})
LINUX_DEBUG_LIB(${CEF}/${DEBUG_DIR}/libcef.so)
LINUX_RELEASE_LIB(${CEF}/${RELEASE_DIR}/libcef.so)
LINUX_DEBUG_LIB(${CEF}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
LINUX_RELEASE_LIB(${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
## LINUX_DEBUG_LIB(${CEF}/${DEBUG_DIR}/cef_sandbox.a)
## LINUX_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)
RASPBERRY_DEBUG_LIB(${CEF}/${DEBUG_DIR}/libcef.so)
RASPBERRY_RELEASE_LIB(${CEF}/${RELEASE_DIR}/libcef.so)
RASPBERRY_DEBUG_LIB(${CEF}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
RASPBERRY_RELEASE_LIB(${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
## RASPBERRY_DEBUG_LIB(${CEF}/${DEBUG_DIR}/cef_sandbox.a)
## RASPBERRY_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)


### COMPILE ###
LINUX_DEBUG_PATH(${CEF}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} ${CEF})
LINUX_DEBUG_COMMAND(make libcef_dll_wrapper)

LINUX_RELEASE_PATH(${CEF}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} ${CEF})
LINUX_RELEASE_COMMAND(make libcef_dll_wrapper)


RASPBERRY_DEBUG_PATH(${CEF}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${DKCMAKE_RASPBERRY_DEBUG} ${CEF})
RASPBERRY_DEBUG_COMMAND(make libcef_dll_wrapper)

RASPBERRY_RELEASE_PATH(${CEF}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${DKCMAKE_RASPBERRY_RELEASE} ${CEF})
RASPBERRY_RELEASE_COMMAND(make libcef_dll_wrapper)