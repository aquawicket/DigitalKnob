if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/../../DKPowershell/functions/DK.ps1; }
if(!$curl_DKINSTALL_ps1){ $curl_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;

	if(!${curl_exe}){ ${curl_exe} = "curl.exe"; }

	### Test if already valid
	if(Test-Path "${curl_exe}"){ 
		if(dk_call "${curl_exe}" --version){ return; }
	}


	if(!(Test-Path "${curl_exe}")){ ${curl_exe} = "C:/Windows/System32/curl.exe"; }
	if(!(Test-Path "${curl_exe}")){ ${curl_exe} = $(dk_call dk_findProgram curl_exe "curl.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${curl_exe}")){ dk_call dk_error "curl_exe:${curl_exe} not found"; return;}

	### Test command
	if(!(dk_call "${curl_exe}" --version)){ dk_call dk_error "curl_exe:${curl_exe} failed to run"; return;}
	
	
	###### output ######
	${global:curl_exe} = ${curl_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${curl_exe};
#	#} else {
		return ${curl_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_validate curl_exe "dk_call dk_depend curl_exe";
	dk_call dk_echo "curl_exe = ${curl_exe}";
	
	dk_call dk_validate curl_exe "dk_call dk_depend curl_exe";
	dk_call dk_echo "curl_exe = ${curl_exe}";
}
