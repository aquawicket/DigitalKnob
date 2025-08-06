if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_dirname_ps1){ $dk_dirname_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_dirname(path)
#
#
function Global:dk_dirname() {
	dk_debugFunc 1 2;
	
	${_path_} = $args[0];
	if(Test-Path variable:${_path_}){ ${_path_} = Get-Variable -Name (${_path_}) -ValueOnly; } 
	
	${dk_dirname} = Split-Path ${_path_} -Parent;

	### return value ###
	${global:dk_dirname} = ${dk_dirname}
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_dirname};
	} else {
		return ${dk_dirname};
	}
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	${dk_dirname} = dk_call dk_dirname "C:/Windows/System32";
	dk_call dk_echo "dk_dirname = $dk_dirname\n";
	
	${dk_dirname} = dk_call dk_dirname "Test1/Test2";
	dk_call dk_echo "dk_dirname = $dk_dirname\n";
}
