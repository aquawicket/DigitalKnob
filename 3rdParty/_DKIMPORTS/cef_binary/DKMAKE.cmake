include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://en.wikipedia.org/wiki/Google_Chrome_version_history
# https://cef-builds.spotifycdn.com/index.html
#

# WINDOWS x86
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32_client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32_debug_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32_release_symbols.tar.bz2
#
# WINDOWS x86_64
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_debug_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_release_symbols.tar.bz2
#
# WINDOWS arm64
# https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64_client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64_debug_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64_release_symbols.tar.bz2
#
# MACOS x86_64
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64_client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64_debug_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64_release_symbols.tar.bz2
#
# MACOS arm64
# https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64_client.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64_debug_symbols.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64_release_symbols.tar.bz2
#
# LINUX x86
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux32.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux32_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux32_client.tar.bz2
#
# LINUX x86_64
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux64_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux64_client.tar.bz2
#
# LINUX arm32
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm_client.tar.bz2
#
# LINUX arm64
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64_minimal.tar.bz2
# https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64_client.tar.bz2

if(IOS OR IOSSIM OR ANDROID)
	dk_undepend(cef_binary)
	dk_return()
endif()

dk_depend(appkit)
dk_depend(build-essential)
dk_depend(libgtk2.0-dev)


#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32.tar.bz2)
#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_83.5.0+gbf03589+chromium-83.0.4103.106_windows32.tar.bz2)
WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_84.4.1+gfdc7504+chromium-84.0.4147.105_windows32.tar.bz2)
#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_85.3.13+gcd6cbe0+chromium-85.0.4183.121_windows32.tar.bz2)
#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_86.0.24+g85e79d4+chromium-86.0.4240.198_windows32.tar.bz2)
#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2)
#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_97.1.9+ga00bca5+chromium-97.0.4692.99_windows32.tar.bz2)
#WIN_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_111.2.6+g491d238+chromium-111.0.5563.65_windows32.tar.bz2)

#WIN_X86_dk_download		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32_debug_symbols.tar.bz2)
#WIN_X86_dk_extract			(${DKDOWNLOAD_DIR}/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows32_debug_symbols.tar.bz2)
WIN_X86_64_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64.tar.bz2)
#WIN_X86_64_dk_download		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_windows64_debug_symbols.tar.bz2)
# WINARM64_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64.tar.bz2)
# WINARM64_dk_download		(https://cef-builds.spotifycdn.com/cef_binary_88.1.4+g5a6ab23+chromium-88.0.4324.96_windowsarm64_debug_symbols.tar.bz2)
APPLE_dk_import				(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64.tar.bz2)
#APPLE_dk_download			(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_macosx64_debug_symbols.tar.bz2)
# MACARM64_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64.tar.bz2)
# MACARM64_dk_download		(https://cef-builds.spotifycdn.com/cef_binary_88.1.6+g4fe33a1+chromium-88.0.4324.96_macosarm64_debug_symbols.tar.bz2)
LINUX_X86_dk_import			(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux32.tar.bz2)
LINUX_X86_64_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linux64.tar.bz2)
# LINUXARM32_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm.tar.bz2)
# LINUXARM64_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64.tar.bz2)
RASPBERRY_ARM32_dk_import	(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm.tar.bz2)
RASPBERRY_ARM64_dk_import	(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64.tar.bz2)
ANDROID_ARM32_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm.tar.bz2)
ANDROID_ARM64_dk_import		(https://cef-builds.spotifycdn.com/cef_binary_81.3.3+g072a5f5+chromium-81.0.4044.138_linuxarm64.tar.bz2)


### LINK ###
dk_define	(CEF_ATL)
#dk_define	(CEF_SANDBOX)
dk_define	(NOMINMAX)
dk_define	(PSAPI_VERSION=1)
dk_define	(__STDC_CONSTANT_MACROS)
dk_define	(__STDC_FORMAT_MACROS)
dk_include	(${CEF_BINARY})

# libcef
ANDROID_dk_libDebug		(${CEF_BINARY}/${DEBUG_DIR}/libcef.a)
ANDROID_dk_libRelease	(${CEF_BINARY}/${RELEASE_DIR}/libcef.a)
#APPLE_dk_libDebug		("${CEF_BINARY}${DEBUG_DIR}/Chromium Embedded Framework.framework")
#APPLE_dk_libRelease	("${CEF_BINARY}/${RELEASE_DIR}/Chromium Embedded Framework.framework")
LINUX_dk_libDebug		(${CEF_BINARY}/${DEBUG_DIR}/libcef.so)
LINUX_dk_libRelease		(${CEF_BINARY}/${RELEASE_DIR}/libcef.so)
RASPBERRY_dk_libDebug	(${CEF_BINARY}/${DEBUG_DIR}/libcef.so)
RASPBERRY_dk_libRelease	(${CEF_BINARY}/${RELEASE_DIR}/libcef.so)
WIN_dk_libDebug			(${CEF_BINARY}/${DEBUG_DIR}/libcef.lib)
WIN_dk_libRelease		(${CEF_BINARY}/${RELEASE_DIR}/libcef.lib)

# libcef_dll_wrapper
ANDROID_dk_libDebug		(${CEF_BINARY}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
ANDROID_dk_libRelease	(${CEF_BINARY}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
APPLE_dk_libDebug		(${CEF_BINARY}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.a)
APPLE_dk_libRelease		(${CEF_BINARY}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.a)
LINUX_dk_libDebug		(${CEF_BINARY}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
LINUX_dk_libRelease		(${CEF_BINARY}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
RASPBERRY_dk_libDebug	(${CEF_BINARY}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
RASPBERRY_dk_libRelease	(${CEF_BINARY}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper/libcef_dll_wrapper.a)
WIN_dk_libDebug			(${CEF_BINARY}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}/libcef_dll_wrapper.lib)
WIN_dk_libRelease		(${CEF_BINARY}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}/libcef_dll_wrapper.lib)

# cef_sandbox
#ANDROID_dk_libDebug	(${CEF_BINARY}/${DEBUG_DIR}/cef_sandbox.a)
#ANDROID_dk_libRelease	(${CEF_BINARY}/${RELEASE_DIR}/cef_sandbox.a)
#APPLE_dk_libDebug		(${CEF_BINARY}${DEBUG_DIR}/cef_sandbox.a)
#APPLE_dk_libRelease	(${CEF_BINARY}/${RELEASE_DIR}/cef_sandbox.a)
#LINUX_dk_libDebug		(${CEF_BINARY}/${DEBUG_DIR}/cef_sandbox.a)
#LINUX_dk_libRelease	(${CEF_BINARY}/${RELEASE_DIR}/cef_sandbox.a)
#RASPBERRY_dk_libDebug	(${CEF_BINARY}/${DEBUG_DIR}/cef_sandbox.a)
#RASPBERRY_dk_libRelease(${CEF_BINARY}/${RELEASE_DIR}/cef_sandbox.a)
#WIN_dk_libDebug		(${CEF_BINARY}/${DEBUG_DIR}/cef_sandbox.lib)
#WIN_dk_libRelease		(${CEF_BINARY}/${RELEASE_DIR}/cef_sandbox.lib)


### GENERATE ###
ANDROID_dk_configure	(${CEF_BINARY} -DUSE_SANDBOX=OFF -DPROJECT_ARCH="linuxarm")
APPLE_dk_configure		(${CEF_BINARY} -DUSE_SANDBOX=OFF)
LINUX_dk_configure		(${CEF_BINARY} -DUSE_SANDBOX=OFF)
RASPBERRY_dk_configure	(${CEF_BINARY} -DUSE_SANDBOX=OFF -DPROJECT_ARCH="linuxarm")
WIN_dk_configure		(${CEF_BINARY} -DUSE_SANDBOX=OFF)


### COMPILE ###
dk_build(${CEF_BINARY} libcef_dll_wrapper)
dk_build(${CEF_BINARY} cefsimple)
#dk_build(${CEF_BINARY} cefsandbox)
