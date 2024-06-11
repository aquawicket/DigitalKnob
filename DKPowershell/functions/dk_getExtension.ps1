if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getExtension){ $dk_getExtension = 1 } else{ return }

dk_load dk_error
dk_load dk_printVar
##################################################################################
# dk_getExtension(path) -> rtn_var
#
#
function Global:dk_getExtension () {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#$rtn_var = (Get-Item $path ).Extension
	$rtn_var = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Extension   #Calls Resolve-Path but works for files that don't exist.
	if(-not($rtn_var)){ $rtn_var = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	dk_printVar rtn_var
	return $rtn_var
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$extension = dk_getExtension "/path/to/a/filename.txt"
	echo "extension = ${extension}"
}