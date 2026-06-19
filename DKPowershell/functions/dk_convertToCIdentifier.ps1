if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_convertToCIdentifier_ps1){ $dk_convertToCIdentifier_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_convertToCIdentifier(str, rtn_var)
#
#
function Global:dk_convertToCIdentifier() {
	dk_debugFunc 1 2;

	${_str_} = $args[0];
	#if(Test-Path variable:${_str_}){ ${_str_} = Get-Variable -Name (${_str_}) -ValueOnly; }
	
	${global:dk_convertToCIdentifier} = ${_str_} -replace '\W', '_';
	
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_convertToCIdentifier};
	} else {
		return ${dk_convertToCIdentifier};
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	#$input = "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :"
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_convertToCIdentifier "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
	
	### Result as return value
	dk_call dk_echo;
	$resultB=dk_call dk_convertToCIdentifier "B:/directoryB/filenameB.extB";
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_convertToCIdentifier "C:/directoryC/filenameC.extC" resultC;
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_convertToCIdentifier "D:/directoryD/filenameD.extD" resultD.data;
	dk_call dk_echo "resultD.data = $($resultD.data)";
	dk_call dk_echo "dk_convertToCIdentifier = ${dk_convertToCIdentifier}";
}
