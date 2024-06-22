if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_download){ $dk_download = 1 } else{ return }

####################################################################
# dk_download(url destination)
#
#   https://www.itprotoday.com/powershell/3-ways-download-file-powershell
#
function Global:dk_download($url, $destination) {
	dk_debugFunc
	
	if(Test-Path "${destination}"){
        Write-Host "${destination} already exist"
        return
    }
	
	Write-Host "Downloading $url . . ."
	
	# method 1
    Invoke-WebRequest -URI $url -OutFile $destination #-SkipHttpErrorCheck
	
	# method 2
	#(New-Object System.Net.WebClient).DownloadFile($url, $destination)
	
	# method 2 (extended)
	#$WebClient = New-Object System.Net.WebClient
	#$WebClient.UseDefaultCredentials = $true
	#$WebClient.DownloadFile($url, $destination)
	
	# method 3
	#Start-BitsTransfer -Source $url -Destination $destination
}


function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.ps1" "DKBuilder.ps1"
}