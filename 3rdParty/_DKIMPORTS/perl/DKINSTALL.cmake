#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")



############ pearl ############
# https://packages.msys2.org/package/mingw-w64-x86_64-perl

if(EXISTS "${PERL_EXE}")
	dk_return()
endif()


dk_validate(MSYSTEM "dk_MSYSTEM()")

dk_validate(MSYS2 "dk_depend(msys2)")
dk_installPackage(perl)

if(Win_Arm64_Clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clangarm64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(Win_X86_Clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clang32/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(Win_X86_64_Clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clang64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(Win_X86_Gcc)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/mingw32/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(Win_X86_64_Gcc)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/mingw64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(Win_X86_64_Ucrt)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/ucrt64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(Win_X86_Msvc)
	dk_depend(strawberry-perl)
	
elseif(Win_X86_64_Msvc)
	dk_depend(strawberry-perl)
	
else()
	#dk_findProgram(PERL_EXE perl)
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
endif()


dk_assertPath(PERL_EXE)
