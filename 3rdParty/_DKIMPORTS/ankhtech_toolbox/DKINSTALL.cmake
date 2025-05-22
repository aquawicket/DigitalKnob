#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ankhtech_toolbox ######
# https://d9750.download-send.com/d/nryyw7au6cosj4l4onsfta7kzj7jhkkax5a2bclu466wflbbl4u3ovogbyivfspn3iwoq6gn/AT.Toolbox.zip

### INSTALL ###
dk_validate			(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/ankhtech_toolbox/dkconfig.txt")
dk_import			(${ANKHTECH_TOOLBOX_IMPORT} NAME ankhtech_toolbox)
