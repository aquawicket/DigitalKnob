#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ appkit ############
# https://developer.apple.com/documentation/appkit?language=objc
#

dk_validate(Host_Triple ${Host_Triple})
if(NOT MAC_HOST)
	dk_undepend(appkit)
	dk_return()
endif()

dk_findLibrary(Appkit)
