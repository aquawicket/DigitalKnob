#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDocument ############
dk_depend(DKNode)
dk_depend(DKNonElementParentNode)	# mixin
dk_depend(DKHTMLCollection)
dk_depend(DKElement)




############ DKDocument ############
dk_set(CURRENT_PLUGIN "DKDocument")
dk_generateCmake(DKDocument)
dk_assets(DKDocument)
dk_set(DKDocument "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKDocument")
dk_configure(${DKDocument})
dk_build(${DKDocument})