include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/aubio/aubio.git


dk_validate(HOST_TRIPLE   "dk_getHostTriple()")
dk_validate(TARGET_TRIPLE "dk_getTargetTriple()")
dk_validate(CONFIG_PATH   "dk_getMULTI_CONFIG()")
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
dk_configure(${AUBIO_DIR})


### COMPILE ###
dk_build	(${AUBIO_DIR})