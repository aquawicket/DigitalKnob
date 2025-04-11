if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_mkdir){ $dk_mkdir = 1 } else{ return } #include guard

####################################################################
# dk_mkdir(path)
#
#
function Global:dk_mkdir ($_path_) {
	dk_debugFunc 1
	
	if(!(Test-Path $_path_)){ 
		New-Item -Path "$_path_" -ItemType Directory 
	}
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_mkdir "MadeDirectory"
}
