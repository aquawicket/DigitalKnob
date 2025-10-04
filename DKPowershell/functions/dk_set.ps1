if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_set_ps1){ $dk_set_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_set(variable value)
#
#
function Global:dk_set() {
	dk_debugFunc 2;
	
	${_variable_}=$($args[0]);
	${_value_}=$($args) | Select-Object -Skip 1;
	

	#if(!${_value_}){ ${_value_}=$($args[1]); }
	#${_variable_arry} = ${_variable_}.Split(".");
#	if(${_variable_arry}[1]){
#		if( !($(Get-Variable -Name ${_variable_arry}[0] -ErrorAction SilentlyContinue)) ){
#			${hashtable} = @{};
#			Write-Host "Set-Variable Name ${_variable_arry}[0] Value ${hashtable} -Scope Global";
#			Set-Variable -Name ${_variable_arry}[0] -Value ${hashtable} -Scope Global;
#		}
#		Write-Host "Get-Variable Name ${_variable_arry}[0] ValueOnly)[${_variable_arry}[1]] = ${_value_}";
#		$(Get-Variable -Name ${_variable_arry}[0] -ValueOnly)[${_variable_arry}[1]] = ${_value_};
#	} else {
#		Write-Host "Set-Variable Name ${_variable_arry}[0] Value ${_value_} -Scope Global";
#		Set-Variable -Name ${_variable_arry}[0] -Value ${_value_} -Scope Global;
#	}
	
	### Set every already existing scope instance of the variable
	if(Test-Path variable:${_variable_}){
		$ScopeList = (0..( ( Get-PSCallStack ).count + 2 )) + 'Script';
		foreach ($scope in $ScopeList){
			if($(gv -Scope $scope -Name ${_variable_} -ErrorAction SilentlyContinue)){
				Set-Variable -Scope $scope -Name ${_variable_} -Value ${_value_};
				break;
			}
		}
	}

	### Set global scope variable 
	Set-Variable -Scope Global -Name ${_variable_} -Value ${_value_};
	
	### Set Environment Variable
	Set-Item env:${_variable_} ${_value_};
}















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_set myVar "value of myVar";
	dk_call dk_info "myVar = ${myVar}";
	dk_call dk_info "env:myVar = ${env:myVar}";
	
	#$myArray = @{};
	dk_call dk_set "myArray.data" "value of myArray.data";
	dk_call dk_info "myArray.data = $($myArray.data)";
	dk_call dk_info "env:myArray.data = ${env:myArray.data}";
	dk_call dk_set "myArray.data2" "value of myArray.data2";
	dk_call dk_info "myArray = $myArray";
	$myArray
}
