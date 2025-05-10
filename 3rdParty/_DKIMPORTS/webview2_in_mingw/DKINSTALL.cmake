#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_validate(Target_Tuple "dk_Target_Tuple()")
############ webview2_in_mingw ############
dk_import("https://github.com/jchv/webview2-in-mingw/archive/c003dd6e.zip" PATCH)

dk_assertPath("${WEBVIEW2_IN_MINGW}")
dk_include("${WEBVIEW2_IN_MINGW}/WebView/include")

set(WEBVIEW2_IN_MINGW_DEBUG_DIR "${WEBVIEW2_IN_MINGW}/${Target_Tuple}/Debug")
set(WEBVIEW2_IN_MINGW_RELEASE_DIR "${WEBVIEW2_IN_MINGW}/${Target_Tuple}/Release")
dk_libDebug("${WEBVIEW2_IN_MINGW_DEBUG_DIR}/webview2.exe")
dk_libRelease("${WEBVIEW2_IN_MINGW_RELEASE_DIR}/webview2.exe")

if(WIN_X86)
	set(ARCH "Win32")
else(WIN_X86_64)
	set(ARCH "x64")
endif()
dk_assertVar(ARCH)

set(WEBVIEW2GUID_LIB		"${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Guid.lib")
set(WEBVIEW2LOADER_DLL_LIB	"${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Loader.dll.lib")
set(WEBVIEW2LOADER_DLL		"${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Loader.dll")

dk_configure(${WEBVIEW2_IN_MINGW} -DARCH=${ARCH})

dk_build(${WEBVIEW2_IN_MINGW})

dk_copy(${WEBVIEW2_IN_MINGW}/WebView/${ARCH}/WebView2Loader.dll ${WEBVIEW2_IN_MINGW_DEBUG_DIR}/WebView2Loader.dll)





