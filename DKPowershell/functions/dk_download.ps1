if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_download_ps1){ $dk_download_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_download(url destination)
#
#   https://www.itprotoday.com/powershell/3-ways-download-file-powershell
#
function Global:dk_download() {
	dk_debugFunc 1 2;
	dk_call dk_echo "dk_download($args)";
	
	${url}=$args[0];
	${destination}=$args[1];
	
	${url_filename} = Split-Path ${url} -leaf;
	dk_call dk_assertVar "url_filename";

	#if($args[0]){ $destination = dk_call dk_realpath $args[0]; }
	if(!(${destination})){    
		dk_call dk_validate env:DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR";
		$destination = "${env:DKDOWNLOAD_DIR}/${url_filename}";
	}
	dk_call dk_assertVar "destination";
	
	if(Test-Path -Path "${destination}" -PathType Container){ $destination = "${destination}/${url_filename}"; }
	${global:dk_download}="${destination}";
	if(Test-Path "${destination}"){ 
		dk_call dk_echo "${destination} already exist. Specify OVERWRITE to re-download.\n"; 
		return 0; 
	}
	
	dk_call dk_echo "Downloading ${url_filename} . . .\n";
	
	# make sure the destination parent directory exists
	${global:destination_dir} = dk_call dk_dirname "${destination}";
	dk_call dk_assertVar "destination_dir";
	if(!Test-Path "${destination_dir}"){ dk_call dk_mkdir "${destination_dir}"; }
	
	# method 1
	Invoke-WebRequest -URI ${url} -OutFile ${destination} -ErrorAction SilentlyContinue; #-SkipHttpErrorCheck;
	
	# method 2
	#(New-Object System.Net.WebClient).DownloadFile($url, $destination);
	
	# method 2 (extended)
	#$WebClient = New-Object System.Net.WebClient;
	#$WebClient.UseDefaultCredentials = $true;
	#$WebClient.DownloadFile($url, $destination);
	
	# method 3
	#Start-BitsTransfer -Source $url -Destination $destination;
	
	
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/apps/DKBuilder/DKBuilder.ps1";
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/apps/DKBuilder/DKBuilder.ps1" "DKBuilder.ps1";
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/apps/DKBuilder/DKBuilder.ps1" "${env:DKDOWNLOAD_DIR}/dk_download_powershell_test/DKBuilder.ps1";
}