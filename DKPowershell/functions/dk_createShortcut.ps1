if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_createShortcut){ $dk_createShortcut = 1 } else{ return } #include guard

##################################################################################
# dk_createShortcut(shortcut_path, target_path)
#
#
function Global:dk_createShortcut() {
	dk_debugFunc 0 99
	dk_call dk_debug("dk_createShortcut(${args}).ps1")
	
	$shortcut_path=$args[0]
	$target_path=$args[1]
	$arguments=$args[2]
	
	$shortcut_path = $shortcut_path -replace "/c/", "C:/"
	$shortcut_path = $shortcut_path -replace "/mnt/c/", "C:/"
	$shortcut_path = $shortcut_path -replace "/", "\"
	Write-Host "shortcut_path = $shortcut_path"
	
	$target_path = $target_path -replace "/c/", "C:/"
	$target_path = $target_path -replace "/mnt/c/", "C:/"
	$target_path = $target_path -replace "/", "\"
	
	if(dk_call dk_pathExists "${shortcut_path}"){ 
		dk_call dk_warning "${shortcut_path} already exists."
		#dk_call dk_delete "${shortcut_path}"
	}
	
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("${shortcut_path}")
	
	$Shortcut.Arguments = ${arguments}
#	$Shortcut.Description = "Shortcut Script";
#	$Shortcut.FullName = 
#	$Shortcut.Hotkey= "Ctrl+Alt+f";
#	$Shortcut.IconLocation = "notepad.exe, 0";
#	$Shortcut.RelativePath =
	$Shortcut.TargetPath = ${target_path}
#	$Shortcut.WindowStyle = 1;
#	$Shortcut.WorkingDirectory = strDesktop;
	
	#dk_call dk_debug "Shortcut.FullName = $Shortcut.FullName"
	$Shortcut.Save()
	
	#if(!(dk_call dk_pathExists "${shortcut_path}")){ dk_call dk_fatal "Failed to create shortcut:${shortcut_path}" }
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_createShortcut "C:/Users/Administrator/Desktop/digitalknob.lnk" "C:/Users/Administrator/digitalknob"
	#dk_call dk_createShortcut "C:\Users\Administrator\Desktop\HelloWorld.lnk" "C:\Windows\System32\wsl.exe" "/mnt/c/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/linux_x86_64/Debug/HelloWorld_APP"
	#dk_createShortcut "C:/Users/Administrator/digitalknob" "C:/Windows/System32/wsl.exe" "/mnt/c/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/linux_x86_64/Debug/HelloWorld_APP"
}
