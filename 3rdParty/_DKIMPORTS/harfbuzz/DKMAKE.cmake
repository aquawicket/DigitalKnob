# https://github.com/harfbuzz/harfbuzz.git

dk_import(https://github.com/harfbuzz/harfbuzz.git BRANCH main)

dk_libDebug			(${HARFBUZZ}/${OS}/${DEBUG_DIR}/libharfbuzz.lib)
dk_libRelease		(${HARFBUZZ}/${OS}/${RELEASE_DIR}/libharfbuzz.lib)

dk_queueCommand(${DKCMAKE_BUILD} ${HARFBUZZ})
#HARFBUZZ_LIBRARY 
#HARFBUZZ_INCLUDE_DIR


dk_build(${HARFBUZZ})

