if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_basename){ $dk_basename = 1 } else{ return }

################################################################################
# dk_basename(path) -> rtn_var
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_basename($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	#$basename = (Get-Item $path).Basename 
	#$basename = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Basename    #Calls Resolve-Path but works for files that don't exist.
	#if(-not($rtn_var)){ $basename = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet

	$basename = Split-Path $path -leaf
	dk_printVar basename
	return $basename
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	$basename = dk_basename "C:/Windows/System32/test.v123.zip"
	dk_echo "basename = $basename"
	
	$basename = dk_basename "TEST"
	dk_echo "basename = $basename"
}