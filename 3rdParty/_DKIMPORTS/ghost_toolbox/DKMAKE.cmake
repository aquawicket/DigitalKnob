#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


###### [app_name] ######
# https://github.com/ovsky/ghost-open-toolbox
# https://github.com/ovsky/ghost-open-toolbox/archive/refs/heads/complete.zip


### INSTALL ###
#dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_getFileParam	($ENV{DKIMPORTS_DIR}/[app_name]/dkconfig.txt [APP_NAME]_IMPORT)
dk_import			("https://github.com/ovsky/ghost-open-toolbox/archive/refs/heads/complete.zip")

