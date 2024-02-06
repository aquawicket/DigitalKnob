# https://github.com/harfbuzz/harfbuzz.git


### IMPORT ###
dk_import(https://github.com/harfbuzz/harfbuzz.git BRANCH main)


### LINK ###
dk_include		(${HARFBUZZ}/include								HARFBUZZ_INCLUDE_DIR)
dk_libDebug		(${HARFBUZZ}/${OS}/${DEBUG_DIR}/libharfbuzz.lib		HARFBUZZ_DEBUG_LIBRARY)
dk_libRelease	(${HARFBUZZ}/${OS}/${RELEASE_DIR}/libharfbuzz.lib	HARFBUZZ_RELEASE_LIBRARY)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${HARFBUZZ})


### 3RDPARTY LINK ###
DEBUG_dk_set	(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_DEBUG_LIBRARY})
RELEASE_dk_set	(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_RELEASE_LIBRARY})


### COMPILE ###
dk_build(${HARFBUZZ})

