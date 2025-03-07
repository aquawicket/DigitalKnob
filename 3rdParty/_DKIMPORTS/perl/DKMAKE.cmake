#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
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

if(win_arm64_clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clangarm64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(win_x86_clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clang32/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(win_x86_64_clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clang64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(win_x86_gcc)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/mingw32/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(win_x86_64_gcc)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/mingw64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(win_x86_64_ucrt)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/ucrt64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
	
elseif(win_x86_msvc)
	dk_depend(strawberry-perl)
	
elseif(win_x86_64_msvc)
	dk_depend(strawberry-perl)
	
else()
	#dk_findProgram(PERL_EXE perl)
	dk_findProgram(PERL_EXE perl "${MSYS2}/usr/bin")
endif()


dk_assertPath(PERL_EXE)
