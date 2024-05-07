#@echo off
#call DK

####################################################################
# dk_getDKPaths()
#
#
function dk_getDKPaths () {
	dk_debugFunc
	
	$DIGITALKNOB_DIR = "$env:HOMEDRIVE$env:HOMEPATH\digitalknob"
    dk_makeDirectory $DIGITALKNOB_DIR
    dk_printVar DIGITALKNOB_DIR


    $DKTOOLS_DIR = "$DIGITALKNOB_DIR\DKTools"
    dk_makeDirectory $DKTOOLS_DIR
    dk_printVar DKTOOLS_DIR
        
    $DKDOWNLOAD_DIR = "$DIGITALKNOB_DIR\download"
    dk_makeDirectory $DKDOWNLOAD_DIR
    dk_printVar DKDOWNLOAD_DIR
}