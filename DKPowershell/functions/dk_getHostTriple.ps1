if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_getHostTriple){ $dk_getHostTriple = 1 } else{ return }

#####################################################################
# dk_getHostTriple()
#
#
function Global:dk_getHostTriple() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$global:HOST_OS = "win"
    dk_printVar HOST_OS
	
	if( $Env:PROCESSOR_ARCHITECTURE -eq "x86")   { $global:HOST_ARCH = "x86" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "AMD64") { $global:HOST_ARCH = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "IA64")  { $global:HOST_ARCH = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "EM64T") { $global:HOST_ARCH = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "ARM64") { $global:HOST_ARCH = "arm64" }
    dk_printVar HOST_ARCH
	
	$global:HOST_TRIPLE = (-join($HOST_OS, "_", $HOST_ARCH))
    dk_printVar HOST_TRIPLE
    
	$global:HOST_ENV = "clang"
	$global:HOST_TRIPLE = (-join($HOST_TRIPLE, "_", $HOST_ENV))
	dk_printVar HOST_TRIPLE
}






function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	dk_getHostTriple
}