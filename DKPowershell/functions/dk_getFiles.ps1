if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getFiles){ $dk_getFiles = 1 } else{ return }

dk_load dk_error
dk_load dk_printVar
################################################################################
# dk_getFiles(path) return -> rtn_var
#
#
#
function Global:dk_getFiles($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$files = Get-ChildItem $path | Where-Object {$_.PSIsContainer -eq $false} | Foreach-Object {$_.Name}
	   
	return $files
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$result = dk_getFiles "C:\Windows"
	dk_printVar result
}	