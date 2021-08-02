if(NOT WIN_64)
	return()
endif()

### VERSION ###
DKSET(CEF_VERSION 81.3.3+g072a5f5+chromium-81.0.4044.138_windows64)
DKSET(CEF_NAME cef_binary_${CEF_VERSION})
DKSET(CEF ${3RDPARTY}/${CEF_NAME})


### INSTALL ###
## https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64.tar.bz2
DKINSTALL(https://cef-builds.spotifycdn.com/${CEF_NAME}.tar.bz2 cef_binary_windows64 ${CEF})



### DKPLUGINS LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
## DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)
WIN64_INCLUDE(${CEF})
WIN64_DEBUG_LIB(${CEF}/${DEBUG_DIR}/libcef.lib)
WIN64_RELEASE_LIB(${CEF}/${RELEASE_DIR}/libcef.lib)
WIN64_DEBUG_LIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.lib)
WIN64_RELEASE_LIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.lib)
## WIN64_DEBUG_LIB(${CEF}/${DEBUG_DIR}/cef_sandbox.lib)
## WIN64_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.lib)


### COMPILE ###
WIN_PATH(${CEF}/${OS})
WIN64_COMMAND(${DKCMAKE_WIN64} -DUSE_SANDBOX=Off ${CEF})
WIN_VS(${CEF_NAME} cef.sln libcef_dll_wrapper)
WIN_VS(${CEF_NAME} cef.sln cefclient)