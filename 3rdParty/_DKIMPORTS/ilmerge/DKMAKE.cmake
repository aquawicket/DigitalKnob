#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ ilmerge ############
# https://github.com/dotnet/ILMerge
# https://www.nuget.org/packages/ilmerge
dk_load(dk_builder)

dk_import(https://github.com/dotnet/ILMerge/archive/9ec1b3f2.zip)

#dk_set(ILMERGE_VERSION 3.0.41)
#dk_set(ILMERGE_FOLDER ilmerge-${ILMERGE_VERSION})
#dk_set(ILMERGE_DL https://www.nuget.org/api/v2/package/ilmerge/3.0.41)
#dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
#dk_set(ILMERGE ${DK3RDPARTY_DIR}/${ILMERGE_FOLDER})
#dk_import(${ILMERGE_DL} ${ILMERGE})
