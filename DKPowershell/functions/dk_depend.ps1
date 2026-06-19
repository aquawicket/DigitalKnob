if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . '${PSScriptRoot}/DK.ps1'; }
if(!$dk_depend_ps1){ $dk_depend_ps1 = 1; } else{ return; } #include guard


############################################################################
# dk_depend(plugin)
#
#   this will search for a "plugin" to run in the following search path
#  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.ps1'
#
function Global:dk_depend() {
	#dk_debugFunc 1 99;

	${_plugin_} = $($args[0]);
	
	dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	${global:CURRENT_IMPORT}="${env:DKIMPORTS_DIR}/${_plugin_}";
	${dkInstall}="${CURRENT_IMPORT}/DKINSTALL.ps1";	
	if(!(Test-Path ${dkInstall})){
		dk_call dk_validate env:DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR";
		${dkhttpInstall} = ${dkInstall} -replace ${env:DIGITALKNOB_DIR}, ${env:DKHTTP_DIGITALKNOB_DIR};
		dk_call dk_download "${dkhttpInstall}" "${dkInstall}";
	}
	if(!(Test-Path ${dkInstall})){
		dk_call dk_fatal "dkInstall:${dkInstall} NOT found";
		return -1;
	}
	
	${dk_allButFirstArgs} = ${args} | Select-Object -Skip 1;
	dk_call dk_source "${dkInstall}";
	dk_call DKINSTALL ${dk_allButFirstArgs};
	return;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_depend git;
}
