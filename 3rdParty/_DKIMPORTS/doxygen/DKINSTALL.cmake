#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ doxygen ############
# https://github.com/doxygen/doxygen.git
# https://sourceforge.net/projects/doxygen
# FIXME:  Install to /3rdParty only
dk_load(dk_builder)

if(NOT WIN_HOST)
	dk_undepend(doxygen)
	dk_return()
endif()

### IMPORT ###
if(WIN_HOST)
	dk_set(DOXYGEN_EXE "${ProgramFiles}/doxygen/bin/doxygen.exe")
else()
	dk_set(DOXYGEN_EXE "/Applications/Doxygen.app") #FIXME
endif()


if(NOT EXISTS ${DOXYGEN_EXE})
	if(WIN_HOST)
		dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6-setup.exe)
		dk_command($ENV{DKDOWNLOAD_DIR}/doxygen-1.9.6-setup.exe)
	elseif(MAC_HOST)
		dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/Doxygen-1.9.6.dmg) #FIXME:  The Downloaded file is a BYPASS file .dmg
		dk_command($ENV{DKDOWNLOAD_DIR}/Doxygen-1.9.6.dmg)
	else()
		dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6.linux.bin.tar.gz)
		#dk_command($ENV{DKDOWNLOAD_DIR}/doxygen-1.9.6.linux.bin.tar.gz) #FIXME
	endif()
endif()
