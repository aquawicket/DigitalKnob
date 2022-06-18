### VERSION ###
dk_set(LIGHTTPD_VERSION 1.4.45)
dk_set(LIGHTTPD_NAME lighttpd-${LIGHTTPD_VERSION})
#dk_set(LIGHTTPD_DL ???)
dk_set(LIGHTTPD ${3RDPARTY}/${LIGHTTPD_NAME})


### INSTALL ###
dk_install(${LIGHTTPD_DL} lighttpd ${LIGHTTPD})


### LINK ###
dk_include(${LIGHTTPD}/lib)
dk_include(${LIGHTTPD}/${OS}/${RELEASE_DIR})
WIN_DEBUG_DKLIB(${LIGHTTPD}/${OS}/lib/${DEBUG_DIR}/liblighttpd.lib)
WIN_RELEASE_DKLIB(${LIGHTTPD}/${OS}/lib/${RELEASE_DIR}/liblighttpd.lib)
APPLE_DEBUG_DKLIB(${LIGHTTPD}/${OS}/lib/${DEBUG_DIR}/liblighttpd.a)
APPLE_RELEASE_DKLIB(${LIGHTTPD}/${OS}/lib/${RELEASE_DIR}/liblighttpd.a)
LINUX_DEBUG_DKLIB(${LIGHTTPD}/${OS}/${DEBUG_DIR}/lib/liblighttpd.a)
LINUX_RELEASE_DKLIB(${LIGHTTPD}/${OS}/${RELEASE_DIR}/lib/liblighttpd.a)
ANDROID_DEBUG_DKLIB(${LIGHTTPD}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/liblighttpd.a)
ANDROID_RELEASE_DKLIB(${LIGHTTPD}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/liblighttpd.a)


### COMPILE ###
WIN_dk_setPath(${LIGHTTPD}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${LIGHTTPD})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${LIGHTTPD})
WIN_dk_VisualStudio(${LIGHTTPD_NAME} liblighttpd.sln LIGHTTPD)


LINUX_DEBUG_dk_setPath(${LIGHTTPD}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIGHTTPD})
LINUX_DEBUG_dk_queueCommand(make)

LINUX_RELEASE_dk_setPath(${LIGHTTPD}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIGHTTPD})
LINUX_RELEASE_dk_queueCommand(make)
