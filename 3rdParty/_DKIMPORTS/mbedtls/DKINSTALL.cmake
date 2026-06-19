#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ mbedtls ############
# https://github.com/Mbed-TLS/mbedtls.git
# https://github.com/Mbed-TLS/mbedtls/archive/67075846.zip

dk_import()

dk_include			(${mbedtls}/include												MBEDTLS_INCLUDE_DIR)

# mbedtls
if(Unix)
	dk_libDebug		(${mbedtls_Tuple_Dir}/library/${Debug_Dir}/libmbedtls.a			MBEDTLS_LIBRARY)
	dk_libRelease	(${mbedtls_Tuple_Dir}/library/${Release_Dir}/libmbedtls.a		MBEDTLS_LIBRARY)
elseif(Windows)
	dk_libDebug		(${mbedtls_Tuple_Dir}/library/${Debug_Dir}/mbedtls.lib			MBEDTLS_LIBRARY)
	dk_libRelease	(${mbedtls_Tuple_Dir}/library/${Release_Dir}/mbedtls.lib		MBEDTLS_LIBRARY)
endif()

# mbedcrypto
if(Unix)
	dk_libDebug		(${mbedtls_Tuple_Dir}/library/${Debug_Dir}/libmbedcrypto.a		MBEDTLS_CRYPTO_LIBRARY)
	dk_libRelease	(${mbedtls_Tuple_Dir}/library/${Release_Dir}/libmbedcrypto.a	MBEDTLS_CRYPTO_LIBRARY)
elseif(Windows)
	dk_libDebug		(${mbedtls_Tuple_Dir}/library/${Debug_Dir}/mbedcrypto.lib		MBEDTLS_CRYPTO_LIBRARY)
	dk_libRelease	(${mbedtls_Tuple_Dir}/library/${Release_Dir}/mbedcrypto.lib		MBEDTLS_CRYPTO_LIBRARY)
endif()

# mbedx509
if(Unix)
	dk_libDebug		(${mbedtls_Tuple_Dir}/library/${Debug_Dir}/libmbedx509.a		MBEDTLS_X509_LIBRARY)
	dk_libRelease	(${mbedtls_Tuple_Dir}/library/${Release_Dir}/libmbedx509.a		MBEDTLS_X509_LIBRARY)
elseif(Windows)
	dk_libDebug		(${mbedtls_Tuple_Dir}/library/${Debug_Dir}/mbedx509.lib			MBEDTLS_X509_LIBRARY)
	dk_libRelease	(${mbedtls_Tuple_Dir}/library/${Release_Dir}/mbedx509.lib		MBEDTLS_X509_LIBRARY)
endif()

dk_set(mbedtls_CMAKE 
	-DMBEDTLS_INCLUDE_DIR=${MBEDTLS_INCLUDE_DIR}
	-DMBEDTLS_LIBRARY=${MBEDTLS_LIBRARY}
	-DMBEDTLS_CRYPTO_LIBRARY=${MBEDTLS_CRYPTO_LIBRARY}
	-DMBEDTLS_X509_LIBRARY=${MBEDTLS_X509_LIBRARY})

dk_configure()

dk_build()
