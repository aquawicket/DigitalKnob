include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://aomedia.googlesource.com/aom.git

dk_todo("aom is on the TODO list.")


### IMPORT ###
dk_import(https://aomedia.googlesource.com/aom.git)


### LINK ###
dk_include			(${AOM_DIR})
UNIX_dk_libDebug	(${AOM_DEBUG_DIR}/libaom.a)
UNIX_dk_libRelease	(${AOM_RELEASE_DIR}/libaom.a)
WIN_dk_libDebug		(${AOM_DEBUG_DIR}/aom.lib)
WIN_dk_libRelease	(${AOM_RELEASE_DIR}/aom.lib)


### GENERATE ###
dk_configure(${AOM_DIR} -DAOM_TARGET_CPU=generic)


### COMPILE ###
dk_build(${AOM_DIR})
