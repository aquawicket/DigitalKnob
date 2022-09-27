# https://github.com/warmcat/libwebsockets
# https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip

dk_import(https://github.com/warmcat/libwebsockets.git BRANCH main)


### LINK ###
dk_include(${LIBWEBSOCKETS}/lib)
dk_include(${LIBWEBSOCKETS}/${OS})
WIN_dk_libDebug(${LIBWEBSOCKETS}/${OS}/lib/${DEBUG_DIR}/websockets_static.lib)
WIN_dk_libRelease(${LIBWEBSOCKETS}/${OS}/lib/${RELEASE_DIR}/websockets_static.lib)
## APPLE_dk_libDebug(${LIBWEBSOCKETS}/${OS}/lib/${DEBUG_DIR}/libwebsockets.a)
## APPLE_dk_libRelease(${LIBWEBSOCKETS}/${OS}/lib/${RELEASE_DIR}/libwebsockets.a)
LINUX_dk_libDebug(${LIBWEBSOCKETS}/${OS}/${DEBUG_DIR}/lib/libwebsockets.a)
LINUX_dk_libRelease(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR}/lib/libwebsockets.a)
## ANDROID_dk_libDebug(${LIBWEBSOCKETS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libwebsockets.a)
## ANDROID_dk_libRelease(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libwebsockets.a)


### COMPILE ###
WIN_dk_setPath(${LIBWEBSOCKETS}/${OS})
WIN_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
WIN_dk_visualStudio(${LIBWEBSOCKETS_NAME} websockets)

dk_setPath(${LIBWEBSOCKETS}/${OS}/Debug)
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
LINUX_DEBUG_dk_queueCommand(make)

dk_setPath(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} -DLWS_WITH_SSL=OFF ${LIBWEBSOCKETS})
LINUX_RELEASE_dk_queueCommand(make)