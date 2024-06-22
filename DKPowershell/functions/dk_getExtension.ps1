if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_getExtension){ $dk_getExtension = 1 } else{ return }

##################################################################################
# dk_getExtension(path) -> rtn_var
#
#
function Global:dk_getExtension ($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#$extension = (Get-Item $path ).Extension
	#$extension = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Extension   #Calls Resolve-Path but works for files that don't exist.
	#if(-not($extension)){ $extension = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	
	$extension = Split-Path $path -Extension # PS6.0+
	dk_printVar extension
	return $extension
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	$extension = dk_getExtension "/path/to/a/filename.txt"
	dk_echo "extension = ${extension}"
}