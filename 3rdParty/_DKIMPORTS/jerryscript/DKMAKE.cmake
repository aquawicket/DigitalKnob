# https://github.com/jerryscript-project/jerryscript
# https://jerryscript.net



dk_import(https://github.com/jerryscript-project/jerryscript)
#dk_set(JERRYSCRIPT_VERSION 2.4.0)
#dk_set(JERRYSCRIPT_NAME jerryscript-${JERRYSCRIPT_VERSION})
#dk_set(JERRYSCRIPT_DL https://github.com/jerryscript-project/jerryscript/archive/refs/tags/v2.4.0.zip)
#dk_set(JERRYSCRIPT ${3RDPARTY}/${JERRYSCRIPT_NAME})
#dk_install(${JERRYSCRIPT_DL} jerryscript ${JERRYSCRIPT})


### LINK ###
dk_include(${JERRYSCRIPT}/jerry-core/include)
dk_include(${JERRYSCRIPT}/${OS})
WIN_dk_libDebug(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-core.lib)
WIN_dk_libRelease(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-core.lib)
WIN_dk_libDebug(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-ext.lib)
WIN_dk_libRelease(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-ext.lib)
WIN_dk_libDebug(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-port-default.lib)
WIN_dk_libRelease(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-port-default.lib)
APPLE_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
APPLE_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
APPLE_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
APPLE_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
APPLE_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
APPLE_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)
LINUX_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
LINUX_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
LINUX_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
LINUX_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
LINUX_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
LINUX_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)
RASPBERRY_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
RASPBERRY_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
RASPBERRY_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
RASPBERRY_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)
ANDROID_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
ANDROID_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
ANDROID_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
ANDROID_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
ANDROID_dk_libDebug(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
ANDROID_dk_libRelease(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)


### COMPILE ###
dk_setPath(${JERRYSCRIPT}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${JERRYSCRIPT})


WIN_dk_visualStudio(${JERRYSCRIPT_NAME} Jerry.sln jerry)
MAC_dk_xcode(${JERRYSCRIPT_NAME} jerry)
IOS_dk_xcode(${JERRYSCRIPT_NAME} jerry)
IOSSIM_dk_xcode(${JERRYSCRIPT_NAME} jerry)
LINUX_dk_queueCommand(make jerry)
RASPBERRY_dk_queueCommand(make jerry)
ANDROID_dk_visualStudio(${JERRYSCRIPT_NAME} jerryscript.sln jerryscript)
