if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_validate_ps1){ $dk_validate_ps1 = 1; } else{ return; } #include guard

###############################################################################
# dk_validate(variable, code)
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid.
#
function Global:dk_validate() {
	dk_debugFunc 2;
	
	${variable} = $($args[0]);
	${code} = $($args[1]);
	
	### Check if the variable is already set ###
	if(dk_call dk_contains "${variable}" "env:"){
		${env_variable} = ${variable} -replace "env:", "";
		if(${env_variable} -and (Test-Path env:${env_variable})) {
			${value} = [Environment]::GetEnvironmentVariable(${env_variable}, 'Process');
			Write-Host "env:${env_variable} is already SET to '${value}'";
			return;
		}
	}
	elseif(${variable} -and (Test-Path variable:${variable})) {
		Write-Host "${variable} is already SET to '$(gv -ValueOnly $variable)'";
		return;
	}


	### Run the code to set the variable ###
	Write-Host "Setting ${variable}. . .";
	if(${code} -and (Test-Path ${code} -PathType Leaf)){ dk_call dk_load ${code}; }
	#eval "${code}"
	if(${code}){ Invoke-Expression ${code} }
	
	
	### Double check that the variable was set ###
	if(dk_call dk_contains "${variable}" "env:"){
		if( !(Test-Path env:${env_variable}) ) {
			dk_call dk_error "dk_validate was unable to set the variable '${variable}' with the code provided"
		}
	}
	elseif( !(Test-Path variable:${variable}) ){ 
		dk_call dk_error "dk_validate was unable to set the variable '${variable}' with the code provided"
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	# myVarA - variable already set
	Write-Host "";
	${myVarA} = "preset value of myVarA";
	dk_call dk_validate myVarA "dk_call dk_error 'ERROR'";
	dk_call dk_echo "myVarA = '${myVarA}'";
		
	# myVarB - variable set by function	
	Write-Host "";
	dk_call dk_validate myVarB "fill_myVarB";
	dk_call dk_echo "myVarB = '${myVarB}'";
	
	# myVarC - variable set by dk_validate
	Write-Host "";
	dk_call dk_validate myVarC "Set-Variable -Scope Global -Name 'myVarC' -Value 'value of myVarC set by dk_validate()'";
	dk_call dk_echo "myVarC = '${myVarC}'";
	
	# env:myVarD - environment variable already set
	Write-Host "";
	${env:myVarD} = "preset value of env:myVarD";
	dk_call dk_validate env:myVarD "dk_call dk_error 'ERROR'";
	dk_call dk_echo "env:myVarD = '${env:myVarD}'";
	
	# env:myVarE - environment variable set by function
	Write-Host "";
	dk_call dk_validate env:myVarE "fill_myVarE";
	dk_call dk_echo "env:myVarE = '${env:myVarE}'";
	
	# env:myVarF - variable set by dk_validate
	Write-Host "";
	#dk_call dk_validate env:myVarF "Set-Variable -Scope Global -Name 'env:myVarF' -Value 'value of env:myVarF set by dk_validate()'";
	dk_call dk_validate env:myVarF "Set-Item -Path env:myVarF -Value 'value of env:myVarF set by dk_validate()'";
	dk_call dk_echo "env:myVarF = '${env:myVarF}'";
	
	# myVarG - Test dk_validate 'variable not set' Error
	Write-Host "";
	dk_call dk_validate myVarG "dk_call dk_echo 'Testing dk_validate() variable not set Error. . .'";
	dk_call dk_echo "myVarF = '${myVarF}'";
	

}

function Global:fill_myVarB() {
	${global:myVarB} = "value of myVarB set by Fill_myVarB()";
}

function Global:fill_myVarE() {
	${env:myVarE} = "value of env:myVarE set by Fill_myVarE()";
}