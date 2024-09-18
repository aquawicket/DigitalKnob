include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://en.wikipedia.org/wiki/Google_Chrome_version_history
# https://cef-builds.spotifycdn.com/index.html
#
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64.tar.bz2)					### .tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_minimal.tar.bz2)			### _minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_client.tar.bz2)				### _client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_release_symbols.tar.bz2)	### _release_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_debug_symbols.tar.bz2)		### _debug_symbols.tar.bz2
# https://bitbucket.org/chromiumembedded/cef/get/4044.tar.bz2																### cef source
# https://gsdview.appspot.com/chromium-browser-official/chromium-81.0.4044.138.tar.xz										### chromium source

if(IOS OR IOSSIM OR ANDROID)
	dk_undepend(cef_binary)
	dk_return()
endif()

if(WIN32)
  set(CMAKE_OBJECT_PATH_MAX 275)
endif()

dk_depend(visualstudio)
dk_depend(appkit)
dk_depend(build-essential)
dk_depend(libgtk2.0-dev)

dk_set(CEF_BINARY_VERSION	81.3.3+g072a5f5+chromium-81.0.4044.138)
#dk_set(CEF_BINARY_VERSION	83.5.0+gbf03589+chromium-83.0.4103.106)
#dk_set(CEF_BINARY_VERSION	84.4.1+gfdc7504+chromium-84.0.4147.105)
#dk_set(CEF_BINARY_VERSION	85.3.13+gcd6cbe0+chromium-85.0.4183.121)
#dk_set(CEF_BINARY_VERSION	86.0.24+g85e79d4+chromium-86.0.4240.198)
#dk_set(CEF_BINARY_VERSION	88.1.4+g5a6ab23+chromium-88.0.4324.96)
#dk_set(CEF_BINARY_VERSION	88.1.6+g4fe33a1+chromium-88.0.4324.96)
#dk_set(CEF_BINARY_VERSION	90.6.7+g19ba721+chromium-90.0.4430.212)
#dk_set(CEF_BINARY_VERSION	97.1.9+ga00bca5+chromium-97.0.4692.99)
#dk_set(CEF_BINARY_VERSION	111.2.6+g491d238+chromium-111.0.5563.65)
#dk_set(CEF_BINARY_VERSION	126.2.12%2Bg162c3d6%2Bchromium-126.0.6478.127)

LINUX_ARM32_dk_set	(CEF_BINARY_OS linuxarm)
LINUX_ARM64_dk_set	(CEF_BINARY_OS linuxarm64)
LINUX_X86_dk_set	(CEF_BINARY_OS linux32)
LINUX_X86_64_dk_set	(CEF_BINARY_OS linux64)
MAC_ARM64_dk_set	(CEF_BINARY_OS macosarm64)
MAC_X86_64_dk_set	(CEF_BINARY_OS macosx64)
WIN_ARM64_dk_set	(CEF_BINARY_OS windowsarm64)
WIN_X86_dk_set		(CEF_BINARY_OS windows32)
WIN_X86_64_dk_set	(CEF_BINARY_OS windows64)
	
dk_import				(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}.tar.bz2)					### .tar.bz2 ###
dk_import				(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_minimal.tar.bz2)			### _minimal.tar.bz2 ###
dk_import				(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_client.tar.bz2)			### _client.tar.bz2 ###
dk_import				(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_release_symbols.tar.bz2)	### _release_symbols.tar.bz2 ###
dk_import				(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_debug_symbols.tar.bz2)		### _debug_symbols.tar.bz2 ###




### LINK ###
dk_define	(CEF_ATL)
#dk_define	(CEF_SANDBOX)
dk_define	(NOMINMAX)
dk_define	(PSAPI_VERSION=1)
dk_define	(__STDC_CONSTANT_MACROS)
dk_define	(__STDC_FORMAT_MACROS)
dk_include	(${CEF_BINARY_DIR})

# libcef
ANDROID_dk_libDebug		(${CEF_BINARY_DEBUG_DIR}/libcef.a)
ANDROID_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/libcef.a)
#APPLE_dk_libDebug		("${CEF_BINARY}${DEBUG_DIR}/Chromium Embedded Framework.framework")
#APPLE_dk_libRelease	("${CEF_BINARY_RELEASE_DIR}/Chromium Embedded Framework.framework")
LINUX_dk_libDebug		(${CEF_BINARY_DEBUG_DIR}/libcef.so)
LINUX_dk_libRelease		(${CEF_BINARY_RELEASE_DIR}/libcef.so)
RASPBERRY_dk_libDebug	(${CEF_BINARY_DEBUG_DIR}/libcef.so)
RASPBERRY_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/libcef.so)
WIN_dk_libDebug			(${CEF_BINARY_DEBUG_DIR}/libcef.lib)
WIN_dk_libRelease		(${CEF_BINARY_RELEASE_DIR}/libcef.lib)

# libcef_dll_wrapper
ANDROID_dk_libDebug		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
ANDROID_dk_libRelease	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
APPLE_dk_libDebug		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
APPLE_dk_libRelease		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
LINUX_dk_libDebug		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
LINUX_dk_libRelease		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
RASPBERRY_dk_libDebug	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
RASPBERRY_dk_libRelease	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
WIN_dk_libDebug			(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.lib)
WIN_dk_libRelease		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.lib)

# cef_sandbox
#ANDROID_dk_libDebug	(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.a)
#ANDROID_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.a)
#APPLE_dk_libDebug		(${CEF_BINARY}${DEBUG_DIR}/cef_sandbox.a)
#APPLE_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.a)
#LINUX_dk_libDebug		(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.a)
#LINUX_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.a)
#RASPBERRY_dk_libDebug	(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.a)
#RASPBERRY_dk_libRelease(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.a)
#WIN_dk_libDebug		(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.lib)
#WIN_dk_libRelease		(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.lib)


### GENERATE ###
ANDROID_dk_configure	(${CEF_BINARY_DIR} -DUSE_SANDBOX=OFF -DPROJECT_ARCH="linuxarm")
APPLE_dk_configure		(${CEF_BINARY_DIR} -DUSE_SANDBOX=OFF)
LINUX_dk_configure		(${CEF_BINARY_DIR} -DUSE_SANDBOX=OFF)
RASPBERRY_dk_configure	(${CEF_BINARY_DIR} -DUSE_SANDBOX=OFF -DPROJECT_ARCH="linuxarm")
WIN_dk_configure		(${CEF_BINARY_DIR} -DUSE_SANDBOX=OFF)


### COMPILE ###
dk_build(${CEF_BINARY_DIR} libcef_dll_wrapper)
dk_build(${CEF_BINARY_DIR} cefsimple)
#dk_build(${CEF_BINARY} cefsandbox)
