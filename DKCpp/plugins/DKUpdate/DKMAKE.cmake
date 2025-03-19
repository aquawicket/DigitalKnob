#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKUpdate ############
dk_depend(DKCurl)
dk_depend(DKArchive)

if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
else()
	dk_disable(DKDuktape)
endif()

if(HAVE_DKCef)
	dk_depend(DKCef)
else()
	dk_disable(DKCef)
endif()

dk_generateCmake(DKUpdate)
