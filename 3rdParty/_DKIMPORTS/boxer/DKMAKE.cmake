# https://github.com/aaronmjacobs/Boxer.git

if(ANDROID OR RASPBERRY)
	dk_undepend(boxer)
	dk_return()
endif()


### DEPEND ###
dk_depend(cocoa)
dk_depend(libgtk-3-dev)


### IMPORT ###
dk_import(https://github.com/aaronmjacobs/Boxer.git)


### LINK ###
dk_include			(${BOXER}/include)
dk_include			(${BOXER}/${OS})
UNIX_dk_libDebug	(${BOXER}/${OS}/${DEBUG_DIR}/libBoxer.a)
UNIX_dk_libRelease	(${BOXER}/${OS}/${RELEASE_DIR}/libBoxer.a)
WIN_dk_libDebug		(${BOXER}/${OS}/${DEBUG_DIR}/Boxer.lib)
WIN_dk_libRelease	(${BOXER}/${OS}/${RELEASE_DIR}/Boxer.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${BOXER})


### COMPILE ###
dk_build(${BOXER} Boxer)
