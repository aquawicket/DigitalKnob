if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_createShortcut_ps1){ $dk_createShortcut_ps1 = 1; } else{ return; } #include guard


##################################################################################
# dk_createShortcut(src_path, shortcut_path)
#
#
function Global:dk_createShortcut() {
	dk_debugFunc 0 99
	dk_call dk_debug("dk_createShortcut(${args}).ps1");
	
	dk_call dk_debug("$args[0], $args[1], $args[2]");
	$src_path=$args[0];
	$shortcut_path=$args[1];
	$arguments=$args[2];

#	$extension = dk_call dk_getExtension "${shortcut_path}";
#	if("$extension" -ne ".lnk"){
#		dk_call dk_warning "Shortcuts need to have a .lnk or .url extension";
#	}

	$shortcut_path = $shortcut_path -replace ".url", "";
	$shortcut_path = $shortcut_path -replace ".lnk", "";
	$shortcut_path="${shortcut_path}.lnk";
		
	$src_path = $src_path -replace "/c/", "C:/";
	$src_path = $src_path -replace "/mnt/c/", "C:/";
	$src_path = $src_path -replace "/", "\";
	
	$shortcut_path = $shortcut_path -replace "/c/", "C:/";
	$shortcut_path = $shortcut_path -replace "/mnt/c/", "C:/";
	$shortcut_path = $shortcut_path -replace "/", "\";
	
	if(dk_call dk_pathExists "${shortcut_path}"){ 
		dk_call dk_warning "${shortcut_path} already exists.";
		#dk_call dk_delete "${shortcut_path}";
	}
	
	$WshShell = New-Object -comObject WScript.Shell;
	$Shortcut = $WshShell.CreateShortcut("${shortcut_path}");
	
	$Shortcut.Arguments = ${arguments};
#	$Shortcut.Description = "Shortcut Script";
#	$Shortcut.FullName =;
#	$Shortcut.Hotkey= "Ctrl+Alt+f";
#	$Shortcut.IconLocation = "notepad.exe, 0";
#	$Shortcut.RelativePath =;
	$Shortcut.TargetPath = ${src_path};
#	$Shortcut.WindowStyle = 1;
#	$Shortcut.WorkingDirectory = strDesktop;
	
	#dk_call dk_debug "Shortcut.FullName = $Shortcut.FullName";
	$Shortcut.Save();
	
	#if(!(dk_call dk_pathExists "${shortcut_path}")){ dk_call dk_fatal "Failed to create shortcut:${shortcut_path}"; }
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_createShortcut "${ENV:USERPROFILE}/Digital Knob" "${ENV:USERPROFILE}/Desktop/DigitalKnob.lnk";
}
