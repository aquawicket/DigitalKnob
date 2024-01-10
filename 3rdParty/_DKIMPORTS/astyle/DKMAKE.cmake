# http://astyle.sourceforge.net
# https://sourceforge.net/projects/astyle/files/latest/download
# https://managedway.dl.sourceforge.net/project/astyle/astyle/astyle%203.1/AStyle_3.1_windows.zip
# https://svn.code.sf.net/p/astyle/code/trunk astyle-code


### IMPORT ###
dk_import(https://sourceforge.net/projects/astyle/files/astyle/astyle%203.1/AStyle_3.1_windows.zip)


### LINK ###
dk_include				(${ASTYLE}/src)
if(MSVC)
	WIN_dk_libDebug		(${ASTYLE}/${OS}/${DEBUG_DIR}/AStyleLib.lib)
	WIN_dk_libRelease	(${ASTYLE}/${OS}/${RELEASE_DIR}/AStyleLib.lib)
else()
	dk_libDebug			(${ASTYLE}/${OS}/${DEBUG_DIR}/libastyle.a)
	dk_libRelease		(${ASTYLE}/${OS}/${RELEASE_DIR}/libastyle.a)
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${ASTYLE})


### COMPILE ###
dk_build(${ASTYLE})
