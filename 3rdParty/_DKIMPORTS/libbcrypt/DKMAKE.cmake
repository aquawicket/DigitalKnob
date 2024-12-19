#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libbcrypt ############
dk_validate(target_triple "dk_target_triple()")
if((NOT MINGW) AND (NOT MSYS))
	dk_undepend(libbcrypt)
	dk_return()
endif()


dk_depend(msys2)

if(CLANGARM64)
	dk_lib("${MSYS2}/clangarm64/lib/libbcrypt.a")
elseif(CLANG32)
	set(LIBBCRYPT_A "${MSYS2}/clang32/lib/libbcrypt.a")
elseif(CLANG64)
	set(LIBBCRYPT_A "${MSYS2}/clang64/lib/libbcrypt.a")
elseif(MINGW32)
	set(LIBBCRYPT_A "${MSYS2}/mingw32/lib/libbcrypt.a")
elseif(MINGW64)
	set(LIBBCRYPT_A "${MSYS2}/mingw64/lib/libbcrypt.a")
elseif(UCRT64)
	set(LIBBCRYPT_A "${MSYS2}/ucrt64/lib/libbcrypt.a")
endif()

#dynamic linking
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lbcrypt")
#dk_findLibrary(bcrypt.lib)
