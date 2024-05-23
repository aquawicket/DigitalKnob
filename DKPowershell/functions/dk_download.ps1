if (!($DKINIT)){ . $PWD\DK.ps1 }

# https://www.itprotoday.com/powershell/3-ways-download-file-powershell

####################################################################
# dk_download(<url> <destination>)
#
#
function Global:dk_download($url, $dest) {
	dk_debugFunc
	
	#Write-Output "url = $url"
	#Write-Output "dest = $dest"
	
	# method 1
    #Invoke-WebRequest -URI $url -OutFile $dest
	
	# method 2
	(New-Object System.Net.WebClient).DownloadFile($url, $dest)
	
	# method 2 (extended)
	#$WebClient = New-Object System.Net.WebClient
	#$WebClient.UseDefaultCredentials = $true
	#$WebClient.DownloadFile($url, $dest)
	
	# method 3
	#Start-BitsTransfer -Source $url -Destination $dest
}


function Global:DKTEST() {
	dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.sh" "DKBuilder.sh"
}