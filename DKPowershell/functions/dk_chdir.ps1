if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_chdir_ps1){ $dk_chdir_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_chdir(directory)
#
#    Change the working directory
#
#    @directory	- The directory path to change to
#
function Global:dk_chdir() {
	dk_debugFunc 0 1;

	${directory} = ($args[0]);
	set-location ${directory};
	${DKCD} = get-location;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	${DKCD} = get-location;
	dk_call dk_echo "Current Directory = ${DKCD}\n";
	
	dk_call dk_validate env:DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR";
	dk_call dk_chdir "${DKBRANCH_DIR}";
	
	${DKCD} = get-location;
	dk_call dk_echo "Current Directory = ${DKCD}\n";
}
