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
WIN_DEBUG_DKLIB(${LUA}/${OS}/${DEBUG_DIR}/luad.lib)
WIN_RELEASE_DKLIB(${LUA}/${OS}/${RELEASE_DIR}/lua.lib)
APPLE_DEBUG_DKLIB(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
APPLE_RELEASE_DKLIB(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
LINUX_DEBUG_DKLIB(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
LINUX_RELEASE_DKLIB(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
RASPBERRY_DEBUG_DKLIB(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
RASPBERRY_RELEASE_DKLIB(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
ANDROID_DEBUG_DKLIB(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
ANDROID_RELEASE_DKLIB(${LUA}/${OS}/${RELEASE_DIR}/lua.a)


### COMPILE ###
WIN_dk_setPath(${LUA}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
WIN_VS(${LUA_NAME} lua.sln lua)


MAC_dk_setPath(${LUA}/${OS})
MAC32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
MAC_XCODE(${LUA_NAME} lua)


IOS_dk_setPath(${LUA}/${OS})
IOS32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOS_XCODE(${LUA_NAME} lua)


IOSSIM_dk_setPath(${LUA}/${OS})
IOSSIM32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOSSIM_XCODE(${LUA_NAME} lua)


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


##ANDROID_NDK(${LUA_NAME})
ANDROID_dk_setPath(${LUA}/${OS})
ANDROID32_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
ANDROID64_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
ANDROID_VS(${LUA_NAME} lua.sln lua)
