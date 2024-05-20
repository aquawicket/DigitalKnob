#@echo off
#call DK

#####################################################################
# dk_getHostTriple()
#
#
function dk_getHostTriple () {
	dk_debugFunc
	
	$HOST_OS = "win"
    dk_printVar HOST_OS
	
	if ($PROCESSOR_ARCHITECTURE -eq "x86")   { $HOST_ARCH = x86 }
    if ($PROCESSOR_ARCHITECTURE -eq "AMD64") { $HOST_ARCH = x86_64 }
    if ($PROCESSOR_ARCHITECTURE -eq "IA64")  { $HOST_ARCH = x86_64 }
    if ($PROCESSOR_ARCHITECTURE -eq "EM64T") { $HOST_ARCH = x86_64 }
    if ($PROCESSOR_ARCHITECTURE -eq "ARM64") { $HOST_ARCH = arm64 }
    dk_printVar HOST_ARCH
	
	$HOST_TRIPLE = (-join($HOST_OS, "_", $HOST_ARCH))
    dk_printVar HOST_TRIPLE
    
    $HOST_ENV = clang
	$HOST_TRIPLE = (-join($HOST_TRIPLE, "_", $HOST_ENV))
	dk_printVar HOST_TRIPLE
}