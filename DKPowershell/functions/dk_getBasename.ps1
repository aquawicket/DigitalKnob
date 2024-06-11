if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getBasename){ $dk_getBasename = 1 } else{ return }

dk_load dk_printVar
################################################################################
# dk_getBasename(<path>)   return <output>
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_getBasename($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#$rtn_var = (Get-Item $path).Basename 
	$rtn_var = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Basename    #Calls Resolve-Path but works for files that don't exist.
	if(-not($rtn_var)){ $rtn_var = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	dk_printVar rtn_var
	return $rtn_var
}




function Global:DKTEST() { ########################################################################

	$name = dk_getBasename "C:\Windows\System32"
	echo "name = $name"
	
	$namb = dk_getBasename "TEST"
	echo "nameb = $nameb"
}