#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### metacall_install ######
# https://github.com/metacall/install



### INSTALL ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_getFileParams	("$ENV{DKIMPORTS_DIR}/metacall_install/dkconfig.txt")
set					(METACALL_INSTALL_DL "https://github.com/metacall/install/archive/fb799638.zip")
dk_import			(${METACALL_INSTALL_DL})

