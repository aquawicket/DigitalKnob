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



############ pearl ############
# https://packages.msys2.org/package/mingw-w64-x86_64-perl

if(EXISTS "${perl_exe}")
	dk_return()
endif()


dk_validate(MSYSTEM "dk_MSYSTEM()")
dk_debug("MSYSTEM = ${MSYSTEM}")

if(Windows_Arm64_Clang)
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl "${msys2}/clangarm64/bin")
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
	
elseif(Windows_X86_Clang)
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl "${msys2}/clang32/bin")
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
	
elseif(Windows_X86_64_Clang)
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl "${msys2}/clang64/bin")
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
	
elseif(Windows_X86_Gcc)
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl "${msys2}/mingw32/bin")
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
	
elseif(Windows_X86_64_Gcc)
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl "${msys2}/mingw64/bin")
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
	
elseif(Windows_X86_64_Ucrt)
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl "${msys2}/ucrt64/bin")
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
	
elseif(Windows_X86_Msvc)
	dk_depend(strawberry-perl)
	
elseif(Windows_X86_64_Msvc)
	dk_depend(strawberry-perl)
	
else()
	dk_depend(msys2)
	dk_installPackage(perl)
	#dk_findProgram(perl_exe perl)
	dk_findProgram(perl_exe perl "${msys2}/usr/bin")
endif()


dk_assertPath(perl_exe)
