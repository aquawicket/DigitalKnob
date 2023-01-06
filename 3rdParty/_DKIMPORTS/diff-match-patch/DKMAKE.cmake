# https://github.com/google/diff-match-patch
# https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip


### IMPORT ###
#dk_import(https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)
dk_import(https://github.com/google/diff-match-patch.git)


### LINK ###
#dk_include			(${DIFF-MATCH-PATCH}/include)
#WIN_dk_libDebug	(${DIFF-MATCH-PATCH}/${OS}/${DEBUG_DIR}/diff-match-patchd.lib)
#WIN_dk_libRelease	(${DIFF-MATCH-PATCH}/${OS}/${RELEASE_DIR}/diff-match-patch.lib)
#UNIX_dk_libDebug	(${DIFF-MATCH-PATCH}/${OS}/${DEBUG_DIR}/libdiff-match-patchd.a)
#UNIX_dk_libRelease	(${DIFF-MATCH-PATCH}/${OS}/${RELEASE_DIR}/libdiff-match-patch.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${DIFF-MATCH-PATCH})


### COMPILE ###
dk_build(${DIFF-MATCH-PATCH_FOLDER} diff-match-patch)
