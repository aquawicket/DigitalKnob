if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getDirectories){ $dk_getDirectories = 1 } else{ return }

dk_load dk_error
dk_load dk_printVar
################################################################################
# dk_getDirectories(path) -> rtn_var
#
#
#
function Global:dk_getDirectories($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$directories = Get-ChildItem $path | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}
	   
	dk_printVar directories
	return $directories
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$directories = dk_getDirectories "C:\Windows"
	dk_info "directories = $directories"
}	