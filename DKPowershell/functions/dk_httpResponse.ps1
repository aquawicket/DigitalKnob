if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_httpResponse_ps1){ $dk_httpResponse_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_httpResponse()
#
#
function Global:dk_httpResponse() {
	dk_debugFunc 1 2;

	${url}=$args[0];
	
	$response = Invoke-WebRequest -Method Get -Uri "${url}" -MaximumRedirection 0 -ErrorAction SilentlyContinue
	$dk_httpResponse = $response.StatusCode
	
	###### return ######
	${global:dk_httpResponse} = ${dk_httpResponse};
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_httpResponse};
	} else {
		return ${dk_httpResponse};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_httpResponse "https://go.microsoft.com/fwlink/?linkid=2289980";
}
