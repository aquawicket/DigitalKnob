#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKCurl ############
#dk_depend(openssl)
dk_depend(curl)
dk_depend(DKFile)
#dk_depend(DKThread)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()



############ DKCurl ############
dk_set(CURRENT_PLUGIN "DKCurl")
dk_generateCmake(DKCurl)
dk_assets(DKCurl)
dk_set(DKCurl "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKCurl")
dk_configure(${DKCurl})
dk_build(${DKCurl})
