# https://github.com/sammycage/lunasvg.git

dk_import(https://github.com/sammycage/lunasvg.git)

dk_libDebug			(${LUNASVG}/${OS}/${DEBUG_DIR}/liblunasvg.a)
dk_libRelease		(${LUNASVG}/${OS}/${RELEASE_DIR}/liblunasvg.a)

dk_queueCommand(${DKCMAKE_BUILD} ${LUNASVG})

dk_build(${LUNASVG})