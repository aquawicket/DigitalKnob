if(NOT LINUX_32)
	return()
endif()

### VERSION ###
DKSET(CEF_VERSION 81.3.3+g072a5f5+chromium-81.0.4044.138)

### INSTALL ###
DKINSTALL(https://cef-builds.spotifycdn.com/cef_binary_${CEF_VERSION}_linux32.tar.bz2 cef_binary_linux32 cef_binary_${CEF_VERSION}_linux32)
DKSET(CEF ${3RDPARTY}/cef_binary_${CEF_VERSION}_linux32)


### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
DKDEFINE(__STDC_FORMAT_MACROS)
DKDEFINE(PSAPI_VERSION=1)
DKDEFINE(NOMINMAX)
DKDEFINE(CEF_SANDBOX)
DKDEFINE(CEF_ATL)

LINUX_INCLUDE(${CEF})
LINUX_DEBUG_LIB(${CEF}/Debug/libcef.so)
LINUX_RELEASE_LIB(${CEF}/${RELEASE_DIR}/libcef.so)
LINUX_DEBUG_LIB(${CEF}/${OS}/Debug/libcef_dll_wrapper/libcef_dll_wrapper.a)
LINUX_RELEASE_LIB(${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
## LINUX_DEBUG_LIB(${CEF}/Debug/cef_sandbox.a)
## LINUX_RELEASE_LIB(${CEF}/${RELEASE_DIR}/cef_sandbox.a)


### COMPILE ###
DKSETPATH(${CEF}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS=-fPIC ${CEF})
LINUX_DEBUG_COMMAND(make libcef_dll_wrapper)

DKSETPATH(${CEF}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=-fPIC ${CEF})
LINUX_RELEASE_COMMAND(make libcef_dll_wrapper)