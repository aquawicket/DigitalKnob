if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##################################################################################
# dk_startPackage()
#
#    https://superuser.com/a/1678974/600216
#
function Global:dk_startPackage (){
	dk_debugFunc 0

	$name = "$($args[0])"	
	$packagePath = dk_call dk_getPackagePath("$name")
	
	# expand html escape codes
	$packagePath = dk_call dk_replaceAll $packagePath "#33" "!"
	
	Write-Output "packagePath = ${packagePath}"
	start-process "${packagePath}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_startPackage Debian
}
