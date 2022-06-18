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
WIN_DEBUG_DKLIB(${CACA}/${OS}/${DEBUG_DIR}/libcacad.lib)
WIN_RELEASE_DKLIB(${CACA}/${OS}/${RELEASE_DIR}/libcaca.lib)
APPLE_DEBUG_DKLIB(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
APPLE_RELEASE_DKLIB(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)
LINUX_DEBUG_DKLIB(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
LINUX_RELEASE_DKLIB(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)
RASPBERRY_DEBUG_DKLIB(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
RASPBERRY_RELEASE_DKLIB(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)
ANDROID_DEBUG_DKLIB(${CACA}/${OS}/${DEBUG_DIR}/libcacad.a)
ANDROID_RELEASE_DKLIB(${CACA}/${OS}/${RELEASE_DIR}/libcaca.a)


### COMPILE ###
dk_setPath(${CACA}/${OS})
DKQCOMMAND(${DKCMAKE_BUILD} ${CACA})

WIN_VS(${CACA_NAME} libcaca.sln libcaca)
MAC_XCODE(${CACA_NAME} libcaca)
IOS_XCODE(${CACA_NAME} libcaca)
IOSSIM_XCODE(${CACA_NAME} libcaca)
LINUX_DKQCOMMAND(make libcaca)
RASPBERRY_DKQCOMMAND(make libcaca)
ANDROID_VS(${CACA_NAME} libcaca.sln libcaca)
