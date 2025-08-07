if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_chdir_ps1){ $dk_chdir_ps1 = 1; } else{ return; } #include guard


#########################################################################
if( !(${DKPWD}) ){ ${global:DKPWD} = $(get-location) -replace "\\", "/"; }
#########################################################################
# dk_chdir(directory)
#
#    Change the current working directory
#
#    @directory	- The directory path to change to
#
function Global:dk_chdir() {
	dk_debugFunc 0 1;

	${_path_} = "$($args[0])";
		
	if(!(Test-Path "${_path_}")) {
		dk_call dk_warning "dk_chdir(${args}): path:${_path_} does not exist";
		return;
	}
	
	if("${DKPWD}" -eq "${_path_}") {
		dk_call dk_error "dk_chdir(${args}): DKPWD is already set to ${_path_}";
		return;
	}
	
	${global:DKOLDPWD} = "${DKPWD}";
	${global:DKPWD} = "${_path_}";
	set-location "${DKPWD}";
	
	###### output ######
	${global:dk_chdir} = ${dk_chdir};
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_chdir};
	} else {
		return ${dk_chdir};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_echo;
	dk_call dk_echo "DKOLDPWD = ${DKOLDPWD}";
	dk_call dk_echo "DKPWD = ${DKPWD}";
	
	dk_call dk_echo;
	dk_call dk_validate env:DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR";
	dk_call dk_chdir "${env:DKBRANCH_DIR}";
	dk_call dk_echo "DKOLDPWD = ${DKOLDPWD}";
	dk_call dk_echo "DKPWD = ${DKPWD}";
	
	dk_call dk_echo;
	dk_call dk_validate env:DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
	dk_call dk_chdir "${env:DKTOOLS_DIR}";
	dk_call dk_echo "DKOLDPWD = ${DKOLDPWD}";
	dk_call dk_echo "DKPWD = ${DKPWD}";
}
