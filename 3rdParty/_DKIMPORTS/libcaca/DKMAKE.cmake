# https://github.com/cacalabs/libcaca
# http://caca.zoy.org/wiki/libcaca


DKIMPORT(https://github.com/cacalabs/libcaca)
#DKSET(CACA_VERSION 0.99.beta19)
#DKSET(CACA_NAME libcaca-${CACA_VERSION})
#DKSET(CACA_DL http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz)
#DKSET(CACA ${3RDPARTY}/${CACA_NAME})
#DKINSTALL(${CACA_DL} libcaca ${CACA})


### LINK ###
DKINCLUDE(${CACA}/include)
DKINCLUDE(${CACA}/${OS})
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
DKSETPATH(${CACA}/${OS})
DKQCOMMAND(${DKCMAKE_BUILD} ${CACA})

WIN_VS(${CACA_NAME} libcaca.sln libcaca)
MAC_XCODE(${CACA_NAME} libcaca)
IOS_XCODE(${CACA_NAME} libcaca)
IOSSIM_XCODE(${CACA_NAME} libcaca)
LINUX_DKQCOMMAND(make libcaca)
RASPBERRY_DKQCOMMAND(make libcaca)
ANDROID_VS(${CACA_NAME} libcaca.sln libcaca)
