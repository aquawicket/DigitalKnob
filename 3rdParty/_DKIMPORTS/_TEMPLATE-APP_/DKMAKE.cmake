########################################################################################
# Remove these lines and rename all instaces of _TEMPLATE-APP_ to the name of your app
dk_undepend(_TEMPLATE-APP_)
dk_return()
########################################################################################

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### [app_name] ######
# http://www.app.com
# http://www.app.com/downloads/app-1.0.exe

### DEPENDS ###
#dk_depend(depend_name)

### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/[app_name]/[app_name].txt [APP_NAME]_IMPORT)
dk_import		(${[APP_NAME]})
