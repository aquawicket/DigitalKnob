#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### TEMPLATE ######
# http://www.TEMPLATE.com

### DEPENDS ###
#dk_validate(depend_name "dk_depend(depend_name)")

### INSTALL ###
dk_importVariables	(${TEMPLATE_Import})
dk_import			(${TEMPLATE_Import})

#											Single Config										MULTI_CONFIG
#----------------------------------------------------------------------------------------------------------------------------
#	   Target_Config  =			                  Windows_X86_64/Debug								  Windows_X86_64
#       Target_Build  =			                  Windows_X86_64/Debug								  Windows_X86_64/Debug
#   MYLIB_Config_Dir  =		....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64
#    MYLIB_Build_Dir  =		....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64/Debug
#    MYLIB_Debug_Dir  = 	....3rdParty/myLib-13/Windows_X86_64/Debug			....3rdParty/myLib-13/Windows_X86_64/Debug
#  MYLIB_Release_Dir  = 	....3rdParty/myLib-13/Windows_X86_64/Release		....3rdParty/myLib-13/Windows_X86_64/Release
#   MYLIB_Tuple_Dir  = 		....3rdParty/myLib-13/Windows_X86_64				....3rdParty/myLib-13/Windows_X86_64
