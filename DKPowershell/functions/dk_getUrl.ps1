if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getUrl_ps1){ $dk_getUrl_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_getUrl(url rtn_var:optional)
#
#
function Global:dk_getUrl() {
	dk_debugFunc 1 2;

	###### input ######
	# $args[0] = _url
	# $args[1] = _rtn_var (optional)
	
	${_url} = $($args[0]);
	
	### curl method ###
	#dk_call dk_validate curl_exe "dk_call dk_depend curl_exe";
	#dk_getUrl=$(${curl_exe} --silent --show-error --head --output nul --write-out "%{redirect_url}" ${_url});
	
	$response = Invoke-WebRequest -Method Get -Uri ${_url} -MaximumRedirection 0 -ErrorAction SilentlyContinue;
	$dk_getUrl = $response.Headers.Location;
	#if($dk_getUrl){ $dk_getUrl = $dk_getUrl.Trim(); }
	
	###### return ######
	${global:dk_getUrl} = ${dk_getUrl};
	
	###### return ######
	${global:dk_getUrl} = ${dk_getUrl};
	if($args[1]) {
		dk_call dk_set $($args[1]) ${dk_getUrl};
	} else {
		return ${dk_getUrl};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	### Result as global variable
	dk_call dk_echo;
	${url} = "https://go.microsoft.com/fwlink/?linkid=2289980";
	dk_call dk_getUrl "${url}";
	dk_call dk_echo "dk_getUrl = ${dk_getUrl}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_getUrl "${url}" url_B;
	dk_call dk_echo "dk_getUrl = ${dk_getUrl}";
	dk_call dk_echo "url_B = ${url_B}";
	
	### Result as return value
	dk_call dk_echo;
	$resultC = dk_call dk_getUrl "${url}";
	dk_call dk_echo "dk_getUrl = ${dk_getUrl}";
	dk_call dk_echo "resultC = ${resultC}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_getUrl "${url}" resultD.value;
	dk_call dk_echo "dk_getUrl = ${dk_getUrl}";
	dk_call dk_echo "resultD.value = ${resultD.value}";
	
	### Result as variable parameter (same as input)
	dk_call dk_echo;
	dk_call dk_getUrl "${url}" url;		# FIXME
	dk_call dk_echo "dk_getUrl = ${dk_getUrl}";
	dk_call dk_echo "url = ${url}";
}
