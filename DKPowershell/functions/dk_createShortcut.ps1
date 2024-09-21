Write-Host "DKSCRIPT_PATH = $DKSCRIPT_PATH"
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_createShortcut){ $dk_createShortcut = 1 } else{ return }

##################################################################################
# dk_createShortcut(shortcut_path, target_path)
#
#
function Global:dk_createShortcut($shortcut_path, $target_path) {
	dk_debugFunc 2

	#$shortcut_path = "${shortcut_path}.lnk"
	if(dk_call dk_pathExists "${shortcut_path}"){ dk_call dk_warning "${shortcut_path} already exists"; return; }
	
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut(${shortcut_path})
	$Shortcut.TargetPath = ${target_path}
	#$Shortcut.Arguments = $ArgumentsToSourceExe
	$Shortcut.Save()
	
	if(!(dk_call dk_pathExists "${shortcut_path}")){ dk_call dk_error "Failed to create shortcut:${shortcut_path}" }
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_createShortcut "C:\Users\Administrator\Desktop\digitalknob.lnk" "C:\Users\Administrator\digitalknob"
}
