if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_pathExists_ps1){ $dk_pathExists_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_pathExists(filepath)
#
#
function Global:dk_pathExists(){
	dk_debugFunc 1;

	#$filepath = $args[0];

	if(Test-Path $args[0]){ 
		$global:dk_pathExists = $true; 
	} 
	else{ 
		$global:dk_pathExists = $false; 
	}
	
	return $dk_pathExists;
}





function Global:DKTEST(){ ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_pathExists "C:/Windows";
	dk_call dk_echo "dk_pathExists = ${dk_pathExists}";
	
	### Result as a condition (true)
	dk_call dk_echo;
	if(dk_call dk_pathExists "DK.ps1"){ dk_call dk_echo "The file exists"; }
	else{ dk_call dk_echo "The file does NOT exist"; }
	dk_call dk_echo "dk_pathExists = ${dk_pathExists}";
	
	### Result as a condition (false)
	dk_call dk_echo;
	if(dk_call dk_pathExists "nofile.ext"){ dk_call dk_echo "The file exists"; } 
	else{ dk_call dk_echo "The file does NOT exist"; }
	dk_call dk_echo "dk_pathExists = ${dk_pathExists}";
	
	
}
