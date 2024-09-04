include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/aaronmjacobs/Boxer.git

if(ANDROID OR RASPBERRY)
	dk_undepend(boxer)
	dk_return()
endif()


### DEPEND ###
dk_depend(cocoa)
dk_depend(libgtk-3-dev)


### IMPORT ###
#dk_import(https://github.com/aaronmjacobs/Boxer.git)
dk_import(https://github.com/aaronmjacobs/Boxer/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${BOXER}/include)
dk_include			(${BOXER}/${triple})

if(MSVC)
	WIN_dk_libDebug		(${BOXER}/${triple}/${DEBUG_DIR}/Boxer.lib)
	WIN_dk_libRelease	(${BOXER}/${triple}/${RELEASE_DIR}/Boxer.lib)
else()
	dk_libDebug			(${BOXER}/${triple}/${DEBUG_DIR}/libBoxer.a)
	dk_libRelease		(${BOXER}/${triple}/${RELEASE_DIR}/libBoxer.a)
endif()


### GENERATE ###
dk_configure(${BOXER})


### COMPILE ###
dk_build(${BOXER} Boxer)
