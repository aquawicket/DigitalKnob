# https://github.com/lua/lua
# https://www.lua.org/ftp/lua-5.4.3.tar.gz


### IMPORT ###
dk_import(https://github.com/lua/lua.git PATCH)


### LINK ###
dk_include				(${LUA}/include)
dk_include				(${LUA}/${OS})
WIN_dk_libDebug			(${LUA}/${OS}/${DEBUG_DIR}/luad.lib)
WIN_dk_libRelease		(${LUA}/${OS}/${RELEASE_DIR}/lua.lib)
APPLE_dk_libDebug		(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
APPLE_dk_libRelease		(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
LINUX_dk_libDebug		(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
LINUX_dk_libRelease		(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
RASPBERRY_dk_libDebug	(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
RASPBERRY_dk_libRelease	(${LUA}/${OS}/${RELEASE_DIR}/lua.a)
ANDROID_dk_libDebug		(${LUA}/${OS}/${DEBUG_DIR}/luad.a)
ANDROID_dk_libRelease	(${LUA}/${OS}/${RELEASE_DIR}/lua.a)


### GENERATE ###
dk_setPath		(${LUA}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${LUA})


### COMPILE ###
dk_visualStudio	(${LUA_FOLDER} lua)
dk_xcode		(${LUA_FOLDER} lua)
dk_make			(${LUA_FOLDER} lua)
