#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ ilmerge ############
# https://github.com/dotnet/ILMerge
# https://www.nuget.org/packages/ilmerge

#dk_validate(Host_Tuple "dk_Host_Tuple()")

dk_import(https://github.com/dotnet/ILMerge/archive/9ec1b3f2.zip)

#dk_set(ILMERGE_VERSION 3.0.41)
#dk_set(ILMERGE_FOLDER ilmerge-${ILMERGE_VERSION})
#dk_set(ILMERGE_DL https://www.nuget.org/api/v2/package/ilmerge/3.0.41)
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(ILMERGE $ENV{DK3RDPARTY_DIR}/${ILMERGE_FOLDER})
#dk_import(${ILMERGE_DL} ${ILMERGE})
