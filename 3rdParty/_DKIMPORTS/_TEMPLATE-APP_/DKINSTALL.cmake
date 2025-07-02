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


###### TEMPLATE ######
# http://www.TEMPLATE.com

### DEPENDS ###
#dk_depend(depend_name)

### INSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables	(${TEMPLATE_Import})
dk_import			(${TEMPLATE_Import})


#											Single Config										MULTI_CONFIG
#----------------------------------------------------------------------------------------------------------------------------
#	   Target_Config  =			                  Windows_X86_64/Debug								  Windows_X86_64
#       Target_Build  =			                  Windows_X86_64/Debug								  Windows_X86_64/Debug
#   MYLIB_CONFIG_DIR  =		....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64
#    MYLIB_BUILD_DIR  =		....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64/Debug
#    MYLIB_DEBUG_DIR  = 	....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64/Debug
#  MYLIB_RELEASE_DIR  = 	....3rdParty/myLib-13/Windows_X86_64/Release		....3rdParty/myLib-13/Windows_X86_64/Release
#   MYLIB_TUPLE_DIR  = 		....3rdParty/myLib-13/Windows_X86_64				....3rdParty/myLib-13/Windows_X86_64
