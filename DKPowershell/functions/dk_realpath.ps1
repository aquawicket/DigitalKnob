if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_realpath){ $dk_realpath = 1 } else{ return } #include guard

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    POWERSHELL: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/resolve-path?view=powershell-7.4
#
function Global:dk_realpath($path) {
	dk_debugFunc 1
	
	$realpath = Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror #Calls Resolve-Path but works for files that don't exist.
	if(-not($realpath)){ $realpath = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	dk_call dk_printVar realpath
	return ${realpath}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() { 
	dk_debugFunc 0
	
	$realpath = dk_call dk_realpath DK.ps1 
	dk_echo "realpath = ${realpath}"
}
