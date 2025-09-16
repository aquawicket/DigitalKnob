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


############ libbcrypt ############
if(NOT Windows)
	dk_disable(libbcrypt)
	dk_return()
endif()


# Clang
if(Windows_Arm64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(clang "dk_depend(clang)")
	dk_set(LIBBCRYPT_LIB "${msys2}/clangarm64/lib/libbcrypt.a")
elseif(Windows_X86_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(LIBBCRYPT_LIB "${msys2}/clang32/lib/libbcrypt.a")
elseif(Windows_X86_64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(LIBBCRYPT_LIB "${msys2}/clang64/lib/libbcrypt.a")

# Gcc
elseif(Windows_X86_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(LIBBCRYPT_LIB "${msys2}/mingw32/lib/libbcrypt.a")
elseif(Windows_X86_64_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(LIBBCRYPT_LIB "${msys2}/mingw64/lib/libbcrypt.a")

# Msvc
elseif(Windows_Arm32_Msvc)
	dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/10.0.22621.0/um/arm/bcrypt.lib")
elseif(Windows_Arm64_Msvc)
	dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/10.0.22621.0/um/arm64/bcrypt.lib")
elseif(Windows_X86_Msvc)
	dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/10.0.22621.0/um/x86/bcrypt.lib")
elseif(Windows_X86_64_Msvc)
	dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/10.0.22621.0/um/x64/bcrypt.lib")
	
# Ucrt
elseif(Windows_X86_64_Ucrt)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(LIBBCRYPT_LIB "${msys2}/ucrt64/lib/libbcrypt.a")	
endif()


dk_assertPath(LIBBCRYPT_LIB)
dk_lib(${LIBBCRYPT_LIB})

#dynamic linking
#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lbcrypt")
#dk_findLibrary(bcrypt.lib)
