if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_tray){ $dk_tray = 1 } else{ return } #include guard

##################################################################################
# dk_tray()
#
#
function Global:dk_tray(){
	dk_debugFunc 0
	
	[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | out-null
	$icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:/Windows/System32/mmc.exe")	
	$Tray = New-Object System.Windows.Forms.NotifyIcon
	$Tray.Text = "DigitalKnob Systray"
	$Tray.Icon = $icon
	$Tray.Visible = $true
	$Tray.ContextMenu = New-Object System.Windows.Forms.ContextMenu
	$TrayContextMenu = $Tray.ContextMenu
	
	### Create an application context for it to all run within. ###
	# This helps with responsiveness, especially when clicking Exit.
#	$appContext = New-Object System.Windows.Forms.ApplicationContext
#	[void][System.Windows.Forms.Application]::Run($appContext)

	return $TrayContextMenu;
} 


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_tray
}
