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


if(MAC)
	DKDEPEND(appkit)
endif()

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
WIN_DKINCLUDE(${CEF})
WIN_DEBUG_DKLIB(${CEF}/${DEBUG_DIR}/libcef.lib)
WIN_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/libcef.lib)
WIN_DEBUG_DKLIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.lib)
WIN_RELEASE_DKLIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.lib)
#WIN_DEBUG_DKLIB(${CEF}/${DEBUG_DIR}/cef_sandbox.lib)
#WIN_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/cef_sandbox.lib)
MAC_DKINCLUDE(${CEF})
#MAC_DEBUG_DKLIB("${CEF}${DEBUG_DIR}/Chromium Embedded Framework.framework")
#MAC_RELEASE_DKLIB("${CEF}/${RELEASE_DIR}/Chromium Embedded Framework.framework")
MAC_DEBUG_DKLIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
MAC_RELEASE_DKLIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
## MAC_DEBUG_DKLIB(${CEF}${DEBUG_DIR}/cef_sandbox.a)
## MAC_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)
LINUX_DKINCLUDE(${CEF})
LINUX_DEBUG_DKLIB(${CEF}/${DEBUG_DIR}/libcef.so)
LINUX_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/libcef.so)
LINUX_DEBUG_DKLIB(${CEF}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
LINUX_RELEASE_DKLIB(${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
## LINUX_DEBUG_DKLIB(${CEF}/${DEBUG_DIR}/cef_sandbox.a)
## LINUX_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)
RASPBERRY_DKINCLUDE(${CEF})
RASPBERRY_DEBUG_DKLIB(${CEF}/${DEBUG_DIR}/libcef.so)
RASPBERRY_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/libcef.so)
RASPBERRY_DEBUG_DKLIB(${CEF}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
RASPBERRY_RELEASE_DKLIB(${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
## RASPBERRY_DEBUG_DKLIB(${CEF}/${DEBUG_DIR}/cef_sandbox.a)
## RASPBERRY_RELEASE_DKLIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)


### COMPILE ###
DKSETPATH(${CEF}/${BUILD_DIR})

WIN_DKQCOMMAND(${DKCMAKE_BUILD} -DUSE_SANDBOX=Off ${CEF})
WIN_VS(${CEF_NAME} cef.sln libcef_dll_wrapper)
WIN_VS(${CEF_NAME} cef.sln cefsimple)

MAC_DKQCOMMAND(${DKCMAKE_BUILD} ${CEF})
MAC_XCODE(${CEF_NAME} libcef_dll_wrapper)
MAC_XCODE(${CEF_NAME} cefsimple)

LINUX_DKQCOMMAND(${DKCMAKE_BUILD} ${CEF})
LINUX_DKQCOMMAND(make libcef_dll_wrapper)
LINUX_DKQCOMMAND(make cefsimple)

RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DPROJECT_ARCH="linuxarm" ${CEF})
RASPBERRY_DKQCOMMAND(make libcef_dll_wrapper)
RASPBERRY_DKQCOMMAND(make cefsimple)
