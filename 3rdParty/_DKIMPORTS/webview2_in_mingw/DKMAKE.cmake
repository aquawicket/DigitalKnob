#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ webview2_in_mingw ############
dk_import("https://github.com/jchv/webview2-in-mingw/archive/c003dd6e.zip" PATCH)

# CFLAGS += -I./WebView/include
dk_include("${WEBVIEW2_IN_MINGW}/WebView/include")

dk_libDebug("${WEBVIEW2_IN_MINGW_DEBUG_DIR}/webview2.exe")
dk_libRelease("${WEBVIEW2_IN_MINGW_RELEASE_DIR}/webview2.exe")


# LDFLAGS += -L./WebView/x64 -lWebView2Loader -mwindows -static-libgcc -static-libstdc++ -Wl,-Bstatic -lstdc++ -lpthread -Wl,-Bdynamic
dk_configure(${WEBVIEW2_IN_MINGW})



dk_build(${WEBVIEW2_IN_MINGW})

# $(COPY) ./WebView/x64/WebView2Loader.dll to $(OUTDIR)/WebView2Loader.dll



