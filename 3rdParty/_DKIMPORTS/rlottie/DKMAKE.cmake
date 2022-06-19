# https://github.com/Samsung/rlottie
#
# https://github.com/Samsung/rlottie/archive/refs/tags/v0.2.zip
# https://github.com/Samsung/rlottie/archive/refs/heads/master.zip



dk_import(https://github.com/Samsung/rlottie.git)

#dk_import(https://github.com/Samsung/rlottie/archive/875626965959d8e269ca22175c8e1ad190696c43.zip)
#dk_set(RLOTTIE_VERSION 0.2)
#dk_set(RLOTTIE_DL https://github.com/Samsung/rlottie/archive/refs/tags/v0.2.zip)
#dk_set(RLOTTIE_NAME rlottie-${RLOTTIE_VERSION})
#dk_set(RLOTTIE ${3RDPARTY}/${RLOTTIE_NAME})
#dk_install(${RLOTTIE_DL} rlottie ${RLOTTIE})#


### LINK ###
dk_include(${RLOTTIE}/inc)
dk_include(${RLOTTIE}/${OS})
WIN_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/rlottie.lib)
WIN_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/rlottie.lib)
MAC_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
MAC_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
IOS_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
IOS_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
IOSSIM_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
IOSSIM_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
LINUX_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
LINUX_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
RASPBERRY_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
RASPBERRY_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
ANDROID_dk_libDebug(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
ANDROID_dk_libRelease(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)


### COMPILE ###
dk_setPath(${RLOTTIE}/${BUILD_DIR})


WIN_dk_queueCommand(${DKCMAKE_BUILD} /EHsc ${RLOTTIE})
WIN_dk_visualStudio(${RLOTTIE_NAME} rlottie.sln rlottie)


MAC_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
MAC_dk_xcode(${RLOTTIE_NAME} rlottie)


IOS_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
IOS_dk_xcode(${RLOTTIE_NAME} rlottie)


IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
IOSSIM_dk_xcode(${RLOTTIE_NAME} rlottie)


LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
LINUX_DEBUG_dk_queueCommand(make rlottie)
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
LINUX_RELEASE_dk_queueCommand(make rlottie)


RASPBERRY_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
RASPBERRY_DEBUG_dk_queueCommand(make rlottie)
RASPBERRY_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
RASPBERRY_RELEASE_dk_queueCommand(make rlottie)


ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
ANDROID_dk_visualStudio(${RLOTTIE_NAME} rlottie.sln rlottie)
