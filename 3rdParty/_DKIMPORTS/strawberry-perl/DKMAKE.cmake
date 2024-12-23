#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ strawberry-perl ############
# https://strawberryperl.com/

dk_validate(host_triple "dk_host_triple()")

if(WIN_X86_64_HOST)
	dk_import(https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_54001_64bit_UCRT/strawberry-perl-5.40.0.1-64bit-portable.zip)
	dk_set(PERL_EXE "${STRAWBERRY_PERL}/perl/bin/perl.exe")
endif()


# TODO