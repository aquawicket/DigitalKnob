if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getDKPaths){ $dk_getDKPaths = 1 } else{ return }

####################################################################
# dk_getDKPaths()
#
#
function Global:dk_getDKPaths() {
	dk_debugFunc 0

	
	
	$global:DIGITALKNOB_DIR = "$env:HOMEDRIVE$env:HOMEPATH/digitalknob"
	$global:DIGITALKNOB_DIR = $DIGITALKNOB_DIR -replace '\\', '/';
    dk_makeDirectory $DIGITALKNOB_DIR
    dk_printVar DIGITALKNOB_DIR

    $global:DKTOOLS_DIR = "$DIGITALKNOB_DIR/DKTools"
    dk_makeDirectory $DKTOOLS_DIR
    dk_printVar DKTOOLS_DIR
        
    $global:DKDOWNLOAD_DIR = "$DIGITALKNOB_DIR/download"
    dk_makeDirectory $DKDOWNLOAD_DIR
    dk_printVar DKDOWNLOAD_DIR
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	
	dk_getDKPaths
	dk_echo "DIGITALKNOB_DIR = $DIGITALKNOB_DIR"
	dk_echo "DKTOOLS_DIR = $DKTOOLS_DIR"
	dk_echo "DKDOWNLOAD_DIR = $DKDOWNLOAD_DIR"
}