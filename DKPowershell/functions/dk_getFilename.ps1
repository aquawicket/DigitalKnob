if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getFilename){ $dk_getFilename = 1 } else{ return }	
	
dk_load dk_printVar
##################################################################################
# dk_getFilename(path) -> rtn_var
#
#
function Global:dk_getFilename ($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	#$filename = (Get-Item $path ).Name
	#$filename = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Name   #Calls Resolve-Path but works for files that don't exist.
	#if(-not($rtn_var)){ $rtn_var = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	$filename = Split-Path $path -leaf
	dk_printVar filename
	return $filename
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	$filename = dk_getFilename "/path/to/a/filename.txt"
	dk_echo "filename = ${filename}"
}