if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_trayAddOption){ $dk_trayAddOption = 1 } else{ return } #include guard

##################################################################################
# dk_tray()
#
#
function Global:dk_trayAddOption($trayContextMenu, $func, $text){
	dk_debugFunc 3
	
	$Tray_Option = New-Object System.Windows.Forms.MenuItem
	$Tray_Option.Text = "$text"
	
	#$global:func = $func;  # $func loses scope inside Add_Click()
	$Tray_Option.Add_Click({
		&$func
	}.GetNewClosure())
	
	$trayContextMenu.MenuItems.Add($Tray_Option)
} 




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####


function Global:DKTEST() {
	dk_debugFunc 0
	
	$trayContextMenu = dk_call dk_tray
	dk_call dk_trayAddOption $trayContextMenu onOption1 "Option 1"
	dk_call dk_trayAddOption $trayContextMenu onExit "Exit"
	
	$appContext = New-Object System.Windows.Forms.ApplicationContext
	[void][System.Windows.Forms.Application]::Run($appContext)
}

function Global:onOption1() {
	Write-Host "Global:onOption1"
	Add-Type -AssemblyName PresentationCore,PresentationFramework
	[System.Windows.MessageBox]::Show("Option 1")
}

function Global:onExit() {
	Write-Host "Global:onExit"
	$Tray.Visible = $false
	Stop-Process $pid
}
