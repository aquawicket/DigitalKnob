if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_findProgram_ps1){ $dk_findProgram_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_findProgram(<var> name [path1 path2 ...])
#
#
function Global:dk_findProgram() {
	dk_debugFunc 2 9;
	
	${_var_}=$($args[0]);
	${_name_}=$($args[1]);
	${_path_}=$($args[2]);
	if(!${_path_}){
		${_path_}="${ENV:SystemDrive}\";
	}
	
	$(get-childitem ${_path_} -Filter ${_name_} -Recurse -ErrorAction SilentlyContinue -Force | % {${dk_findProgram} = $_.FullName});
	
	${global:dk_findProgram} = ${dk_findProgram};
	Set-Variable -Name ${_var_} -Value ${dk_findProgram} -Scope Global;
	return ${dk_findProgram};
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	#dk_call dk_findProgram curl_exe "curl.exe";
	dk_call dk_findProgram curl_exe "curl.exe" "C:/Windows/System32";
	dk_call dk_echo "curl_exe = ${curl_exe}";
}