if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_dirname){ $dk_dirname = 1 } else{ return }

################################################################################
# dk_dirname(path)   return -> rtn_var
#
#
function Global:dk_dirname($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	#$dirname = (Get-Item $path).DirectoryName
	#$dirname = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).DirectoryName    #Calls Resolve-Path but works for files that don't exist.
	#if(-not($dirname)){ $dirname = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	$dirname = Split-Path $path -Parent 
	dk_printVar dirname 
	return $dirname
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	$dirname = dk_dirname "C:/Windows/System32"
	dk_echo "dirname = $dirname"
	
	$dirname = dk_dirname "TEST"
	dk_echo "dirname = $dirname"
}