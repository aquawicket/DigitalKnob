if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_trayAddOption){ $dk_trayAddOption = 1 } else{ return } #include guard

##################################################################################
# dk_tray()
#
#
function Global:dk_trayAddOption($trayContextMenu, $funk){
	#dk_debugFunc 2
	
	[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | out-null
	$Tray_Option = New-Object System.Windows.Forms.MenuItem
	$Tray_Option.Text = "Option 1"
	$trayContextMenu.MenuItems.AddRange($Tray_Option)
	
	$Tray_Option.Add_Click({
		$funk.Invoke()
	})
} 




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####


function Global:DKTEST() {
	#dk_debugFunc 0
	
	$trayContextMenu = dk_call dk_tray
	dk_call dk_trayAddOption $trayContextMenu onOption1
	
	$appContext = New-Object System.Windows.Forms.ApplicationContext
	[void][System.Windows.Forms.Application]::Run($appContext)
}

function Global:onOption1() {
	#dk_debugFunc 0

	Add-Type -AssemblyName PresentationCore,PresentationFramework
	[System.Windows.MessageBox]::Show("Option 1")
}
