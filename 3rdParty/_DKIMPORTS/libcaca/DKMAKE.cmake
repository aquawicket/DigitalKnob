include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/cacalabs/libcaca.git
# http://caca.zoy.org/wiki/libcaca


### IMPORT ###
#dk_import(http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz)
#dk_import(https://github.com/cacalabs/libcaca.git BRANCH main)
dk_import(https://github.com/cacalabs/libcaca/archive/refs/heads/main.zip)

### LINK ###
dk_include				(${LIBCACA}/include)
dk_include				(${LIBCACA}/${triple})
UNIX_dk_libDebug		(${LIBCACA}/${triple}/${DEBUG_DIR}/libcacad.a)
UNIX_dk_libRelease		(${LIBCACA}/${triple}/${RELEASE_DIR}/libcaca.a)
WIN_dk_libDebug			(${LIBCACA}/${triple}/${DEBUG_DIR}/libcacad.lib)
WIN_dk_libRelease		(${LIBCACA}/${triple}/${RELEASE_DIR}/libcaca.lib)


### GENERATE ####
dk_configure(${LIBCACA_DIR})


### COMPILE ###
dk_build(${LIBCACA} libcaca)
