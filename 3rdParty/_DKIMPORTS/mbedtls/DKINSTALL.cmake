#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ mbedtls ############
# https://github.com/Mbed-TLS/mbedtls.git
dk_validate(Config_Path  "dk_Config_Path()")

### IMPORT ###
#dk_import(https://github.com/Mbed-TLS/mbedtls.git)
dk_import(https://github.com/Mbed-TLS/mbedtls/archive/67075846.zip)

### LINK ###
dk_include			(${MBEDTLS}/include)

# mbedtls
UNIX_dk_libDebug	(${MBEDTLS}/${Target_Tuple}/library/${Debug_Dir}/libmbedtls.a)
UNIX_dk_libRelease	(${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/libmbedtls.a)
Windows_dk_libDebug		(${MBEDTLS}/${Target_Tuple}/library/${Debug_Dir}/mbedtls.lib)
Windows_dk_libRelease	(${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/mbedtls.lib)

# mbedcrypto
UNIX_dk_libDebug	(${MBEDTLS}/${Target_Tuple}/library/${Debug_Dir}/libmbedcrypto.a)
UNIX_dk_libRelease	(${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/libmbedcrypto.a)
Windows_dk_libDebug		(${MBEDTLS}/${Target_Tuple}/library/${Debug_Dir}/mbedcrypto.lib)
Windows_dk_libRelease	(${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/mbedcrypto.lib)

# mbedx509
UNIX_dk_libDebug	(${MBEDTLS}/${Target_Tuple}/library/${Debug_Dir}/libmbedx509.a)
UNIX_dk_libRelease	(${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/libmbedx509.a)
Windows_dk_libDebug		(${MBEDTLS}/${Target_Tuple}/library/${Debug_Dir}/mbedx509.lib)
Windows_dk_libRelease	(${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/mbedx509.lib)

### 3RDPARTY LINK ###
UNIX_dk_set(MBEDTLS_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS}/include
	-DMBEDTLS_LIBRARY=${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/libmbedtls.a
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/libmbedcrypto.a
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/libmbedx509.a)
Windows_dk_set(MBEDTLS_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS}/include
	-DMBEDTLS_LIBRARY=${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/mbedtls.lib
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/mbedcrypto.lib
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS}/${Target_Tuple}/library/${Release_Dir}/mbedx509.lib)

### GENERATE ###
dk_configure(${MBEDTLS})

### COMPILE ###
dk_build(${MBEDTLS})
