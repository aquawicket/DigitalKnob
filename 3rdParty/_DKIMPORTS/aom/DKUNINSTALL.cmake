#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ aom ############
# Alliance for Open Media
# https://aomedia.googlesource.com/aom.git
#
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		($ENV{DKIMPORTS_DIR}/aom/dkconfig.txt AOM_IMPORT)
dk_importVariables	(${AOM_IMPORT} NAME aom)
dk_delete			("${AOM}")
