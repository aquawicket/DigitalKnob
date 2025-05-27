########################################################################################
# Remove these lines and rename all instaces of _TEMPLATE-APP_ to the name of your app
dk_undepend(_TEMPLATE-APP_)
dk_return()
########################################################################################

#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### __app_name__ ######
# http://www.app.com
# http://www.app.com/downloads/app-1.0.exe

### DEPENDS ###
#dk_depend(depend_name)

### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams("${DKIMPORTS_DIR}/__APP_NAME__/dkconfig.txt")
dk_import		(${__APP_NAME__})


#											Single Config									MULTI_CONFIG
#	     CONFIG_PATH  =			                  Windows_X86_64/Debug								  Windows_X86_64
#         BUILD_PATH  =			                  Windows_X86_64/Debug								  Windows_X86_64/Debug
#   MYLIB_CONFIG_DIR  =		....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64
#    MYLIB_BUILD_DIR  =		....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64/Debug
#    MYLIB_DEBUG_DIR  = 	....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64/Debug
#  MYLIB_RELEASE_DIR  = 	....3rdParty/myLib-13/Windows_X86_64/Release		....3rdParty/myLib-13/Windows_X86_64/Release
#   MYLIB_TUPLE_DIR  = 		....3rdParty/myLib-13/Windows_X86_64				....3rdParty/myLib-13/Windows_X86_64
