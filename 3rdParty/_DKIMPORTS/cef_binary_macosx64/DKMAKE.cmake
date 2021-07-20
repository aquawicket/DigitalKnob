if(NOT MAC_64)
	return()
endif()

### VERSION ###
DKSET(CEF_VERSION 81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64)
DKSET(CEF ${3RDPARTY}/cef_binary_${CEF_VERSION})


### INSTALL ###
DKINSTALL(https://cef-builds.spotifycdn.com/cef_binary_81.3.3%2Bg072a5f5%2Bchromium-81.0.4044.138_macosx64.tar.bz2 cef_binary_macosx64 cef_binary_${CEF_VERSION})


### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
## DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)
MAC_INCLUDE(${CEF})
MAC_DEBUG_LIB("${CEF}${DEBUG_DIR}/Chromium Embedded Framework.framework")
MAC_RELEASE_LIB("${CEF}/${RELEASE_DIR}/Chromium Embedded Framework.framework")
MAC_DEBUG_LIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
MAC_RELEASE_LIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
## MAC_DEBUG_LIB(${CEF}${DEBUG_DIR}/cef_sandbox.a)
## MAC_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)


### COMPILE ###
MAC_PATH(${CEF}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${CEF})
MAC_XCODE(cef_binary_${CEF_VERSION} libcef_dll_wrapper)