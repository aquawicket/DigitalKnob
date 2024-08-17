if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_download){ $dk_download = 1 } else{ return }

####################################################################
# dk_download(url destination)
#
#   https://www.itprotoday.com/powershell/3-ways-download-file-powershell
#
function Global:dk_download($url, $destination) {
	dk_debugFunc 1 2
	echo "dk_download($url, $destination)"
	
	${url_filename} = Split-Path ${url} -leaf
	if(!(${url_filename})){ dk_call dk_error "url_filename invalid" }                                                                            
	
	if($args[0]){ $destination = dk_call dk_realpath $args[0] }
	if(!(${destination})){    
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_getDKPaths"
		$destination = "${DKDOWNLOAD_DIR}/${url_filename}"
	}
	if(!(${destination})){ dk_call dk_error "destination is invalid" }
	
	if(Test-Path -Path "${destination}" -PathType Container){ $destination = "${destination}/${url_filename}" }
	if(Test-Path "${destination}"){ dk_call dk_echo "${destination} already exist"; return }
	
	
	dk_call dk_echo "Downloading ${url_filename} . . ."
	
	# make sure the destination parent directory exists
	$destination_dir = dk_call dk_dirname "${destination}"
	if(!(${destination_dir})){ dk_call dk_error "destination_dir is invalid" }
	if(!(Test-Path "${destination_dir}")){ dk_call dk_makeDirectory "${destination_dir}" }
	
	# method 1
	Invoke-WebRequest -URI ${url} -OutFile ${destination} #-SkipHttpErrorCheck
	
	# method 2
	#(New-Object System.Net.WebClient).DownloadFile($url, $destination)
	
	# method 2 (extended)
	#$WebClient = New-Object System.Net.WebClient
	#$WebClient.UseDefaultCredentials = $true
	#$WebClient.DownloadFile($url, $destination)
	
	# method 3
	#Start-BitsTransfer -Source $url -Destination $destination
	
	
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.ps1"
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.ps1" "DKBuilder.ps1"
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.ps1" "${DKDOWNLOAD_DIR}/dk_download_powershell_test/DKBuilder.ps1"
}