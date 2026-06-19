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



############ pearl ############
# https://packages.msys2.org/package/mingw-w64-x86_64-perl

if(EXISTS "${perl_exe}")
	dk_return()
endif()


dk_validate(MSYSTEM "dk_MSYSTEM()")
dk_debug("MSYSTEM = ${MSYSTEM}")

if(Windows_Arm64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
	
elseif(Windows_X86_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
	
elseif(Windows_X86_64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
	
elseif(Windows_X86_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
	
elseif(Windows_X86_64_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
	
elseif(Windows_X86_64_Ucrt)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
	
elseif(Windows_X86_Msvc)
	dk_depend(strawberry-perl)
	
elseif(Windows_X86_64_Msvc)
	dk_depend(strawberry-perl)
	
else()
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage(perl)
	set(perl_exe "${msys2}/usr/bin/perl.exe")
endif()


dk_set(perl_exe "${perl_exe}")
dk_assertPath(perl_exe)
