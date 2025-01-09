if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getExtension){ $dk_getExtension = 1 } else{ return } #include guard

##################################################################################
# dk_getExtension(path) -> rtn_var
#
#   Reference: https://stackoverflow.com/a/9788998/688352
#   		   https://learn.microsoft.com/en-us/dotnet/api/system.io.path?view=netstandard-2.1
#
function Global:dk_getExtension ($path) {
	dk_debugFunc 1

	#$extension = Split-Path $path -Extension # PS6.0+
	
	#$extension = (Get-Item $path ).Extension
	#$extension = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Extension   #Calls Resolve-Path but works for files that don't exist.
	#if(-not($extension)){ $extension = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	
	$extension = [System.IO.Path]::GetExtension("$path")
	
	#dk_call dk_printVar extension
	return $extension
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$extension = dk_call dk_getExtension "/path/to/a/filename.txt"
	
	
	dk_call dk_echo "extension = ${extension}"
}
