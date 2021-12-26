# https://jerryscript.net
# https://github.com/jerryscript-project/jerryscript
#
# https://github.com/jerryscript-project/jerryscript/archive/refs/tags/v2.4.0.zip

### DEPENDS ###
#DKDEPEND(libname)


### VERSION ###
DKSET(JERRYSCRIPT_VERSION 2.4.0)
DKSET(JERRYSCRIPT_NAME jerryscript-${JERRYSCRIPT_VERSION})
DKSET(JERRYSCRIPT_DL https://github.com/jerryscript-project/jerryscript/archive/refs/tags/v${JERRYSCRIPT_VERSION}.zip)
DKSET(JERRYSCRIPT ${3RDPARTY}/${JERRYSCRIPT_NAME})


### INSTALL ###
DKINSTALL(${JERRYSCRIPT_DL} jerryscript ${JERRYSCRIPT})


### LINK ###
DKINCLUDE(${JERRYSCRIPT}/jerry-core/include)
DKINCLUDE(${JERRYSCRIPT}/${OS})
WIN_DEBUG_LIB(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-core.lib)
WIN_RELEASE_LIB(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-core.lib)
WIN_DEBUG_LIB(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-ext.lib)
WIN_RELEASE_LIB(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-ext.lib)
WIN_DEBUG_LIB(${JERRYSCRIPT}/${OS}/lib/${DEBUG_DIR}/jerry-port-default.lib)
WIN_RELEASE_LIB(${JERRYSCRIPT}/${OS}/lib/${RELEASE_DIR}/jerry-port-default.lib)
APPLE_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
APPLE_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
APPLE_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
APPLE_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
APPLE_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
APPLE_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)
LINUX_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
LINUX_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
LINUX_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
LINUX_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
LINUX_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
LINUX_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)
RASPBERRY_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
RASPBERRY_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
RASPBERRY_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
RASPBERRY_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
RASPBERRY_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
RASPBERRY_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)
ANDROID_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-core.a)
ANDROID_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-core.a)
ANDROID_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-ext.a)
ANDROID_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-ext.a)
ANDROID_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/lib/libjerry-port-default.a)
ANDROID_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/lib/libjerry-port-default.a)


### COMPILE ###
DKSETPATH(${JERRYSCRIPT}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${JERRYSCRIPT})


WIN_VS(${JERRYSCRIPT_NAME} Jerry.sln jerry)
MAC_XCODE(${JERRYSCRIPT_NAME} jerry)
IOS_XCODE(${JERRYSCRIPT_NAME} jerry)
IOSSIM_XCODE(${JERRYSCRIPT_NAME} jerry)
LINUX_DKQCOMMAND(make jerry)
RASPBERRY_DKQCOMMAND(make jerry)
ANDROID_VS(${JERRYSCRIPT_NAME} jerryscript.sln jerryscript)
