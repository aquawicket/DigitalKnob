if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_call_ps1){ $dk_call_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_call(command, args)
#
#
function Global:dk_call(){
	#dk_debugFunc 1 9
	
	${func} = $($args[0]);
	${AllButFirstArgs} = ${args} | Select-Object -Skip 1;
	
	#${func} = ${func} -replace "::", "/"
	#if("$comand" -match "dk_[a-zA-Z0-9]+"){
		
	#}
	
	if(!(Get-Command ${func} -errorAction SilentlyContinue)) {
		dk_source ${func};
	}
	
	
	if(Test-Path ${func}){
		if("${func}" -Match ".ps1"){
			${func} = dk_call dk_basename ${func};
			${func} = dk_call dk_removeExtension ${func}
		}
	}
	
	#Write-Host "AllButFirstArgs = '${AllButFirstArgs}'"
	if(!${func}){ return; }
	if(${AllButFirstArgs}){
		& ${func} ${AllButFirstArgs};
	} else {
		& ${func}
	}
	#Start-Process ${func} -WorkingDirectory $env:DKPOWERSHELL_FUNCTIONS_DIR -ArgumentList ${AllButFirstArgs};
} 


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_info "test message using dk_call"
}
