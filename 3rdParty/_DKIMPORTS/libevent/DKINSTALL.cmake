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


############ libevent ############
# https://github.com/libevent/libevent.git
# https://github.com/libevent/libevent/archive/2a1ec766.zip

dk_depend(mbedtls)
dk_depend(openssl)

dk_import()

dk_include				(${libevent}/include)
Unix_dk_libDebug		(${libevent_Debug_Dir}/libevent.a)
Unix_dk_libRelease		(${libevent_Release_Dir}/libevent.a)
Windows_dk_libDebug		(${libevent_Debug_Dir}/event.lib)
Windows_dk_libRelease	(${libevent_Release_Dir}/event.lib)

dk_configure(${libevent}
	-DEVENT_LIBRARY_STATIC=ON 
	-DEVENT_LIBRARY_SHARED=OFF 
	-DEVENT__DISABLE_TESTS=ON
	-DEVENT__DISABLE_REGRESS=ON
	-DEVENT__DISABLE_SAMPLES=ON
	${mbedtls_CMAKE} 
	${openssl_CMAKE})

dk_build()
