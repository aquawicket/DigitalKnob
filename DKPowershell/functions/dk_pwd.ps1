if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_pwd_ps1){ $dk_pwd_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_chdir(directory)
#
#    Change the working directory
#
#    @directory	- The directory path to change to
#
function Global:dk_pwd() {
	dk_debugFunc 0;

	${dk_pwd} = $(get-location) -replace "\\", "/";
	return ${dk_pwd}; 
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	${dk_pwd} = dk_call dk_pwd;
	dk_call dk_echo "Current Directory = ${dk_pwd}\n";
}
