# https://en.wikipedia.org/wiki/Google_Chrome_version_history
#
# https://cef-builds.spotifycdn.com/index.html
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux32.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64.tar.bz2


### VERSION ###
DKSET(CEF_VERSION 81.3.3+g072a5f5+chromium-81.0.4044.138)
WIN32_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_windows32)
WIN64_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_windows64)
MAC64_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_macosx64)
LINUX32_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_linux32)
LINUX64_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_linux64)
RASPBERRY32_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_linuxarm)
RASPBERRY64_DKSET(CEF_NAME cef_binary_${CEF_VERSION}_linuxarm64)
DKSET(CEF_DL https://cef-builds.spotifycdn.com/${CEF_NAME}.tar.bz2)
DKSET(CEF ${3RDPARTY}/${CEF_NAME})


### INSTALL ###
DKINSTALL(${CEF_DL} cef_binary ${CEF})


### DKPLUGINS LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
#DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)
WIN_INCLUDE(${CEF})
WIN_DEBUG_LIB(${CEF}/${DEBUG_DIR}/libcef.lib)
WIN_RELEASE_LIB(${CEF}/${RELEASE_DIR}/libcef.lib)
WIN_DEBUG_LIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.lib)
WIN_RELEASE_LIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.lib)
#WIN_DEBUG_LIB(${CEF}/${DEBUG_DIR}/cef_sandbox.lib)
#WIN_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.lib)
LINUX_INCLUDE(${CEF})
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
WIN_PATH(${CEF}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} -DUSE_SANDBOX=Off ${CEF})
WIN64_COMMAND(${DKCMAKE_WIN64} -DUSE_SANDBOX=Off ${CEF})
WIN_VS(${CEF_NAME} cef.sln libcef_dll_wrapper)
WIN_VS(${CEF_NAME} cef.sln cefclient)



MAC_INCLUDE(${CEF})
MAC_DEBUG_LIB("${CEF}${DEBUG_DIR}/Chromium Embedded Framework.framework")
MAC_RELEASE_LIB("${CEF}/${RELEASE_DIR}/Chromium Embedded Framework.framework")
MAC_DEBUG_LIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
MAC_RELEASE_LIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
## MAC_DEBUG_LIB(${CEF}${DEBUG_DIR}/cef_sandbox.a)
## MAC_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)



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
