# https://github.com/google/diff-match-patch
#
# https://github.com/google/diff-match-patch/archive/refs/heads/master.zip

dk_import(https://github.com/google/diff-match-patch.git)
#dk_import(https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)

#dk_set(DIFF_MATCH_PATCH_VERSION 62f2e68)
#dk_set(DIFF_MATCH_PATCH_DL https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)
#dk_set(DIFF_MATCH_PATCH_NAME diff-match-patch-${DIFF_MATCH_PATCH_VERSION})
#dk_set(DIFF_MATCH_PATCH ${3RDPARTY}/${DIFF_MATCH_PATCH_NAME})
#dk_install(${DIFF_MATCH_PATCH_DL} diff-match-patch ${DIFF_MATCH_PATCH})


### LINK ###
# dk_include(${DIFF_MATCH_PATCH}/include)
# WIN_dk_libDebug(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/diff-match-patchd.lib)
# WIN_dk_libRelease(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/diff-match-patch.lib)
# APPLE_dk_libDebug(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/libdiff-match-patchd.a)
# APPLE_dk_libRelease(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/libdiff-match-patch.a)
# LINUX_dk_libDebug(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/libdiff-match-patchd.a)
# LINUX_dk_libRelease(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/libdiff-match-patch.a)
# RASPBERRY_dk_libDebug(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/libdiff-match-patchd.a)
# RASPBERRY_dk_libRelease(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/libdiff-match-patch.a)
# ANDROID_dk_libDebug(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR}/libdiff-match-patchd.a)
# ANDROID_dk_libRelease(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR}/libdiff-match-patch.a)


### COMPILE ###
# WIN_dk_setPath(${DIFF_MATCH_PATCH}/${OS})
# WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# WIN_dk_VisualStudio(${DIFF_MATCH_PATCH_NAME} diff-match-patch.sln diff-match-patch)


# MAC_dk_setPath(${DIFF_MATCH_PATCH}/${OS})
# MAC32_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# MAC_dk_xcode(${DIFF_MATCH_PATCH_NAME} diff-match-patch)


# IOS_dk_setPath(${DIFF_MATCH_PATCH}/${OS})
# IOS32_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# IOS_dk_xcode(${DIFF_MATCH_PATCH_NAME} diff-match-patch)


# IOSSIM_dk_setPath(${DIFF_MATCH_PATCH}/${OS})
# IOSSIM32_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# IOSSIM_dk_xcode(${DIFF_MATCH_PATCH_NAME} diff-match-patch)


# LINUX_DEBUG_dk_setPath(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR})
# LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# LINUX_DEBUG_dk_queueCommand(make diff-match-patch)

# LINUX_RELEASE_dk_setPath(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR})
# LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# LINUX_RELEASE_dk_queueCommand(make diff-match-patch)


# RASPBERRY_DEBUG_dk_setPath(${DIFF_MATCH_PATCH}/${OS}/${DEBUG_DIR})
# RASPBERRY_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# RASPBERRY_DEBUG_dk_queueCommand(make diff-match-patch)

# RASPBERRY_RELEASE_dk_setPath(${DIFF_MATCH_PATCH}/${OS}/${RELEASE_DIR})
# RASPBERRY_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# RASPBERRY_RELEASE_dk_queueCommand(make diff-match-patch)


##ANDROID_dk_ndk(${DIFF_MATCH_PATCH_NAME})
# ANDROID_dk_setPath(${DIFF_MATCH_PATCH}/${OS})
# ANDROID32_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# ANDROID64_dk_queueCommand(${DKCMAKE_BUILD} ${DIFF_MATCH_PATCH})
# ANDROID_dk_VisualStudio(${DIFF_MATCH_PATCH_NAME} diff-match-patch.sln diff-match-patch)
