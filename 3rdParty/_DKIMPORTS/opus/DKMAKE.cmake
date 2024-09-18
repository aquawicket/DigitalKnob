include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/xiph/opus.git


### IMPORT ###
#dk_import(https://github.com/xiph/opus.git)
dk_import(https://github.com/xiph/opus/archive/refs/heads/main.zip)

### LINK ###
dk_include			(${OPUS}/include)
dk_include			(${OPUS}/${triple})
UNIX_dk_libDebug	(${OPUS}/${triple}/${DEBUG_DIR}/libopus.a)
UNIX_dk_libRelease	(${OPUS}/${triple}/${RELEASE_DIR}/libopus.a)
WIN_dk_libDebug		(${OPUS}/${triple}/${DEBUG_DIR}/opus.lib)
WIN_dk_libRelease	(${OPUS}/${triple}/${RELEASE_DIR}/opus.lib)


### GENERATE ###
dk_configure(${OPUS})


### COMPILE ###
dk_build(${OPUS})
