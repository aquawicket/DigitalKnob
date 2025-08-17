if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_call_ps1){ $dk_call_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_call(command, args)
#
#
function Global:dk_call(){
	#dk_debugFunc 1 9;
	
	${func} = $args[0];
	#${AllButFirstArgs} = ${args} | Select-Object -Skip 1;
	
	#${func} = ${func} -replace "::", "/"
	#if("$comand" -match "dk_[a-zA-Z0-9]+"){}
	
	if(!(Get-Command ${func} -errorAction SilentlyContinue)) {
		dk_source ${func};
	}
	
	if(Test-Path ${func}){
		if("${func}" -Match ".ps1"){
			${func} = dk_call dk_basename ${func};
			${func} = dk_call dk_removeExtension ${func}
		}
	}
	
	if(!${func}){ return; }
	if($args[9]){
		& $func $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7] $args[8] $args[9];
	}
	elseif($args[8]){
		& $func $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7] $args[8];
	}
	elseif($args[7]){
		& $func $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7];
	}
	elseif($args[6]){
		& $func $args[1] $args[2] $args[3] $args[4] $args[5] $args[6];
	}
	elseif($args[5]){
		& $func $args[1] $args[2] $args[3] $args[4] $args[5];
	}
	elseif($args[4]){
		& $func $args[1] $args[2] $args[3] $args[4];
	}
	elseif($args[3]){
		& $func $args[1] $args[2] $args[3];
	}
	elseif($args[2]){
		& $func $args[1] $args[2];
	}
	elseif($args[1]){
		& $func $args[1];
	} 
	else {
		& $func;
	}
	#Start-Process ${func} -WorkingDirectory $env:DKPOWERSHELL_FUNCTIONS_DIR -ArgumentList ${AllButFirstArgs};
} 


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_info "test message using dk_call";
}
