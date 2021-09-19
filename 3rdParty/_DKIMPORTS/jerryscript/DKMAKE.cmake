# https://jerryscript.net
# https://github.com/jerryscript-project/jerryscript
#
# https://github.com/jerryscript-project/jerryscript/archive/refs/tags/v2.4.0.zip


### VERSION ###
DKSET(JERRYSCRIPT_VERSION 2.4.0)
DKSET(JERRYSCRIPT_NAME jerryscript-${FREEALUT_VERSION})
DKSET(JERRYSCRIPT_DL https://github.com/jerryscript-project/jerryscript/archive/refs/tags/v${JERRYSCRIPT_VERSION}.zip)
DKSET(JERRYSCRIPT ${3RDPARTY}/${JERRYSCRIPT_NAME})


### INSTALL ###
DKINSTALL(${JERRYSCRIPT_DL} jerryscript ${JERRYSCRIPT})


### LINK ###
DKINCLUDE(${JERRYSCRIPT})
WIN_DEBUG_LIB(${JERRYSCRIPT}/${OS}/${DEBUG_DIR}/jerryscript.lib)
WIN_RELEASE_LIB(${JERRYSCRIPT}/${OS}/${RELEASE_DIR}/jerryscript.lib)


### COMPILE ###
WIN_PATH(${JERRYSCRIPT}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} ${JERRYSCRIPT})
WIN64_COMMAND(${DKCMAKE_WIN64} ${JERRYSCRIPT})
WIN_VS(${JERRYSCRIPT_NAME} JERRYSCRIPT.sln jerryscript)
