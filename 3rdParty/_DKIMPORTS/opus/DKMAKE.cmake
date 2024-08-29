include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/xiph/opus.git


### IMPORT ###
#dk_import(https://github.com/xiph/opus.git)
dk_import(https://github.com/xiph/opus/archive/refs/heads/main.zip)

### LINK ###
dk_include			(${OPUS}/include)
dk_include			(${OPUS}/${OS})
UNIX_dk_libDebug	(${OPUS}/${OS}/${DEBUG_DIR}/libopus.a)
UNIX_dk_libRelease	(${OPUS}/${OS}/${RELEASE_DIR}/libopus.a)
WIN_TARGET_dk_libDebug		(${OPUS}/${OS}/${DEBUG_DIR}/opus.lib)
WIN_TARGET_dk_libRelease	(${OPUS}/${OS}/${RELEASE_DIR}/opus.lib)


### GENERATE ###
dk_configure(${OPUS})


### COMPILE ###
dk_build(${OPUS})
