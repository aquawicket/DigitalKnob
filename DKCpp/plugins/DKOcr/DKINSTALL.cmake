#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOcr ############
dk_depend(tesseract)
dk_depend(DKImageMagick)
##dk_depend(podofo)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


############ DKOcr ############
dk_set(CURRENT_PLUGIN "DKOcr")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/${CURRENT_PLUGIN}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})
