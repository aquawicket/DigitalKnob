if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_createSymlink_ps1){ $dk_createSymlink_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_createSymlink(src_path, symlink_path)
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_createSymlink() {
	dk_debugFunc 0 99;

	if($($args[0])){ ${src_path} = $($args[0]); } 
	if($($args[1])){ ${symlink_path} = $($args[1]); }
	
	#New-Item -ItemType SymbolicLink -Path ${src_path} -Target ${symlink_path};
	New-Item -ItemType SymbolicLink -Path ${symlink_path} -Target ${src_path}; 
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_createSymlink "$(dk_call dk_DIGITALKNOB_DIR)" "$(dk_call dk_DKDESKTOP_DIR)";
}
