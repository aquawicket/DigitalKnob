if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getDirname){ $dk_getDirname = 1 } else{ return }

dk_load dk_printVar
################################################################################
# dk_getDirname(path)   return -> rtn_var
#
#
function Global:dk_getDirname($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#$dirname = (Get-Item $path).DirectoryName
	#$dirname = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).DirectoryName    #Calls Resolve-Path but works for files that don't exist.
	#if(-not($dirname)){ $dirname = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	$dirname = Split-Path $path -Parent 
	dk_printVar dirname 
	return $dirname
}




function Global:DKTEST() { ########################################################################

	$dirname = dk_getDirname "C:\Windows\System32"
	echo "dirname = $dirname"
	
	$dirname = dk_getDirname "TEST"
	echo "dirname = $dirname"
}