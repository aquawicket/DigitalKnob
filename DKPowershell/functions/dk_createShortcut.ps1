if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_createShortcut){ $dk_createShortcut = 1 } else{ return }

##################################################################################
# dk_createShortcut(shortcut_path, target_path)
#
#
function Global:dk_createShortcut($shortcut_path, $target_path) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	$shortcut_path = "${shortcut_path}.lnk"
	if(dk_pathExists "${shortcut_path}"){ dk_warning "${shortcut_path} already exists"; return; }
	
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut(${shortcut_path})
	$Shortcut.TargetPath = ${target_path}
	#$Shortcut.Arguments = $ArgumentsToSourceExe
	$Shortcut.Save()
	
	if(!(dk_pathExists "${shortcut_path}")){ dk_error "Failed to create shortcut:${shortcut_path}" }
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() { 
	dk_debugFunc
	
	dk_createShortcut "C:\Users\Administrator\Desktop\digitalknob" "C:\Users\Administrator\digitalknob"
}