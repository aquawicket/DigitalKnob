#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)


### INSTALL ###
if(LINUX)
	dk_installPackage(libgnutls)
endif()
if(MAC)
	#dk_command(brew install gnutls)
	dk_installPackage(gnutls)
	dk_include(/usr/local/include)
	dk_lib(/usr/local/lib/libgnutls.dylib)
endif()