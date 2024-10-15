#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
# https://packages.msys2.org/package/mingw-w64-x86_64-perl

dk_installPackage(perl)
if(MSYSTEM)
	dk_depend(msys2)
	dk_findProgram(PERL_EXE perl "${MSYS2_DIR}/usr/bin")
#	if(PERL_EXE)
#		dk_depend(cygpath)
#		dk_command(cygpath -m ${PERL_EXE} OUTPUT_VARIABLE PERL_EXE)
#	endif()
endif()

if(EXISTS ${PERL_EXE})
	dk_set(PERL_EXE "${PERL_EXE}")
	dk_command(${PERL_EXE} --version)
	return()
else()	
	dk_warning("perl not found!")
endif()
	

