# https://github.com/cacalabs/libcaca
# http://caca.zoy.org/wiki/libcaca


### IMPORT ###
#dk_import(http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz)
dk_import(https://github.com/cacalabs/libcaca.git BRANCH main)


### LINK ###
dk_include				(${LIBCACA}/include)
dk_include				(${LIBCACA}/${OS})
WIN_dk_libDebug			(${LIBCACA}/${OS}/${DEBUG_DIR}/libcacad.lib)
WIN_dk_libRelease		(${LIBCACA}/${OS}/${RELEASE_DIR}/libcaca.lib)
UNIX_dk_libDebug		(${LIBCACA}/${OS}/${DEBUG_DIR}/libcacad.a)
UNIX_dk_libRelease		(${LIBCACA}/${OS}/${RELEASE_DIR}/libcaca.a)


### GENERATE ####
dk_queueCommand(${DKCMAKE_BUILD} ${LIBCACA})


### COMPILE ###
dk_build(${LIBCACA_FOLDER} libcaca)
