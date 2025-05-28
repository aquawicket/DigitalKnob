#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKFile ############
dk_depend(DK)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()





############ DKFile ############
dk_set(CURRENT_PLUGIN "DKFile")
dk_generateCmake(DKFile)
dk_assets(DKFile)

dk_set(DKFile "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKFile")
dk_configure(${DKFile})
dk_build(${DKFile})
