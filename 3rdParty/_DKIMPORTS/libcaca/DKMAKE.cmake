# https://github.com/cacalabs/libcaca
# http://caca.zoy.org/wiki/libcaca


dk_import(https://github.com/cacalabs/libcaca)
#dk_set(CACA_VERSION 0.99.beta19)
#dk_set(CACA_NAME libcaca-${CACA_VERSION})
#dk_set(CACA_DL http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz)
#dk_set(CACA ${3RDPARTY}/${CACA_NAME})
#dk_install(${CACA_DL} libcaca ${CACA})


### LINK ###
dk_include(${CACA}/include)
dk_include(${CACA}/${OS})
WIN_dk_libDebug(${CACA}/${OS}/${DEBUG_DIR}/libcacad.lib)
WIN_dk_libRelease(${CACA}/${OS}/${RELEASE_DIR}/libcaca.lib)
APPLE_dk_libDebug(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
APPLE_dk_libRelease(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)
LINUX_dk_libDebug(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
LINUX_dk_libRelease(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)
RASPBERRY_dk_libDebug(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
RASPBERRY_dk_libRelease(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)
ANDROID_dk_libDebug(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
ANDROID_dk_libRelease(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)


### COMPILE ###
dk_setPath(${CACA}/${OS})
dk_queueCommand(${DKCMAKE_BUILD} ${CACA})

WIN_dk_VisualStudio(${CACA_NAME} libcaca.sln libcaca)
MAC_dk_xcode(${CACA_NAME} libcaca)
IOS_dk_xcode(${CACA_NAME} libcaca)
IOSSIM_dk_xcode(${CACA_NAME} libcaca)
LINUX_dk_queueCommand(make libcaca)
RASPBERRY_dk_queueCommand(make libcaca)
ANDROID_dk_VisualStudio(${CACA_NAME} libcaca.sln libcaca)
