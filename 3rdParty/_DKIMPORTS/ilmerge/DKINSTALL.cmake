#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ ilmerge ############
# https://github.com/dotnet/ILMerge
# https://www.nuget.org/packages/ilmerge
# https://github.com/dotnet/ILMerge/archive/9ec1b3f2.zip

dk_import()

#dk_set(ILMERGE_VERSION 3.0.41)
#dk_set(ILMERGE_FOLDER ilmerge-${ILMERGE_VERSION})
#dk_set(ILMERGE_DL https://www.nuget.org/api/v2/package/ilmerge/3.0.41)
#dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
#dk_set(ILMERGE ${DK3RDPARTY_DIR}/${ILMERGE_FOLDER})
#dk_import(${ILMERGE_DL} ${ILMERGE})
