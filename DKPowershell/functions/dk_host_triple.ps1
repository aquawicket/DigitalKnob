<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_host_triple){ $dk_host_triple = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_host_triple){ $dk_host_triple = 1 } else{ return } #include guard
>>>>>>> Development

#####################################################################
# dk_host_triple()
#
#
function Global:dk_host_triple() {
	dk_debugFunc 0

<<<<<<< HEAD
	###### host_os and <os>_host ######
	$global:host_os="win"
	New-Variable -Name "$($host_os)_host" -Value 1 -Force

	###### host_arch and <arch>_host ######
	if( $Env:PROCESSOR_ARCHITECTURE -eq "x86")   { $global:host_arch = "x86" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "AMD64") { $global:host_arch = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "IA64")  { $global:host_arch = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "EM64T") { $global:host_arch = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "ARM64") { $global:host_arch = "arm64" }
	New-Variable -Name "$($host_arch)_host" -Value 1 -Force
	
	###### host_env and <env>_host ######
	$global:host_env="clang"
	if($host_env){
		New-Variable -Name "$($host_env)_host" -Value 1 -Force
    }
	
	###### host_triple and <triple>_host ######
	if($host_arch){
		$global:host_triple = (-join($host_os, "_", $host_arch))
		New-Variable -Name "$($host_triple)_host" -Value 1 -Force
	}
	
	if($host_env){
		$global:host_triple = (-join($host_os, "_", $host_arch, "_", $host_env))
		New-Variable -Name "$($host_triple)_host" -Value 1 -Force
=======
	###### host_os and <host_os>_host ######
	$global:Host_Os="Win"
	New-Variable -Name "$($Host_Os)_Host" -Value 1 -Force

	###### host_arch and <arch>_host ######
	if( $Env:PROCESSOR_ARCHITECTURE -eq "x86")   { $global:Host_Arch = "X86" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "AMD64") { $global:Host_Arch = "X86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "IA64")  { $global:Host_Arch = "X86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "EM64T") { $global:Host_Arch = "X86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "ARM64") { $global:Host_Arch = "Arm64" }
	New-Variable -Name "$($Host_Arch)_Host" -Value 1 -Force
	
	###### host_env and <host_env>_host ######
	$global:Host_Env="Clang"
	if($Host_Env){
		New-Variable -Name "$($Host_Env)_Host" -Value 1 -Force
    }
	
	###### host_triple and <host_triple>_host ######
	if($Host_Arch){
		$global:Host_Triple = (-join($Host_Os, "_", $Host_Arch))
		New-Variable -Name "$($Host_Triple)_Host" -Value 1 -Force
	}
	
	if($host_env){
		$global:Host_Triple = (-join($Host_Os, "_", $Host_Arch, "_", $Host_Env))
		New-Variable -Name "$($Host_Triple)_Host" -Value 1 -Force
>>>>>>> Development
	}

	
#${DEBUG}
<<<<<<< HEAD
	dk_call dk_printVar host_os
	dk_call dk_printVar ${host_os}_host
	
	dk_call dk_printVar host_arch 
	dk_call dk_printVar ${host_arch}_host
	dk_call dk_printVar ${host_os}_${host_arch}_host
	
	dk_call dk_printVar host_env
	dk_call dk_printVar ${host_env}_host
	dk_call dk_printVar ${host_os}_${host_arch}_${host_env}_host
	
	dk_call dk_printVar host_triple
	dk_call dk_printVar ${host_triple}_host
=======
	dk_call dk_printVar Host_Os
	dk_call dk_printVar ${Host_Os}_Host
	
	dk_call dk_printVar Host_Arch 
	dk_call dk_printVar ${Host_Arch}_Host
	dk_call dk_printVar ${Host_Os}_${Host_Arch}_Host
	
	dk_call dk_printVar Host_Env
	dk_call dk_printVar ${Host_Env}_Host
	dk_call dk_printVar ${Host_Os}_${Host_Arch}_${Host_Env}_Host
	
	dk_call dk_printVar Host_Triple
	dk_call dk_printVar ${Host_Triple}_Host
>>>>>>> Development
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_host_triple
}
