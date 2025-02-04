#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libtool ############

dk_load(dk_builder)

#ANDROID_HOST_dk_command(pkg install libtool)
dk_installPackage(libtool)
