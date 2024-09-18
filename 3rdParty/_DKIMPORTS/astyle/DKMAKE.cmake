include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# http://astyle.sourceforge.net
# https://sourceforge.net/projects/astyle/files/latest/download
# https://managedway.dl.sourceforge.net/project/astyle/astyle/astyle%203.1/AStyle_3.1_windows.zip
# https://svn.code.sf.net/p/astyle/code/trunk astyle-code


dk_validate(HOST_TRIPLE   "dk_HOST_TRIPLE()")
dk_validate(TARGET_TRIPLE "dk_TARGET_TRIPLE()")
dk_validate(CONFIG_PATH   "dk_MULTI_CONFIG()")
### IMPORT ###
dk_import(https://sourceforge.net/projects/astyle/files/astyle/astyle%203.1/AStyle_3.1_windows.zip)


### LINK ###
dk_include				(${ASTYLE_DIR}/src)
if(MSVC)
	WIN_dk_libDebug		(${ASTYLE_DEBUG_DIR}/AStyleLib.lib)
	WIN_dk_libRelease	(${ASTYLE_RELEASE_DIR}/AStyleLib.lib)
else()
	dk_libDebug			(${ASTYLE_DEBUG_DIR}/libastyle.a)
	dk_libRelease		(${ASTYLE_RELEASE_DIR}/libastyle.a)
endif()


### GENERATE ###
dk_configure(${ASTYLE_DIR})


### COMPILE ###
dk_build(${ASTYLE_DIR})
