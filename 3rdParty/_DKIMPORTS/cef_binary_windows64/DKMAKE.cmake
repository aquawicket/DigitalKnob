if(NOT WIN_64)
	return()
endif()

### VERSION ###
DKSET(CEF_VERSION cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64)
DKSET(CEF ${3RDPARTY}/cef_binary_${CEF_VERSION})



### INSTALL ###
DKINSTALL(https://cef-builds.spotifycdn.com/cef_binary_${CEF_VERSION}.tar.bz2 cef_binary_windows64 cef_binary_${CEF_VERSION})



### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
## DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)
WIN64_INCLUDE(${CEF})
WIN64_DEBUG_LIB(${CEF}/${DEBUG}/libcef.lib)
WIN64_RELEASE_LIB(${CEF}/${RELEASE}/libcef.lib)
WIN64_DEBUG_LIB(${CEF}/${OS}/libcef_dll_wrapper/${DEBUG}/libcef_dll_wrapper.lib)
WIN64_RELEASE_LIB(${CEF}/${OS}/libcef_dll_wrapper/${RELEASE}/libcef_dll_wrapper.lib)
## WIN64_DEBUG_LIB(${CEF}/${DEBUG}/cef_sandbox.lib)
## WIN64_RELEASE_LIB(${CEF}/${RELEASE}/cef_sandbox.lib)


### COMPILE ###
WIN_PATH(${CEF}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 -DUSE_SANDBOX=Off ${CEF})
WIN_VS(cef_binary_${CEF_VERSION} cef.sln libcef_dll_wrapper)
