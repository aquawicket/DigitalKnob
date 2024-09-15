include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/google/diff-match-patch
# https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip


### IMPORT ###
#dk_import(https://github.com/google/diff-match-patch.git)
#dk_import(https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)
dk_import(https://github.com/google/diff-match-patch/archive/refs/heads/master.zip)



### LINK ###
#dk_include			(${DIFF_MATCH_PATCH}/include)
#UNIX_dk_libDebug	(${DIFF_MATCH_PATCH}/${triple}/${DEBUG_DIR}/libdiff-match-patchd.a)
#UNIX_dk_libRelease	(${DIFF_MATCH_PATCH}/${triple}/${RELEASE_DIR}/libdiff-match-patch.a)
#WIN_dk_libDebug	(${DIFF_MATCH_PATCH}/${triple}/${DEBUG_DIR}/diff-match-patchd.lib)
#WIN_dk_libRelease	(${DIFF_MATCH_PATCH}/${triple}/${RELEASE_DIR}/diff-match-patch.lib)


### GENERATE ###
#dk_configure(${DIFF_MATCH_PATCH})


### COMPILE ###
#dk_build(${DIFF_MATCH_PATCH} diff-match-patch)
