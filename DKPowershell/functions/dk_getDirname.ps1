if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getDirname){ $dk_getDirname = 1 } else{ return }


################################################################################
# dk_getDirname(<path>)   return <rtn_var>
#
#
function Global:dk_getDirname($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$rtn_var = (Get-Item $path).DirectoryName
	dk_printVar rtn_var
	return $rtn_var
}




function Global:DKTEST() { ########################################################################

	$dirname = dk_getDirname "C:\Windows\System32"
	echo "dirname = $dirname"
	
	$dirname = dk_getDirname "TEST"
	echo "dirname = $dirname"
}