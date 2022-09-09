# https://github.com/lua/lua
# https://www.lua.org/ftp/lua-5.4.3.tar.gz


dk_import(https://github.com/lua/lua.git)


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


### GENERATE ###
dk_setPath(${LUA}/${BUILD_DIR})
WIN_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
MAC_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOS_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
LINUX_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})
ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${LUA})


### COMPILE ###
WIN_dk_visualStudio(${LUA_NAME} lua)
MAC_dk_xcode(${LUA_NAME} lua)
IOS_dk_xcode(${LUA_NAME} lua)
IOSSIM_dk_xcode(${LUA_NAME} lua)
LINUX_dk_queueCommand(make lua)
RASPBERRY_dk_queueCommand(make lua)
ANDROID_dk_visualStudio(${LUA_NAME} lua)
