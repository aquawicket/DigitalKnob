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

#dynamic linking
d#k_append(CMAKE_CXX_LINK_EXECUTABLE -lbcrypt)
#dk_append(CMAKE_EXE_LINKER_FLAGS -lbcrypt PARENT_SCOPE)

#if(MSYSTEM)
	dk_set(LIBBCRYPT_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lbcrypt")
#endif()

