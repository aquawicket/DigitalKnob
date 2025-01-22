if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_source){ $dk_source = 1 } else{ return } #include guard

####################################################################
# dk_source(milliseconds)
#
function Global:dk_source($func) {
	#if(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_debugFunc.ps1"){ dk_debugFunc 1 }
	$all_args = $PsBoundParameters.Values + ${args}
	#Write-Host "dk_source($all_args)"

	if(!${func}){
		Write-Host "ERROR: func:${func} is invalid";
		return;
	}
	
	# load if it's an existing full path file
	if((${func}) -and (Test-Path "${func}")){
		. "${func}"
		return
	}
	
	#Write-Host "func = ${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1";
	if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1")){ Write-Host "downloading ${func} . . ." }
	if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/${func}.ps1" -OutFile "${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1" }
	if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1")){ Write-Host "ERROR: Failed to download ${func}."; return }
	
	#Write-Host "func = ${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1";
	. ${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1;
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_source dk_info
	dk_info "test message using dk_source to download it first"
}
