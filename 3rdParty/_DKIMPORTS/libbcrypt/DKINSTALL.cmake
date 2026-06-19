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


############ libbcrypt ############
dk_validate(Target_Tuple "dk_Target_Tuple()")

if(NOT Windows)
	dk_disable(libbcrypt)
	dk_return()
endif()


if(Windows_Arm64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(clang "dk_depend(clang)")
	dk_set(LIBBCRYPT_LIB "${msys2}/clangarm64/lib/libbcrypt.a")
	
elseif(Windows_X86_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(clang "dk_depend(clang)")
	dk_set(LIBBCRYPT_LIB "${msys2}/clang32/lib/libbcrypt.a")
	
elseif(Windows_X86_64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(clang "dk_depend(clang)")
	dk_set(LIBBCRYPT_LIB "${msys2}/clang64/lib/libbcrypt.a")

elseif(Windows_X86_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(clang "dk_depend(clang)")
	dk_set(LIBBCRYPT_LIB "${msys2}/mingw32/lib/libbcrypt.a")
	
elseif(Windows_X86_64_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(gcc "dk_depend(gcc)")
	dk_set(LIBBCRYPT_LIB "${msys2}/mingw64/lib/libbcrypt.a")

elseif(Windows_Arm32_Msvc)
	set(WINSDK_VER "10.0.26100.0")
	#dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/${WINSDK_VER}/um/arm/bcrypt.lib")
	dk_pathToCmake("$ENV{ProgramFiles(x86)}" ProgramFilesX86)
	dk_set(LIBBCRYPT_LIB "${ProgramFilesX86}/Windows Kits/10/Lib/${WINSDK_VER}/um/arm/bcrypt.lib")
	
elseif(Windows_Arm64_Msvc)
	set(WINSDK_VER "10.0.26100.0")
	#dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/${WINSDK_VER}/um/arm64/bcrypt.lib")
	dk_pathToCmake("$ENV{ProgramFiles(x86)}" ProgramFilesX86)
	dk_set(LIBBCRYPT_LIB "${ProgramFilesX86}/Windows Kits/10/Lib/${WINSDK_VER}/um/arm64/bcrypt.lib")
	
elseif(Windows_X86_Msvc)
	set(WINSDK_VER "10.0.26100.0")
	#dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/${WINSDK_VER}/um/x86/bcrypt.lib")
	dk_pathToCmake("$ENV{ProgramFiles(x86)}" ProgramFilesX86)
	dk_set(LIBBCRYPT_LIB "${ProgramFilesX86}/Windows Kits/10/Lib/${WINSDK_VER}/um/x86/bcrypt.lib")
	
elseif(Windows_X86_64_Msvc)
	set(WINSDK_VER "10.0.26100.0")
	#dk_set(LIBBCRYPT_LIB "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Lib/${WINSDK_VER}/um/x64/bcrypt.lib")
	dk_pathToCmake("$ENV{ProgramFiles(x86)}" ProgramFilesX86)
	dk_set(LIBBCRYPT_LIB "${ProgramFilesX86}/Windows Kits/10/Lib/${WINSDK_VER}/um/x64/bcrypt.lib")
	
elseif(Windows_X86_64_Ucrt)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(LIBBCRYPT_LIB "${msys2}/ucrt64/lib/libbcrypt.a")	
	
endif()

dk_debug("LIBBCRYPT_LIB = ${LIBBCRYPT_LIB}")
dk_assertPath(LIBBCRYPT_LIB)
dk_lib(${LIBBCRYPT_LIB})

#dynamic linking
#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lbcrypt")
#dk_findLibrary(bcrypt.lib)
