if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_getDKPaths){ $dk_getDKPaths = 1 } else{ return }

dk_load dk_makeDirectory
dk_load dk_printVar
####################################################################
# dk_getDKPaths()
#
#
function Global:dk_getDKPaths () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$global:DIGITALKNOB_DIR = "$env:HOMEDRIVE$env:HOMEPATH/digitalknob"
	$DIGITALKNOB_DIR = $DIGITALKNOB_DIR -replace '\\', '/';
    dk_makeDirectory $DIGITALKNOB_DIR
    dk_printVar DIGITALKNOB_DIR

    $global:DKTOOLS_DIR = "$DIGITALKNOB_DIR/DKTools"
    dk_makeDirectory $DKTOOLS_DIR
    dk_printVar DKTOOLS_DIR
        
    $global:DKDOWNLOAD_DIR = "$DIGITALKNOB_DIR/download"
    dk_makeDirectory $DKDOWNLOAD_DIR
    dk_printVar DKDOWNLOAD_DIR
}




function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	
	dk_getDKPaths
	dk_echo "DIGITALKNOB_DIR = $DIGITALKNOB_DIR"
	dk_echo "DKTOOLS_DIR = $DKTOOLS_DIR"
	dk_echo "DKDOWNLOAD_DIR = $DKDOWNLOAD_DIR"
}