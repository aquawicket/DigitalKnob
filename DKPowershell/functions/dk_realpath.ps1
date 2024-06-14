if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_realpath){ $dk_realpath = 1 } else{ return }

dk_load dk_error
dk_load dk_printVar
##################################################################################
# dk_realpath(path) -> rtn_var
#
#
function Global:dk_realpath($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$realpath = Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror #Calls Resolve-Path but works for files that don't exist.
	if(-not($realpath)){ $realpath = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	dk_printVar realpath
	return ${realpath}
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	$realpath = dk_realpath dk_load.ps1 
	echo "realpath = ${realpath}"
}