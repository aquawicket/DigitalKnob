# Obsolete - replaced by RmlUi
# https://github.com/libRocket/libRocket.git
# https://github.com/libRocket/libRocket/archive/master.zip


### DEPEND ###
dk_depend(freetype)


### IMPORT ###
dk_import(https://github.com/libRocket/libRocket.git)


### LINK ###
dk_define				(ROCKET_STATIC_LIB)
dk_include				(${LIBROCKET}/Include)

# RocketDebugger
UNIX_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
UNIX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
WIN_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/RocketDebugger.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketDebugger.lib)

# RocketControls
UNIX_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
UNIX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
WIN_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/RocketControls.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketControls.lib)

# RocketCore
UNIX_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
UNIX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
WIN_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/RocketCore.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketCore.lib)


### GENERATE ###
UNIX_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-I${LIBROCKET}/Include" ${FREETYPE_CMAKE} ${LIBROCKET})
WIN_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${LIBROCKET}/Include" ${FREETYPE_CMAKE} ${LIBROCKET})


### COMPILE ###
dk_build(${LIBROCKET})
