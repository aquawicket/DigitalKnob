#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKAssets ############
dk_depend(DKArchive)
dk_depend(DKDuktape)
#if(HAVE_DKDuktape)
#	dk_depend(DKDuktape)
#endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()



############ DKAssets ############
dk_set(CURRENT_PLUGIN "DKAssets")
dk_generateCmake(DKAssets)
dk_assets(DKAssets)

dk_set(DKAssets "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKAssets")
dk_configure(${DKAssets})
dk_build(${DKAssets})
