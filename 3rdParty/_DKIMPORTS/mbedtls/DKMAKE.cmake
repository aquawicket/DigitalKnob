#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ mbedtls ############
# https://github.com/Mbed-TLS/mbedtls.git
dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/Mbed-TLS/mbedtls.git)
dk_import(https://github.com/Mbed-TLS/mbedtls/archive/67075846.zip)

### LINK ###
dk_include			(${MBEDTLS}/include)

# mbedtls
UNIX_dk_libDebug	(${MBEDTLS}/${target_triple}/library/${DEBUG_DIR}/libmbedtls.a)
UNIX_dk_libRelease	(${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/libmbedtls.a)
WIN_dk_libDebug		(${MBEDTLS}/${target_triple}/library/${DEBUG_DIR}/mbedtls.lib)
WIN_dk_libRelease	(${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/mbedtls.lib)

# mbedcrypto
UNIX_dk_libDebug	(${MBEDTLS}/${target_triple}/library/${DEBUG_DIR}/libmbedcrypto.a)
UNIX_dk_libRelease	(${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/libmbedcrypto.a)
WIN_dk_libDebug		(${MBEDTLS}/${target_triple}/library/${DEBUG_DIR}/mbedcrypto.lib)
WIN_dk_libRelease	(${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/mbedcrypto.lib)

# mbedx509
UNIX_dk_libDebug	(${MBEDTLS}/${target_triple}/library/${DEBUG_DIR}/libmbedx509.a)
UNIX_dk_libRelease	(${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/libmbedx509.a)
WIN_dk_libDebug		(${MBEDTLS}/${target_triple}/library/${DEBUG_DIR}/mbedx509.lib)
WIN_dk_libRelease	(${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/mbedx509.lib)

### 3RDPARTY LINK ###
UNIX_dk_set(MBEDTLS_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS}/include
	-DMBEDTLS_LIBRARY=${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/libmbedtls.a
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/libmbedcrypto.a
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/libmbedx509.a)
WIN_dk_set(MBEDTLS_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS}/include
	-DMBEDTLS_LIBRARY=${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/mbedtls.lib
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/mbedcrypto.lib
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS}/${target_triple}/library/${RELEASE_DIR}/mbedx509.lib)

### GENERATE ###
dk_configure(${MBEDTLS})

### COMPILE ###
dk_build(${MBEDTLS})
