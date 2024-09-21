if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getHostTriple){ $dk_getHostTriple = 1 } else{ return }

#####################################################################
# dk_getHostTriple()
#
#
function Global:dk_getHostTriple() {
	dk_debugFunc 0

	$global:HOST_OS = "win"
    dk_call dk_printVar HOST_OS
	
	if( $Env:PROCESSOR_ARCHITECTURE -eq "x86")   { $global:HOST_ARCH = "x86" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "AMD64") { $global:HOST_ARCH = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "IA64")  { $global:HOST_ARCH = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "EM64T") { $global:HOST_ARCH = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "ARM64") { $global:HOST_ARCH = "arm64" }
    dk_call dk_printVar HOST_ARCH
	
	$global:HOST_TRIPLE = (-join($HOST_OS, "_", $HOST_ARCH))
    dk_call dk_printVar HOST_TRIPLE
    
	$global:HOST_ENV = "clang"
	$global:HOST_TRIPLE = (-join($HOST_TRIPLE, "_", $HOST_ENV))
	dk_call dk_printVar HOST_TRIPLE
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_getHostTriple
}
