#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKArchive ############
dk_depend(libarchive)
dk_depend(DKDuktape)
#if(HAVE_DKDuktape)
#	dk_depend(DKDuktape)
#endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()




############ DKArchive ############
dk_set(CURRENT_PLUGIN "DKArchive")
dk_generateCmake(DKArchive)
#dk_assets(DKArchive)

dk_set(DKArchive "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKArchive")
dk_configure(${DKArchive})
dk_build(${DKArchive})