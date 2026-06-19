if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getUrls_ps1){ $dk_getUrls_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_getUrls(directory, filePattern, output_file)
#
#    Function description
#
#   @directory		- the directory to search
#	@filePattern	- the file Pattern to search      EXAMPLE:	*.html
#	@output_file	- File to wrie the url list to
#
function Global:dk_getUrls() {
	dk_debugFunc 0 99;
	
	$directory = $($args[0]);
	$filePattern = $($args[1]);
	$output_file = $($args[2]);
	Write-Host "dk_getUrls($directory, $filePattern, $output_file)";
	
	set-location "${directory}";
	#Get-ChildItem -Recurse -File -Filter '*.html' |
	Get-ChildItem -Recurse -File -Filter "${filePattern}" |
    Select-String -Pattern '(https?|ftp|file):\/\/\)?[-A-Za-z0-9+&@#\/%?=~_|!:,.;]+[-A-Za-z0-9+&@#\/%=~_|]' |
    ForEach-Object { $_.Matches.Value } |
	Out-File "${output_file}"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	
	#dk_call dk_getUrls '${ENV:USERPROFILE}/Desktop/aquawicket.com/SOCIAL_MEDIA/Messenger/messages/inbox/raineyharley__kwncku83q' '*.html' '~/Desktop/results.txt'
	
	dk_call dk_getUrls '${ENV:USERPROFILE}/Digital Knob/Development/3rdParty/_DKIMPORTS' '*.*' '~/Desktop/IMPORT_URLS.txt'
}
