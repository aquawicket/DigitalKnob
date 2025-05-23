#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSFMLRml ############
dk_depend(DKAssets)
dk_depend(DKSFMLWindow)
dk_depend(DKRml)

dk_generateCmake(DKSFMLRml)
