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


dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_validate(Target_Tuple "dk_Target_Tuple()")
############ webview2_in_mingw ############

dk_import()

dk_assertPath("${webview2_in_mingw}")
dk_include("${webview2_in_mingw}/WebView/include")

set(webview2_in_mingw_Debug_Dir "${webview2_in_mingw}/${Target_Tuple}/Debug")
set(webview2_in_mingw_Release_Dir "${webview2_in_mingw}/${Target_Tuple}/Release")
dk_libDebug("${webview2_in_mingw_Debug_Dir}/webview2.exe")
dk_libRelease("${webview2_in_mingw_Release_Dir}/webview2.exe")

if(Windows_X86)
	set(ARCH "Win32")
else(Windows_X86_64)
	set(ARCH "x64")
endif()
dk_assertVar(ARCH)

set(webview2guid_LIB		"${webview2_in_mingw}/WebView/${ARCH}/WebView2Guid.lib")
set(webview2loader_DLL_LIB	"${webview2_in_mingw}/WebView/${ARCH}/WebView2Loader.dll.lib")
set(webview2loader_DLL		"${webview2_in_mingw}/WebView/${ARCH}/WebView2Loader.dll")

dk_configure(${webview2_in_mingw} -DARCH=${ARCH})

dk_build()

dk_copy(${webview2_in_mingw}/WebView/${ARCH}/WebView2Loader.dll ${webview2_in_mingw_Debug_Dir}/WebView2Loader.dll)
