<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
>>>>>>> Development
if(!$dk_echo){ $dk_echo = 1 } else{ return }

################################################################################
# dk_echo(message)
#
#	    Print a message to the console
#
#     @msg	- The message to print
#
function Global:dk_echo($message) {
	#dk_debugFunc 0 1
	if($(__ARGC__) -eq 0){ Write-Host ""; return }
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	# https://stackoverflow.com/a/818118
	# $allArgs = $PsBoundParameters.Values + ${args} 

	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	Write-Host "${echo_fileline}   $message"
	
	if(Test-Path variable:echo_fileline){ dk_unset echo_fileline }
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() {
	dk_debugFunc 0
	
	
	echo "This is a normal echo commmand"
	dk_echo
	dk_echo ""
	dk_echo "This is a dk_echo line"
	dk_echo "${red}This is ${white}dk_echo ${blue}with color ${clr}"
}

