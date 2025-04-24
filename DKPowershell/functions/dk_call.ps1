<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_call){ $dk_call = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_call){ $dk_call = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_call(command, args)
#
#
function Global:dk_call(){
	#dk_debugFunc 1 9
<<<<<<< HEAD
	
	#Write-Host @args
	
	$1, $2, $3, $4, $5, $6, $7, $8, $9 = ${args}
	
	if("$1" -match "dk_[a-zA-Z0-9]+"){
		dk_source $1
=======
	$1, $2, $3, $4, $5, $6, $7, $8, $9 = ${args}
	#Write-Host "dk_call(${args})"
	
	
	
	#Write-Host @args
	$comand = $1 -replace ":", "/"
	#Write-Host "comand = $comand"
	
	if("$comand" -match "dk_[a-zA-Z0-9]+"){
		dk_source $comand
>>>>>>> Development
	}

	& $1 $2 $3 $4 $5 $6 $7 $8 $9
	#Start-Process -WorkingDirectory $env:DKPOWERSHELL_FUNCTIONS_DIR -ArgumentList @args

} 


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_info "test message using dk_call"
}
