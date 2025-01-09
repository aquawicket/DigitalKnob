if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_messageBox){ $dk_messageBox = 1 } else{ return } #include guard

##################################################################################
# dk_messageBox()
#
#
function Global:dk_messageBox() {
	dk_debugFunc 0

	$message = $args[0]
	Add-Type -AssemblyName PresentationCore,PresentationFramework
	[System.Windows.MessageBox]::Show($message)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_messageBox "dk_messageBox test message" 
}