if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getExtension){ $dk_getExtension = 1 } else{ return }

##################################################################################
# dk_getExtension(path) -> rtn_var
#
#
function Global:dk_getExtension ($path) {
	dk_debugFunc 1

	
	#$extension = (Get-Item $path ).Extension
	#$extension = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Extension   #Calls Resolve-Path but works for files that don't exist.
	#if(-not($extension)){ $extension = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	
	$extension = Split-Path $path -Extension # PS6.0+
	dk_printVar extension
	return $extension
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	
	$extension = dk_getExtension "/path/to/a/filename.txt"
	dk_echo "extension = ${extension}"
}