include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/aubio/aubio.git


### IMPORT ###
dk_import(https://github.com/aubio/aubio/archive/refs/heads/master.zip)



### LINK ###
dk_include				(${AUBIO_DIR}/src)
if(MSVC)
	WIN_dk_libDebug		(${AUBIO_DEBUG_DIR}/aubio.lib)
	WIN_dk_libRelease	(${AUBIO_RELEASE_DIR}/aubio.lib)
else()
	dk_libDebug			(${AUBIO_DEBUG_DIR}/libaubio.a)
	dk_libRelease		(${AUBIO_RELEASE_DIR}/libaubio.a)
endif()


### GENERATE ###
dk_configure(${AUBIO})


### COMPILE ###
dk_build	(${AUBIO})