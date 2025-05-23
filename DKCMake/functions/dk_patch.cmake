#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_patch(import_name dest_path)
#
#	Copy files from a DK/3rdParty/_DKIMPORTS/library to the DK/3rdParty/library install location
#
#	@import_name	- The name of the 3rdParty DKIMPORT library
#	@dest_path		- The location of the installed library under /3rdParty
#
function(dk_patch import_name dest_path)
	dk_debugFunc()

	dk_notice("COPYING PATCH FILES FROM _IMPORTS/${import_name} TO ${dest_path}")
	dk_notice("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the dk_import or dk_install command")
	dk_notice("located in $ENV{DKIMPORTS_DIR}/${import_name}/DKINSTALL.cmake")
	
	dk_assertPath($ENV{DKIMPORTS_DIR}/${import_name})
	dk_assertPath(${dest_path})
	dk_copy("$ENV{DKIMPORTS_DIR}/${import_name}/" "${dest_path}/" OVERWRITE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_patch(todo "todo")
endfunction()