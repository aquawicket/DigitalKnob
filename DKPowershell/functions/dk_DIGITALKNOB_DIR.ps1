if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DIGITALKNOB_DIR){ $dk_DIGITALKNOB_DIR = 1 } else{ return }

####################################################################
# dk_getDKPaths()
#
#
function Global:dk_DIGITALKNOB_DIR() {
	dk_debugFunc 0
	
	dk_call dk_validate DKHOME_DIR  "dk_call dk_DKHOME_DIR"

	### DIGITALKNOB_DIR ###
	$global:DIGITALKNOB="digitalknob"
	$global:DIGITALKNOB_DIR="${DKHOME_DIR}/${DIGITALKNOB}"
	dk_call dk_makeDirectory $DIGITALKNOB_DIR
	dk_call dk_printVar DIGITALKNOB_DIR

	### DKTOOLS_DIR ###
    $global:DKTOOLS_DIR = "$DIGITALKNOB_DIR/DKTools"
    dk_call dk_makeDirectory $DKTOOLS_DIR
    dk_call dk_printVar DKTOOLS_DIR
       
	### DKDOWNLOAD_DIR ###
    $global:DKDOWNLOAD_DIR = "$DIGITALKNOB_DIR/download"
    dk_call dk_makeDirectory $DKDOWNLOAD_DIR
    dk_call dk_printVar DKDOWNLOAD_DIR
	
	### DKCACHE_DIR ###
	$global:DKCACHE_DIR = "$DIGITALKNOB_DIR/cache"
    dk_call dk_makeDirectory $DKCACHE_DIR
    dk_call dk_printVar DKCACHE_DIR
	
	### DKTEMP_DIR ###
	#$global:DKTEMP_DIR = "$DIGITALKNOB_DIR/temp"
    #dk_call dk_makeDirectory $DKTEMP_DIR
    #dk_call dk_printVar DKTEMP_DIR
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_DIGITALKNOB_DIR
	dk_call dk_echo "DIGITALKNOB_DIR = $DIGITALKNOB_DIR"
	dk_call dk_echo "DKTOOLS_DIR = $DKTOOLS_DIR"
	dk_call dk_echo "DKDOWNLOAD_DIR = $DKDOWNLOAD_DIR"
	dk_call dk_echo "DKTEMP_DIR = $DKTEMP_DIR"
}
