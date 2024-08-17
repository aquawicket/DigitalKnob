if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pathExists){ $dk_pathExists = 1 } else{ return }

##################################################################################
# dk_pathExists(filepath)
#
#
function Global:dk_pathExists($filepath){
	dk_debugFunc 1

	if(Test-Path $filepath){ $pathExists = $true } 
	else { $pathExists = $false }
	
	#dk_call dk_printVar pathExists
	return $pathExists
}



function Global:DKTEST(){ ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc 0
	
	if(dk_call dk_pathExists "DK.ps1"){ dk_call dk_info "The file exists" }
	else{ dk_call dk_info "The file does NOT exist" }
	
	if(dk_call dk_pathExists "nofile.ext"){ dk_call dk_info "The file exists" } 
	else{ dk_call dk_info "The file does NOT exist" }
}
