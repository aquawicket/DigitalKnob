if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_trayAddOption_ps1){ $dk_trayAddOption_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_tray()
#
#
function Global:dk_trayAddOption($func, $text){
	dk_debugFunc 2;
	
	if(!($trayContextMenu)){
		$global:trayContextMenu = dk_call dk_tray;
	}
#	dk_call dk_trayAddOption $trayContextMenu $func $text
	
	$Tray_Option = New-Object System.Windows.Forms.MenuItem;
	$Tray_Option.Text = "$text";
	
	#$global:func = $func;  # $func loses scope inside Add_Click()
	$Tray_Option.Add_Click({
		&$func;
	}.GetNewClosure())
	
	$trayContextMenu.MenuItems.Add($Tray_Option);
	
	#return $text;
} 




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####


function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_trayAddOption onOption1 "Option 1";
	dk_call dk_trayAddOption onExit "Exit";
	dk_call dk_trayRun;
}

function Global:onOption1() {
	dk_debugFunc 0;
	
	#Write-Host "Global:onOption1";
	Add-Type -AssemblyName PresentationCore,PresentationFramework;
	[System.Windows.MessageBox]::Show("Option 1");
}

function Global:onExit() {
	dk_debugFunc 0;
	
	#Write-Host "Global:onExit";
	Stop-Process $pid;
}
