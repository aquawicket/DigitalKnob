if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}\DK.ps1; }
if(!$dk_test_ps1){ $dk_test_ps1 = 1; } else{ return; } #include guard


##################################################################################
# dk_includes(string, substring)
#
#
function GLOBAL:dk_includes() {
	dk_call dk_debugFunc 2;

	
	# https://stackoverflow.com/a/8811800/688352
	# [[ ${1} == *"${2}"* ]]    							# NON-POSIX    # [[ ${string} == *"${substring}"* ]]
	# case "${1}" in *${2}*) return 0;; esac; return 1      # POSIX        # case "${string}" in *${substring}*) return 0;; esac; return 1
	#[ "${1#*"${2}"}" != "${1}" ]						    # POSIX        # [ "${string#*"$substring"}" != "$string" ]
	if("$($args[0])" -Match "$($args[1])"){
		return $true;
	}
	return $false;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function GLOBAL:DKTEST() {
	dk_call dk_debugFunc 2;

	if(dk_call dk_includes "1one1" "one") {
		dk_call dk_echo "1one1 contains one";
	} else {
		dk_call dk_echo "1one1 does not contain one";
	}
	
	if(dk_call dk_includes "2two2" "three") {
		dk_call dk_echo "2two2 contains three";
	} else {
		dk_call dk_echo "2two2 does not contain three";
	}

	#dk_call dk_includes "1one1" "one" && dk_call dk_echo "1one1 contains one" || dk_call dk_echo "1one1 does not contain one";
	#dk_call dk_includes "2two2" "owt" && dk_call dk_echo "2two2 contains owt" || dk_call dk_echo "2two2 does not contain owt";
}
