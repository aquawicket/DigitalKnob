if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_host_triple){ $dk_host_triple = 1 } else{ return } #include guard

#####################################################################
# dk_host_triple()
#
#
function Global:dk_host_triple() {
	dk_debugFunc 0

	###### host_os and <host_os>_host ######
	$global:host_os="win"
	New-Variable -Name "$($host_os)_host" -Value 1 -Force

	###### host_arch and <arch>_host ######
	if( $Env:PROCESSOR_ARCHITECTURE -eq "x86")   { $global:host_arch = "x86" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "AMD64") { $global:host_arch = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "IA64")  { $global:host_arch = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "EM64T") { $global:host_arch = "x86_64" }
	if( $Env:PROCESSOR_ARCHITECTURE -eq "ARM64") { $global:host_arch = "arm64" }
	New-Variable -Name "$($host_arch)_host" -Value 1 -Force
	
	###### host_env and <host_env>_host ######
	$global:host_env="clang"
	if($host_env){
		New-Variable -Name "$($host_env)_host" -Value 1 -Force
    }
	
	###### host_triple and <host_triple>_host ######
	if($host_arch){
		$global:host_triple = (-join($host_os, "_", $host_arch))
		New-Variable -Name "$($host_triple)_host" -Value 1 -Force
	}
	
	if($host_env){
		$global:host_triple = (-join($host_os, "_", $host_arch, "_", $host_env))
		New-Variable -Name "$($host_triple)_host" -Value 1 -Force
	}

	
#${DEBUG}
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
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_host_triple
}
