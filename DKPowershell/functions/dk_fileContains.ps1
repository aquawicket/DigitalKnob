if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '${PSScriptRoot}/DK.ps1' }
if(!$dk_fileContains_ps1){ $dk_fileContains_ps1 = 1; } else{ return; } #include guard


##################################################################################
# dk_fileContains(file, string)
#
#
function Global:dk_fileContains() {
	dk_debugFunc 2 3;


	$dk_fileContains = Select-String -Path $args[0] -Pattern $args[1];
	if($dk_fileContains){ $dk_fileContains = $true; }
	else{ $dk_fileContains = $false; }

	###### output ######
	${global:dk_fileContains} = "${dk_fileContains}";
	#if($($args[2])) {
	if($args[2]){
		dk_call dk_set $args[2] "${dk_fileContains}";
	} else {
		return "${dk_fileContains}";
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_fileWrite "fileContains_TEST.txt" "find the needle in the haystack";
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_fileContains "fileContains_TEST.txt" "needle";
	dk_call dk_echo "dk_fileContains = ${dk_fileContains}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_fileContains "fileContains_TEST.txt" "nope" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_fileContains = ${dk_fileContains}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_call dk_fileContains "fileContains_TEST.txt" "haystack" resultC.myValue;
	dk_call dk_echo "resultC.myValue = ${resultC.myValue}";
	dk_call dk_echo "dk_fileContains = ${dk_fileContains}";
	
	### Result as return value
	dk_call dk_echo;
	$resultD = dk_call dk_fileContains "fileContains_TEST.txt" "nope";
	dk_call dk_echo "resultD = ${resultD}";
	dk_call dk_echo "dk_fileContains = ${dk_fileContains}";
}
