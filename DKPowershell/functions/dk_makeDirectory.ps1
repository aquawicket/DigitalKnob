if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_makeDirectory){ $dk_makeDirectory = 1 } else{ return } #include guard

####################################################################
# dk_makeDirectory(path)
#
#
function Global:dk_makeDirectory ($_path_) {
	dk_debugFunc 1
	
	if(!(Test-Path $_path_)){ 
		New-Item -Path "$_path_" -ItemType Directory 
	}
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_makeDirectory "MadeDirectory"
}
