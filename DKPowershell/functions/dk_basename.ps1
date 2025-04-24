<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_basename){ $dk_basename = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_basename){ $dk_basename = 1 } else{ return } #include guard
>>>>>>> Development

################################################################################
# dk_basename(path) -> rtn_var
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_basename($path) {
	dk_debugFunc 1

	#$basename = (Get-Item $path).Basename 
	#$basename = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).Basename    #Calls Resolve-Path but works for files that don't exist.
	#if(-not($rtn_var)){ $basename = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet

	$basename = Split-Path $path -leaf
	dk_call dk_printVar basename
	return $basename
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	$basename = dk_call dk_basename "C:/Windows/System32/test.v123.zip"
	dk_call dk_echo "basename = $basename"
	
	$basename = dk_call dk_basename "TEST"
	dk_call dk_echo "basename = $basename"
}
