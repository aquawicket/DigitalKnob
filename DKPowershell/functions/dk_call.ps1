if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_call_ps1){ $dk_call_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_call(command, args)
#
#
function Global:dk_call(){
	#dk_debugFunc 1 9
	$1, $2, $3, $4, $5, $6, $7, $8, $9 = ${args};
	
	#$comand = $1 -replace ":", "/"
	#if("$comand" -match "dk_[a-zA-Z0-9]+"){
		dk_source $1;
	#}
	
	if(Test-Path $1){
		${func} = dk_call dk_basename $1;
		${func} = dk_call dk_removeExtension ${func}
	} else {
		${func} = $1;
	}
	
	#echo ${func} $2 $3 $4 $5 $6 $7 $8 $9
	& ${func} $2 $3 $4 $5 $6 $7 $8 $9;
	#Start-Process -WorkingDirectory $env:DKPOWERSHELL_FUNCTIONS_DIR -ArgumentList @args
} 


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_info "test message using dk_call"
}
