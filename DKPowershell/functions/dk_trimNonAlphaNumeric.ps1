if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_basename_ps1){ $dk_basename_ps1 = 1; } else{ return; } #include guard


##################################################################################
# dk_trimNonAlphaNumeric(<input> <output>)
#
#
function Global:dk_trimNonAlphaNumeric() {
	dk_debugFunc 1 2;
	
	###### input ######
	${_input_}=$args[0];
	
	${dk_trimNonAlphaNumeric} = ${_input_}  -replace '(^[^a-zA-Z0-9]*)|([^a-zA-Z0-9]*$)', '';

	###### return ######
	${global:dk_trimNonAlphaNumeric} = ${dk_trimNonAlphaNumeric};
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_trimNonAlphaNumeric};
	} else {
		return ${dk_trimNonAlphaNumeric};
	}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0;
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	${myVar}="++0.2.134Beta--";
	dk_call dk_trimNonAlphaNumeric "${myVar}" result;
	dk_call dk_echo "dk_trimNonAlphaNumeric = ${dk_trimNonAlphaNumeric}";
	dk_call dk_echo "result = ${result}";
}
