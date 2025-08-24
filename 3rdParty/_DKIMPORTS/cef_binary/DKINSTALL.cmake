#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


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

dk_validate(Target_Config  "dk_Target_Config()")
if(IOS OR Iossim OR Android OR (Windows AND (NOT MSVC)))
	dk_disable(cef_binary)
	dk_return()
endif()

if(Windows)
  set(CMAKE_OBJECT_PATH_MAX 275)
endif()

###### IMPORT ######
dk_depend			(visualstudio)
dk_depend			(appkit)
dk_depend			(build-essential)
dk_depend			(libgtk2.0-dev)

dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_set(CEF_BINARY_VERSION	3.2704.1414.g185cd6c)							# Oldest			
#dk_set(CEF_BINARY_VERSION	128.4.12+g1d7a1f9+chromium-128.0.6613.138)		# Newest

if(Linux_Arm32)
	dk_set	(CEF_BINARY_OS linuxarm)
elseif(lLinux_Arm64)
	dk_set	(CEF_BINARY_OS linuxarm64)
elseif(Linux_X86)
	dk_set	(CEF_BINARY_OS linux32)
elseif(Linux_X86_64)
	dk_set	(CEF_BINARY_OS linux64)
elseif(Mac_Arm64)
	dk_set	(CEF_BINARY_OS macosarm64)
elseif(Mac_X86_64)
	dk_set	(CEF_BINARY_OS macosx64)
elseif(Windows_Arm64)
	dk_set	(CEF_BINARY_OS windowsarm64)
elseif(Windows_X86)
	dk_set		(CEF_BINARY_OS windows32)
elseif(Windows_X86_64)
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
dk_include			(${CEF_BINARY})

# libcef
if(Linux)
	dk_libDebug	(${CEF_BINARY.Debug_Dir}/libcef.so)
	Linux_dk_libRelease	(${CEF_BINARY.Release_Dir}/libcef.so)
elseif(Mac)
	#dk_libDebug	("${CEF_BINARY}${Debug_Dir}/Chromium Embedded Framework.framework")
	#dk_libRelease	("${CEF_BINARY.Release_Dir}/Chromium Embedded Framework.framework")
elseif(Windows)
	dk_libDebug		(${CEF_BINARY.Debug_Dir}/libcef.lib)
	dk_libRelease	(${CEF_BINARY.Release_Dir}/libcef.lib)
endif()

# libcef_dll_wrapper
if(Linux)
	dk_libDebug	(${CEF.Config_Dir}/libcef_dll_wrapper/libcef_dll_wrapper.a)
	dk_libRelease	(${CEF.Config_Dir}/libcef_dll_wrapper/libcef_dll_wrapper.a)
elseif(Mac)
	dk_libDebug		(${CEF.Config_Dir}/libcef_dll_wrapper/${Debug_Dir}/libcef_dll_wrapper.a)
	dk_libRelease	(${CEF.Config_Dir}/libcef_dll_wrapper/${Release_Dir}/libcef_dll_wrapper.a)
elseif(Windows)
	dk_libDebug		(${CEF.Config_Dir}/libcef_dll_wrapper/${Debug_Dir}/libcef_dll_wrapper.lib)
	dk_libRelease	(${CEF.Config_Dir}/libcef_dll_wrapper/${Release_Dir}/libcef_dll_wrapper.lib)
endif()

# cef_sandbox
#Linux_dk_libDebug	(${CEF_BINARY.Debug_Dir}/cef_sandbox.a)
#Linux_dk_libRelease(${CEF_BINARY.Release_Dir}/cef_sandbox.a)
#Mac_dk_libDebug	(${CEF_BINARY.Debug_Dir}/cef_sandbox.a)
#Mac_dk_libRelease	(${CEF_BINARY.Release_Dir}/cef_sandbox.a)
if(Windows)
	dk_libDebug		(${CEF_BINARY.Debug_Dir}/cef_sandbox.lib)
	dk_libRelease	(${CEF_BINARY.Release_Dir}/cef_sandbox.lib)
endif()

### GENERATE ###
dk_configure		(${CEF_BINARY} -DUSE_SANDBOX=OFF)


### COMPILE ###
dk_build			(${CEF_BINARY} libcef_dll_wrapper)
dk_build			(${CEF_BINARY} cefclient)
#dk_build			(${CEF_BINARY} cefsimple)
#dk_build			(${CEF_BINARY} cef_gtest)
#dk_build			(${CEF_BINARY} cef_tests)
