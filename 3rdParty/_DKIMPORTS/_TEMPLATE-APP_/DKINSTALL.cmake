########################################################################################
# Remove these lines and rename all instaces of _TEMPLATE-APP_ to the name of your app
dk_undepend(_TEMPLATE-APP_)
dk_return()
########################################################################################

#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### __app_name__ ######
# http://www.app.com
# http://www.app.com/downloads/app-1.0.exe

### DEPENDS ###
#dk_depend(depend_name)

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/__APP_NAME__/dkconfig.txt")
dk_import		(${__APP_NAME__})


#											Single Config										MULTI_CONFIG
#	     CONFIG_PATH  =			                  win_x86_64/Debug									  win_x86_64
#         BUILD_PATH  =			                  win_x86_64/Debug									  win_x86_64/Debug
#   MYLIB_CONFIG_DIR  =		....3rdParty/myLib-13/win_x86_64/Debug				....3rdParty/myLib-13/win_x86_64
#    MYLIB_BUILD_DIR  =		....3rdParty/myLib-13/win_x86_64/Debug				....3rdParty/myLib-13/win_x86_64/Debug
#    MYLIB_DEBUG_DIR  = 	....3rdParty/myLib-13/win_x86_64/Debug				....3rdParty/myLib-13/win_x86_64/Debug
#  MYLIB_RELEASE_DIR  = 	....3rdParty/myLib-13/win_x86_64/Release			....3rdParty/myLib-13/win_x86_64/Release
#   MYLIB_TRIPLE_DIR  = 	....3rdParty/myLib-13/win_x86_64					....3rdParty/myLib-13/win_x86_64
