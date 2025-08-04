if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_convertToCIdentifier_ps1){ $dk_convertToCIdentifier_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_convertToCIdentifier(str, rtn_var)
#
#
function Global:dk_convertToCIdentifier() {
	dk_debugFunc 1 2;

	${global:dk_convertToCIdentifier} = $args[0] -replace '\W', '_';
	
	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_convertToCIdentifier} -Scope Global;
	} else {
		return ${dk_convertToCIdentifier};
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	$input = "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :"
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_convertToCIdentifier $input;
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_basename $input resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
	
	### Result as return value
	dk_call dk_echo
	$resultC = dk_call dk_convertToCIdentifier $input;
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
}
