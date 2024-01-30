# https://github.com/google/diff-match-patch
# https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip


### IMPORT ###
#dk_import(https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)
dk_import(https://github.com/google/diff-match-patch.git)


### LINK ###
#dk_include			(${DIFF_MATCH_PATCH}/include)
#UNIX_dk_libDebug	(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/libdiff-match-patchd.a)
#UNIX_dk_libRelease	(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/libdiff-match-patch.a)
#WIN_dk_libDebug	(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/diff-match-patchd.lib)
#WIN_dk_libRelease	(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/diff-match-patch.lib)


### GENERATE ###
#dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})


### COMPILE ###
#dk_build(${DIFF_MATCH_PATCH} diff-match-patch)
