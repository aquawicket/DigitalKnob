#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libbcrypt ############
dk_load(dk_builder)
if(NOT MINGW)
#	dk_undepend(libbcrypt)
#	dk_return()
endif()


#dk_append(CMAKE_EXE_LINKER_FLAGS -lbcrypt)
#if(MSYSTEM)
	dk_appemd(LIBBCRYPT_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lbcrypt")
#endif()

