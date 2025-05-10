#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ build-essential ############
# https://packages.ubuntu.com/focal/build-essential
dk_validate(Host_Triple "dk_Host_Triple()")
if(WIN_HOST)
	dk_undepend(build-essential)
	dk_return()
endif()

dk_installPackage(build-essential)
#dk_todo("tiny-core-linux build-essential")
