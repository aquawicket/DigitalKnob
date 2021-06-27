##TODO - MAKE THIS SCRIPT COMPILE ALL OS VERSIONS OF CEF

IF(WIN_32)
	RETURN()
ENDIF()

### VERSION ###
DKSET(CEF_VERSION cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32)

### INSTALL ###
DKINSTALL(https://cef-builds.spotifycdn.com/${CEF_VERSION}.tar.bz2 cef_binary_windows32 ${CEF_VERSION})
DKSET(CEF ${3RDPARTY}/${CEF_VERSION})


### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
## DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)

WIN32_INCLUDE(${CEF})
WIN32_DEBUG_LIB(${CEF}/Debug/libcef.lib)
WIN32_RELEASE_LIB(${CEF}/Release/libcef.lib)
WIN32_DEBUG_LIB(${CEF}/${OS}/libcef_dll_wrapper/Debug/libcef_dll_wrapper.lib)
WIN32_RELEASE_LIB(${CEF}/${OS}/libcef_dll_wrapper/Release/libcef_dll_wrapper.lib)
## WIN32_DEBUG_LIB(${CEF}/Debug/cef_sandbox.lib)
## WIN32_RELEASE_LIB(${CEF}/Release/cef_sandbox.lib)


### COMPILE ###
DKSETPATH(${CEF}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 -DUSE_SANDBOX=Off ${CEF})
WIN32_VS_DEBUG(${CEF_VERSION} cef.sln libcef_dll_wrapper)
WIN32_VS_RELEASE(${CEF_VERSION} cef.sln libcef_dll_wrapper)
