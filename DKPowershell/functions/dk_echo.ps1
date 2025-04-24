<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_echo){ $dk_echo = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_echo){ $dk_echo = 1 } else{ return } #include guard
>>>>>>> Development

################################################################################
# dk_echo(message)
#
#	    Print a message to the console
#
#     @msg	- The message to print
#
function Global:dk_echo($message) {
	dk_debugFunc 0 1
	if($(__ARGC__) -eq 0){ Write-Host ""; return }
	
	# https://stackoverflow.com/a/818118
	# $allArgs = $PsBoundParameters.Values + ${args} 

<<<<<<< HEAD
	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	Write-Host "${echo_fileline}   $message"
	
	if(Test-Path variable:echo_fileline){ dk_call dk_unset echo_fileline }
=======
#	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
#	Write-Host "${echo_fileline}   ${message}"
	Write-Host "${message}"	
#	if(Test-Path variable:echo_fileline){ dk_call dk_unset echo_fileline }
>>>>>>> Development
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	echo "This is a normal echo commmand"
	dk_call dk_echo
<<<<<<< HEAD
	dk_call dk_echo ""
=======
>>>>>>> Development
	dk_call dk_echo "This is a dk_echo line"
	dk_call dk_echo "${red}This is ${white}dk_echo ${blue}with color ${clr}"
}
