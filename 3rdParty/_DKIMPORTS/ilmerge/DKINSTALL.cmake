#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ ilmerge ############
# https://github.com/dotnet/ILMerge
# https://www.nuget.org/packages/ilmerge

#dk_validate(host_triple "dk_host_triple()")

dk_import(https://github.com/dotnet/ILMerge/archive/9ec1b3f2.zip)

#dk_set(ILMERGE_VERSION 3.0.41)
#dk_set(ILMERGE_FOLDER ilmerge-${ILMERGE_VERSION})
#dk_set(ILMERGE_DL https://www.nuget.org/api/v2/package/ilmerge/3.0.41)
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(ILMERGE $ENV{DK3RDPARTY_DIR}/${ILMERGE_FOLDER})
#dk_import(${ILMERGE_DL} ${ILMERGE})
