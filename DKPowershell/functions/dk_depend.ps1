if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . '${PSScriptRoot}/DK.ps1'; }
if(!$dk_depend_ps1){ $dk_depend_ps1 = 1; } else{ return; } #include guard


############################################################################
# dk_depend(plugin)
#
#   this will search for a "plugin" to run in the following search path
#  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.cmd'
#
function Global:dk_depend() {
	dk_debugFunc 0 99;

	${_plugin_} = $($args[0]);
	
	dk_call dk_source "$(dk_call dk_DKIMPORTS_DIR)/${_plugin_}/DKINSTALL.ps1";
	if(Test-Path "$(dk_call dk_DKIMPORTS_DIR)/${_plugin_}/DKINSTALL.ps1"){ 
		dk_call "$(dk_call dk_DKIMPORTS_DIR)/${_plugin_}/DKINSTALL.ps1";
		dk_call dk_success "found ${_plugin_}";
		return;
	}

	dk_call dk_fatal "$(dk_call dk_DKIMPORTS_DIR)/${_plugin_}/DKINSTALL.ps1 not found";
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_depend git;
}
