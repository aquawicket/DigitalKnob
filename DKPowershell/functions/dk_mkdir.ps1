if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_mkdir_ps1){ $dk_mkdir_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_mkdir(path)
#
#
function Global:dk_mkdir(${_path_}) {
	dk_debugFunc 1;
	
	#${_path_} = $($args[0]) 
	
	if(!(Test-Path ${_path_})){ 
		New-Item -Path ${_path_} -ItemType Directory | Out-Null
	}
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_mkdir "Made Directory"
}
