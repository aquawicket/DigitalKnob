#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


###### ghost_toolbox ######
# https://github.com/ovsky/ghost-open-toolbox

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/ghost_toolbox/dkconfig.txt")
dk_import		("${GHOST_TOOLBOX_IMPORT}")

dk_copy	("${DK3RDPARTY_DIR}/ghost_toolbox-b43ed1d2b3661eb1f76083330ba40e18bc9e36e8" "$ENV{SystemDrive}/Ghost Toolbox")
execute_process(COMMAND "$ENV{SystemDrive}\\Ghost Toolbox\\ghost-commandline\\Ghost Toolbox 1.9.0.56.bat")