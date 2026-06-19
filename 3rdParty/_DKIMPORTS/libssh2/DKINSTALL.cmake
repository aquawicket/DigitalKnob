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


############ libssh2 ############
# https://github.com/libssh2/libssh2.git

dk_depend(openssl)
dk_depend(ws2_32)

dk_import()

dk_define		(LIBSSH2_API)
dk_include		(${libssh2}/include 					LIBSSH2_INCLUDE_DIR)
dk_libDebug		(${libssh2_Debug_Dir}/src/libssh2.a		LIBSSH2_LIBRARY)
dk_libRelease	(${libssh2_Release_Dir}/src/libssh2.a	LIBSSH2_LIBRARY)

dk_set(libssh2_CMAKE
	-DLIBSSH2_INCLUDE_DIR=${LIBSSH2_INCLUDE_DIR}
	-DLIBSSH2_LIBRARY=${LIBSSH2_LIBRARY})
	
dk_configure(${libssh2}
	-DCRYPTO_BACKEND=OpenSSL
	-DENABLE_DEBUG_LOGGING=OFF 		# Log execution with debug trace" ${DEBUG_LOGGING_DEFAULT}
	-DENABLE_ECDSA_WINCNG=OFF 		# Enable WinCNG ECDSA support (requires Windows 10 or later)" OFF
	-DHIDE_SYMBOLS=OFF 				# Hide all libssh2 symbols that are not officially external" ON
	-DLIBSSH2_NO_DEPRECATED=OFF 	# Build without deprecated APIs" OFF
	-DLINT=OFF
	${openssl_CMAKE}
	${ws2_32}) 						# Check style while building" OFF

dk_build(${libssh2})