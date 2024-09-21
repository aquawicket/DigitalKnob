include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)

# https://github.com/wxWidgets/wxWidgets.git



dk_import(https://github.com/wxWidgets/wxWidgets/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${WXWIDGETS_DIR}/include)
UNIX_dk_libDebug	(${WXWIDGETS_DEBUG_DIR}/libwxwidgets.a)
UNIX_dk_libRelease	(${WXWIDGETS_RELEASE_DIR}/libwxwidgets.a)
WIN_dk_libDebug		(${WXWIDGETS_DEBUG_DIR}/wxwidgets.lib)
WIN_dk_libRelease	(${WXWIDGETS_RELEASE_DIR}/wxwidgets.lib)


### GENERATE ###
dk_configure(${WXWIDGETS_DIR})


### COMPILE ###
dk_build(${WXWIDGETS_DIR})