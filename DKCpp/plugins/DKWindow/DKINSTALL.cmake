#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKWindow ############

dk_depend(DK)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()





############ DKWindow ############
dk_set(CURRENT_PLUGIN "DKWindow")
dk_generateCmake(DKWindow)
dk_assets(DKWindow)

dk_set(DKWindow "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKWindow")
dk_configure(${DKWindow})
dk_build(${DKWindow})