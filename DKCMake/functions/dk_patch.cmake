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


#########################################################################
# dk_patch(Import_Name, Install_Path)
#
#	Copy files from a DK/3rdParty/_DKIMPORTS/library to the DK/3rdParty/library install location
#
#	@Import_Name	- The name of the 3rdParty DKIMPORT library
#	@Install_Path	- The location of the installed library under /3rdParty
#
function(dk_patch Import_Name Install_Path)
	dk_debugFunc()

	if(NOT "${Import_Name}" STREQUAL "${PLUGIN_Import_Name}")
		dk_fatal("Install_Path:${Import_Name} does NOT EQUAL PLUGIN_Import_Name:${PLUGIN_Import_Name}")
	endif()
	if(NOT "${Install_Path}" STREQUAL "${PLUGIN_Install_Path}")
		dk_fatal("Install_Path:${Install_Path} does NOT EQUAL PLUGIN_Install_Path:${PLUGIN_Install_Path}")
	endif()
	
	dk_notice("COPYING PATCH FILES FROM _IMPORTS/${PLUGIN_Import_Name} TO ${PLUGIN_Install_Path}")
	dk_notice("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the dk_import or dk_install command")
	dk_notice("located in $ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}/DKINSTALL.cmake")
	
	dk_assertPath($ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name})
	dk_assertPath(${PLUGIN_Install_Path})
	dk_copy("$ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}/" "${PLUGIN_Install_Path}/" OVERWRITE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_patch("libxml2" "C:/Users/Administrator/DigitalKnob/Development/3rdParty/libxml2-e397651a")
endfunction()