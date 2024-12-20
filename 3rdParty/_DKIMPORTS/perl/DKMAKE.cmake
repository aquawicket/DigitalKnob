#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



# https://packages.msys2.org/package/mingw-w64-x86_64-perl


#if(PERL_EXE)
#	return()
#endif()


if(WIN_HOST)
	if(DEFINED ENV{MSYSTEM})
		dk_set(MSYSTEM "$ENV{MSYSTEM}")
		dk_set($ENV{MSYSTEM} 1)
		dk_depend(msys2)
	endif()
endif()

dk_installPackage(perl)

if(win_arm64_clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clangarm64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
	
elseif(win_x86_clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clang32/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
	
elseif(win_x86_64_clang)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/clang64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
	
elseif(win_x86_mingw)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/mingw32/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
	
elseif(win_x86_64_mingw)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/mingw64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
	
elseif(win_x86_64_ucrt)
	#dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/ucrt64/bin")
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
	
elseif(win_x86_msvc)
	# TODO
	
elseif(win_x86_64_msvc)
	# TODO
	
else()
	dk_findProgram(PERL_EXE perl)
	
endif()


#dk_assertVar(PERL_EXE)
