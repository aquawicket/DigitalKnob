if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_exit_ps1){ $dk_exit_ps1 = 1; } else{ return; } #include guard


if(!(${dk_exit_PAUSE_ON_EXIT})) { $global:dk_exit_PAUSE_ON_EXIT = 0; }
##################################################################################
# dk_exit(exitcode)
#
#
function Global:dk_exit() { # $exitcode
	dk_debugFunc 0 1;
	
	if(!($args[0])){ 
		$exit_code = $LASTEXITCODE; 	## default exit code is $LASTEXITCODE
	} else {
		$exitcode = $args[0];
	}
	
	dk_call dk_echo "dk_exit $exitcode\n";
	if(${dk_exit_PAUSE_ON_EXIT} -eq 1){ dk_call dk_echo "*** dk_exit_PAUSE_ON_EXIT ***"; dk_call dk_pause; }
	
	$host.SetShouldExit($exitcode);
	exit $exitcode;
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	#dk_call dk_exit;
	#dk_call dk_exit 0;
	dk_call dk_exit 123;
}
