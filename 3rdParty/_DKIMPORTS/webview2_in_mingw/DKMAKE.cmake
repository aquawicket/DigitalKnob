#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ webview2_in_mingw ############
dk_import("https://github.com/jchv/webview2-in-mingw/archive/c003dd6e.zip" PATCH)

dk_include("${WEBVIEW2_IN_MINGW}/WebView/include")

dk_libDebug("${WEBVIEW2_IN_MINGW_DEBUG_DIR}/webview2.exe")
dk_libRelease("${WEBVIEW2_IN_MINGW_RELEASE_DIR}/webview2.exe")

if(WIN_X86)
	set(ARCH "Win32")
else(WIN_X86_64)
	set(ARCH "x64")
endif()

set(WEBVIEW2GUID_LIB		"${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Guid.lib")
set(WEBVIEW2LOADER_DLL_LIB	"${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Loader.dll.lib")
set(WEBVIEW2LOADER_DLL		"${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Loader.dll")

dk_configure(${WEBVIEW2_IN_MINGW} -DARCH=${ARCH})

dk_build(${WEBVIEW2_IN_MINGW})

dk_copy(${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Loader.dll ${WEBVIEW2_IN_MINGW_BUILD_DIR}/WebView2Loader.dll)





