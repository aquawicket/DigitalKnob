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
	DKDEBUGFUNC(${ARGV})
	dk_warn("COPYING PATCH FILES FROM _IMPORTS/${import_name} TO ${dest_path}")
	dk_warn("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the dk_import or dk_install command")
	dk_warn("located in ${DKIMPORTS_DIR}/${import_name}/DKMAKE.cmake")
	dk_copy(${DKIMPORTS_DIR}/${import_name}/ ${dest_path}/ OVERWRITE)
endfunction()