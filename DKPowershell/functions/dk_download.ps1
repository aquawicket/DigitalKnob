
####################################################################
# dk_download(<url> <destination>)
#
#
Function dk_download($url, $dest) {

	Write-Output "url = $url"
	Write-Output "dest = $dest"
	
    #-Command (New-Object Net.WebClient).DownloadFile($url, $dest)
	$WebClient = New-Object System.Net.WebClient
	$WebClient.UseDefaultCredentials = $true
	$WebClient.DownloadFile($url, $dest)
}
