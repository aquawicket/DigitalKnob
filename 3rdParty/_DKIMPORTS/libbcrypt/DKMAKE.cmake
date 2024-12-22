#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libbcrypt ############
#C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\arm\bcrypt.lib
#C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\arm64\bcrypt.lib
#C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64\bcrypt.lib
#C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x86\bcrypt.lib


dk_validate(target_triple "dk_target_triple()")



if(win_arm64_clang)
	dk_depend(msys2)
	dk_set(LIBBCRYPT_LIB "${MSYS2}/clangarm64/lib/libbcrypt.a")
elseif(win_x86_clang)
	dk_depend(msys2)
	dk_set(LIBBCRYPT_LIB "${MSYS2}/clang32/lib/libbcrypt.a")
elseif(win_x86_64_clang)
	dk_depend(msys2)
	dk_set(LIBBCRYPT_LIB "${MSYS2}/clang64/lib/libbcrypt.a")
elseif(MINGW32)
	dk_depend(msys2)
	dk_set(LIBBCRYPT_LIB "${MSYS2}/mingw32/lib/libbcrypt.a")
elseif(MINGW64)
	dk_depend(msys2)
	dk_set(LIBBCRYPT_LIB "${MSYS2}/mingw64/lib/libbcrypt.a")
elseif(UCRT64)
	dk_depend(msys2)
	dk_set(LIBBCRYPT_LIB "${MSYS2}/ucrt64/lib/libbcrypt.a")
endif()

dk_assertPath(LIBBCRYPT_LIB)
dk_lib(${LIBBCRYPT_LIB})
#dynamic linking
#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lbcrypt")
#dk_findLibrary(bcrypt.lib)
