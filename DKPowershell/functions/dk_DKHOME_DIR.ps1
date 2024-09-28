if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DKHOME_DIR){ $dk_DKHOME_DIR = 1 } else{ return }

####################################################################
# dk_getDKPaths()
#
#
function Global:dk_DKHOME_DIR() {
	dk_debugFunc 0

	### DKHOME_DIR ###
	$global:DKHOME_DIR = "$env:HOMEDRIVE$env:HOMEPATH/digitalknob"
	$global:DKHOME_DIR = $DKHOME_DIR -replace '\\', '/';
    dk_call dk_printVar DKHOME_DIR
	
	### DKCACHE_DIR ###
	$global:DKCACHE_DIR = "$DKHOME_DIR/.dk"
    dk_call dk_makeDirectory $DKCACHE_DIR
    dk_call dk_printVar DKCACHE_DIR
	
	### DKDESKTOP_DIR ###
	$global:DKDESKTOP_DIR = "$DKHOME_DIR/Desktop"
    dk_call dk_printVar DKDESKTOP_DIR
	
	### DKTEMP_DIR ###
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMP}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMPDIR}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMP_DIR%}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" && dk_call dk_set DKTEMP_DIR "${DIGITALKNOB_DIR}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_fatal "unable to set .dk directory"
#	DKTEMP_DIR="${DKTEMP_DIR}/.dk"
#	[ -e "${DKTEMP_DIR}" ] ||  dk_makeDirectory "${DKTEMP_DIR}"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_DKHOME_DIR
	dk_call dk_echo "DIGITALKNOB_DIR = $DIGITALKNOB_DIR"
	dk_call dk_echo "DKTOOLS_DIR = $DKTOOLS_DIR"
	dk_call dk_echo "DKDOWNLOAD_DIR = $DKDOWNLOAD_DIR"
	dk_call dk_echo "DKTEMP_DIR = $DKTEMP_DIR"
}
