# https://github.com/Mbed-TLS/mbedtls.git


### IMPORT ###
dk_import(https://github.com/Mbed-TLS/mbedtls.git)


### LINK ###
dk_include			(${MBEDTLS}/include)

# mbedtls
UNIX_dk_libDebug	(${MBEDTLS}/${OS}/library/${DEBUG_DIR}/libmbedtls.a)
UNIX_dk_libRelease	(${MBEDTLS}/${OS}/library/${RELEASE_DIR}/libmbedtls.a)
WIN_dk_libDebug		(${MBEDTLS}/${OS}/library/${DEBUG_DIR}/mbedtls.lib)
WIN_dk_libRelease	(${MBEDTLS}/${OS}/library/${RELEASE_DIR}/mbedtls.lib)

# mbedcrypto
UNIX_dk_libDebug	(${MBEDTLS}/${OS}/library/${DEBUG_DIR}/libmbedcrypto.a)
UNIX_dk_libRelease	(${MBEDTLS}/${OS}/library/${RELEASE_DIR}/libmbedcrypto.a)
WIN_dk_libDebug		(${MBEDTLS}/${OS}/library/${DEBUG_DIR}/mbedcrypto.lib)
WIN_dk_libRelease	(${MBEDTLS}/${OS}/library/${RELEASE_DIR}/mbedcrypto.lib)

# mbedx509
UNIX_dk_libDebug	(${MBEDTLS}/${OS}/library/${DEBUG_DIR}/libmbedx509.a)
UNIX_dk_libRelease	(${MBEDTLS}/${OS}/library/${RELEASE_DIR}/libmbedx509.a)
WIN_dk_libDebug		(${MBEDTLS}/${OS}/library/${DEBUG_DIR}/mbedx509.lib)
WIN_dk_libRelease	(${MBEDTLS}/${OS}/library/${RELEASE_DIR}/mbedx509.lib)


### 3RDPARTY LINK ###
UNIX_dk_set(MBEDTLS_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS}/include
	-DMBEDTLS_LIBRARY=${MBEDTLS}/${OS}/library/${RELEASE_DIR}/libmbedtls.a
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS}/${OS}/library/${RELEASE_DIR}/libmbedcrypto.a
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS}/${OS}/library/${RELEASE_DIR}/libmbedx509.a)
WIN_dk_set(MBEDTLS_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS}/include
	-DMBEDTLS_LIBRARY=${MBEDTLS}/${OS}/library/${RELEASE_DIR}/mbedtls.lib
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS}/${OS}/library/${RELEASE_DIR}/mbedcrypto.lib
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS}/${OS}/library/${RELEASE_DIR}/mbedx509.lib)


### GENERATE ###
dk_configure(${MBEDTLS})


### COMPILE ###
dk_build(${MBEDTLS})