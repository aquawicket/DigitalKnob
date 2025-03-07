#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ blissOS ############

dk_import(https://cytranet-dal.dl.sourceforge.net/project/blissos-x86/OTA/BlissOS14/FOSS/Surface/Bliss-Surface-v14.10.3-x86_64-OFFICIAL-foss-20241013.zip?viasf=1)

