# http://lua_website.com
#
# https://www.lua.org/ftp/lua-5.4.3.tar.gz


### VERSION ###
dk_set(LUA_VERSION 5.4.3)
dk_set(LUA_NAME lua-${LUA_VERSION})
dk_set(LUA_DL https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gzp)
dk_set(LUA ${3RDPARTY}/${LUA_NAME})


### INSTALL ###
dk_install(${LUA_DL} lua ${LUA})


### LINK ###
dk_include(${LUA}/include)
dk_include(${LUA}/${OS})
WIN_dk_libDebug(${LUA}/${OS}/${DEBUG_DIR}/luad.lib)
WIN_dk_libRelease(${LUA}/${OS}/${RELEASE_DIR}/lua.lib)
APPLE_dk_libDebug(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
APPLE_dk_libRelease(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
LINUX_dk_libDebug(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
LINUX_dk_libRelease(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
RASPBERRY_dk_libDebug(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
RASPBERRY_dk_libRelease(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
ANDROID_dk_libDebug(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
ANDROID_dk_libRelease(${LUA}/${OS}/${RELEASE_DIR}/lua.a)


### COMPILE ###
WIN_dk_setPath(${LUA}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
WIN_dk_VisualStudio(${LUA_NAME} lua.sln lua)


MAC_dk_setPath(${LUA}/${OS})
MAC32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
MAC_dk_xcode(${LUA_NAME} lua)


IOS_dk_setPath(${LUA}/${OS})
IOS32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOS_dk_xcode(${LUA_NAME} lua)


IOSSIM_dk_setPath(${LUA}/${OS})
IOSSIM32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOSSIM_dk_xcode(${LUA_NAME} lua)


LINUX_DEBUG_dk_setPath(${LUA}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
LINUX_DEBUG_dk_queueCommand(make lua)

LINUX_RELEASE_dk_setPath(${LUA}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
LINUX_RELEASE_dk_queueCommand(make lua)


RASPBERRY_DEBUG_dk_setPath(${LUA}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
RASPBERRY_DEBUG_dk_queueCommand(make lua)

RASPBERRY_RELEASE_dk_setPath(${LUA}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
RASPBERRY_RELEASE_dk_queueCommand(make lua)


##ANDROID_dk_ndk(${LUA_NAME})
ANDROID_dk_setPath(${LUA}/${OS})
ANDROID32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
ANDROID64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
ANDROID_dk_VisualStudio(${LUA_NAME} lua.sln lua)
