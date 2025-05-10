if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_host_tuple){ $dk_host_tuple = 1 } else{ return } #include guard

#####################################################################
# dk_host_tuple()
#
#
function Global:dk_host_tuple() {
	dk_debugFunc 0

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
	
	###### host_tuple and <host_tuple>_host ######
	if($Host_Arch){
		$global:Host_Tuple = (-join($Host_Os, "_", $Host_Arch))
		New-Variable -Name "$($Host_Tuple)_Host" -Value 1 -Force
	}
	
	if($host_env){
		$global:Host_Tuple = (-join($Host_Os, "_", $Host_Arch, "_", $Host_Env))
		New-Variable -Name "$($Host_Tuple)_Host" -Value 1 -Force
	}

	
#${DEBUG}
	dk_call dk_printVar Host_Os
	dk_call dk_printVar ${Host_Os}_Host
	
	dk_call dk_printVar Host_Arch 
	dk_call dk_printVar ${Host_Arch}_Host
	dk_call dk_printVar ${Host_Os}_${Host_Arch}_Host
	
	dk_call dk_printVar Host_Env
	dk_call dk_printVar ${Host_Env}_Host
	dk_call dk_printVar ${Host_Os}_${Host_Arch}_${Host_Env}_Host
	
	dk_call dk_printVar Host_Tuple
	dk_call dk_printVar ${Host_Tuple}_Host
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_host_tuple
}
