include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://aomedia.googlesource.com/aom.git

dk_todo("aom is on the TODO list.")


### IMPORT ###
dk_import(https://aomedia.googlesource.com/aom.git)


### LINK ###
dk_include(${AOM})
UNIX_dk_libDebug	(${AOM}/${OS}/${DEBUG_DIR}/libaom.a)
UNIX_dk_libRelease	(${AOM}/${OS}/${RELEASE_DIR}/libaom.a)
WIN_TARGET_dk_libDebug		(${AOM}/${OS}/${DEBUG_DIR}/aom.lib)
WIN_TARGET_dk_libRelease	(${AOM}/${OS}/${RELEASE_DIR}/aom.lib)


### GENERATE ###
dk_configure(${AOM} -DAOM_TARGET_CPU=generic)


### COMPILE ###
dk_build(${AOM})
