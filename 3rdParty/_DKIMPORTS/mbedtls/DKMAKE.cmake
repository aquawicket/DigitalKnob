# https://github.com/Mbed-TLS/mbedtls.git


### IMPORT ###
dk_import(https://github.com/Mbed-TLS/mbedtls.git)


### LINK ###
dk_include			(${MBEDTLS}/include)
UNIX_dk_libDebug	(${MBEDTLS}/${OS}/${DEBUG_DIR}/libmbedtls.a)
UNIX_dk_libRelease	(${MBEDTLS}/${OS}/${RELEASE_DIR}/libmbedtls.a)
WIN_dk_libDebug		(${MBEDTLS}/${OS}/${DEBUG_DIR}/mbedtls.lib)
WIN_dk_libRelease	(${MBEDTLS}/${OS}/${RELEASE_DIR}/mbedtls.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${MBEDTLS})


### COMPILE ###
dk_build(${MBEDTLS})