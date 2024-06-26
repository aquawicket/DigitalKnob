if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_echo){ $dk_echo = 1 } else{ return }

################################################################################
# dk_echo(message)
#
#	    Print a message to the console
#
#     @msg	- The message to print
#
function Global:dk_echo($message) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	# https://stackoverflow.com/a/818118
	# $allArgs = $PsBoundParameters.Values + $args 

	Write-Host $message
}





function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	echo "This is a normal echo commmand"
	dk_echo
	dk_echo ""
	dk_echo "This is a dk_echo line"
	dk_echo "${red}This is ${white}dk_echo ${blue}with color ${clr}"
}

