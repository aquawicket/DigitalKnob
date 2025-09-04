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


############ libevent ############
# https://github.com/libevent/libevent.git

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(mbedtls)
dk_depend(openssl)

### IMPORT ###
dk_import(https://github.com/libevent/libevent/archive/2a1ec766.zip)

### LINK ###
dk_include			(${LIBEVENT}/include)
Unix_dk_libDebug	(${LIBEVENT_Debug_Dir}/libevent.a)
Unix_dk_libRelease	(${LIBEVENT_Release_Dir}/libevent.a)
Windows_dk_libDebug		(${LIBEVENT_Debug_Dir}/event.lib)
Windows_dk_libRelease	(${LIBEVENT_Release_Dir}/event.lib)


### GENERATE ###
dk_configure(${LIBEVENT}
	-DEVENT_LIBRARY_STATIC=ON 
	-DEVENT_LIBRARY_SHARED=OFF 
	-DEVENT__DISABLE_TESTS=ON
	-DEVENT__DISABLE_REGRESS=ON
	-DEVENT__DISABLE_SAMPLES=ON
	${MBEDTLS_CMAKE} 
	${openssl_CMAKE})


### COMPILE ###
dk_build()