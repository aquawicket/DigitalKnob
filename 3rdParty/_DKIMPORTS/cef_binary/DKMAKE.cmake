#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ cef_binary ############
# https://en.wikipedia.org/wiki/Google_Chrome_version_history
# https://cef-builds.spotifycdn.com/index.html
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64.tar.bz2)					### .tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_minimal.tar.bz2)			### _minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_client.tar.bz2)				### _client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_release_symbols.tar.bz2)	### _release_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_debug_symbols.tar.bz2)		### _debug_symbols.tar.bz2
# https://bitbucket.org/chromiumembedded/cef/get/4044.tar.bz2																### cef source
# https://gsdview.appspot.com/chromium-browser-official/chromium-81.0.4044.138.tar.xz										### chromium source

dk_load(dk_builder)
if(IOS OR IOSSIM OR ANDROID OR (WIN AND (NOT MSVC)))
	dk_disable(cef_binary)
	dk_return()
endif()

if(WIN)
  set(CMAKE_OBJECT_PATH_MAX 275)
endif()

###### IMPORT ######
#dk_depend			(visualstudio)
dk_depend			(visual-cpp-build-tools)
dk_depend			(appkit)
dk_depend			(build-essential)
dk_depend			(libgtk2.0-dev)

dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam("${DKIMPORTS_DIR}/cef_binary/dkconfig.txt" CEF_BINARY_VERSION)
#dk_set(CEF_BINARY_VERSION	3.2704.1414.g185cd6c)							# Oldest			
#dk_set(CEF_BINARY_VERSION	128.4.12+g1d7a1f9+chromium-128.0.6613.138)		# Newest

if(LINUX_ARM32)
	dk_set	(CEF_BINARY_OS linuxarm)
elseif(LINUX_ARM64)
	dk_set	(CEF_BINARY_OS linuxarm64)
elseif(LINUX_X86)
	dk_set	(CEF_BINARY_OS linux32)
elseif(LINUX_X86_64)
	dk_set	(CEF_BINARY_OS linux64)
elseif(MAC_ARM64)
	dk_set	(CEF_BINARY_OS macosarm64)
elseif(MAC_X86_64)
	dk_set	(CEF_BINARY_OS macosx64)
elseif(WIN_ARM64)
	dk_set	(CEF_BINARY_OS windowsarm64)
elseif(WIN_X86)
	dk_set		(CEF_BINARY_OS windows32)
elseif(WIN_X86_64)
	dk_set	(CEF_BINARY_OS windows64)
endif()

dk_import			(${CEF_BINARY_DL})
dk_import			(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}.tar.bz2)					### .tar.bz2 ###
#dk_import			(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_minimal.tar.bz2)			### _minimal.tar.bz2 ###
#dk_import			(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_client.tar.bz2)			### _client.tar.bz2 ###
#dk_import			(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_release_symbols.tar.bz2)	### _release_symbols.tar.bz2 ###
#dk_import			(https://cef-builds.spotifycdn.com/cef_binary_${CEF_BINARY_VERSION}_${CEF_BINARY_OS}_debug_symbols.tar.bz2)		### _debug_symbols.tar.bz2 ###

### LINK ###
dk_define			(CEF_ATL)
#dk_define			(CEF_SANDBOX)
dk_define			(NOMINMAX)
dk_define			(PSAPI_VERSION=1)
dk_define			(__STDC_CONSTANT_MACROS)
dk_define			(__STDC_FORMAT_MACROS)
dk_include			(${CEF_BINARY_DIR})

# libcef
if(LINUX)
	dk_libDebug	(${CEF_BINARY_DEBUG_DIR}/libcef.so)
	LINUX_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/libcef.so)
elseif(MAC)
	#dk_libDebug	("${CEF_BINARY}${DEBUG_DIR}/Chromium Embedded Framework.framework")
	#dk_libRelease	("${CEF_BINARY_RELEASE_DIR}/Chromium Embedded Framework.framework")
elseif(WIN)
	dk_libDebug		(${CEF_BINARY_DEBUG_DIR}/libcef.lib)
	dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/libcef.lib)
endif()

# libcef_dll_wrapper
if(LINUX)
	dk_libDebug	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
	dk_libRelease	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
elseif(MAC)
	dk_libDebug		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
	dk_libRelease	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
elseif(WIN)
	dk_libDebug		(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.lib)
	dk_libRelease	(${CEF_CONFIG_DIR}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.lib)
endif()

# cef_sandbox
#LINUX_dk_libDebug	(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.a)
#LINUX_dk_libRelease(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.a)
#MAC_dk_libDebug	(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.a)
#MAC_dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.a)
if(WIN)
	dk_libDebug		(${CEF_BINARY_DEBUG_DIR}/cef_sandbox.lib)
	dk_libRelease	(${CEF_BINARY_RELEASE_DIR}/cef_sandbox.lib)
endif()

### GENERATE ###
dk_configure		(${CEF_BINARY_DIR} -DUSE_SANDBOX=OFF)


### COMPILE ###
dk_build			(${CEF_BINARY_DIR} libcef_dll_wrapper)
dk_build			(${CEF_BINARY_DIR} cefclient)
#dk_build			(${CEF_BINARY_DIR} cefsimple)
#dk_build			(${CEF_BINARY_DIR} cef_gtest)
#dk_build			(${CEF_BINARY_DIR} cef_tests)
