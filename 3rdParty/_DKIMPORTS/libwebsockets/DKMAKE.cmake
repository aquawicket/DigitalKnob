# https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip

dk_import(https://github.com/warmcat/libwebsockets)
#dk_set(LIBWEBSOCKETS_VERSION 2.2.0)
#dk_set(LIBWEBSOCKETS_NAME libwebsockets-${LIBWEBSOCKETS_VERSION})
#dk_set(LIBWEBSOCKETS_DL https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip)
#dk_set(LIBWEBSOCKETS ${3RDPARTY}/${LIBWEBSOCKETS_NAME})
#dk_install(${LIBWEBSOCKETS_DL} libwebsockets ${LIBWEBSOCKETS})


### LINK ###
dk_include(${LIBWEBSOCKETS}/lib)
dk_include(${LIBWEBSOCKETS}/${OS})
WIN_DEBUG_DKLIB(${LIBWEBSOCKETS}/${OS}/lib/${DEBUG_DIR}/websockets_static.lib)
WIN_RELEASE_DKLIB(${LIBWEBSOCKETS}/${OS}/lib/${RELEASE_DIR}/websockets_static.lib)
## APPLE_DEBUG_DKLIB(${LIBWEBSOCKETS}/${OS}/lib/${DEBUG_DIR}/libwebsockets.a)
## APPLE_RELEASE_DKLIB(${LIBWEBSOCKETS}/${OS}/lib/${RELEASE_DIR}/libwebsockets.a)
LINUX_DEBUG_DKLIB(${LIBWEBSOCKETS}/${OS}/${DEBUG_DIR}/lib/libwebsockets.a)
LINUX_RELEASE_DKLIB(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR}/lib/libwebsockets.a)
## ANDROID_DEBUG_DKLIB(${LIBWEBSOCKETS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libwebsockets.a)
## ANDROID_RELEASE_DKLIB(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libwebsockets.a)


### COMPILE ###
WIN_dk_setPath(${LIBWEBSOCKETS}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} -LWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} -LWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
WIN_dk_VisualStudio(${LIBWEBSOCKETS_NAME} libwebsockets.sln websockets)

dk_setPath(${LIBWEBSOCKETS}/${OS}/Debug)
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
LINUX_DEBUG_dk_queueCommand(make)

dk_setPath(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
LINUX_RELEASE_dk_queueCommand(make)