include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/aubio/aubio.git


### IMPORT ###
dk_import(https://github.com/aubio/aubio/archive/refs/heads/master.zip)
#dk_import(https://github.com/aubio/aubio.git)


### LINK ###
dk_include				(${AUBIO}/src)
if(MSVC)
	WIN_dk_libDebug		(${AUBIO}/${OS}/${DEBUG_DIR}/aubio.lib)
	WIN_dk_libRelease	(${AUBIO}/${OS}/${RELEASE_DIR}/aubio.lib)
else()
	dk_libDebug			(${AUBIO}/${OS}/${DEBUG_DIR}/libaubio.a)
	dk_libRelease		(${AUBIO}/${OS}/${RELEASE_DIR}/libaubio.a)
endif()


### GENERATE ###
dk_configure(${AUBIO})


### COMPILE ###
dk_build	(${AUBIO})