if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_echo){ $dk_echo = 1 } else{ return }

################################################################################
# dk_echo(message)
#
#	    Print a message to the console
#
#     @msg	- The message to print
#
function Global:dk_echo($allArgs) {
	dk_debugFunc
	# https://stackoverflow.com/a/818118
	$allArgs = $PsBoundParameters.Values + $args 
	
	
	#if($allArgs -eq ""){ echo "\n"; return }

	#echo $allArgs
	Write-Host $allArgs
}





function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	
	echo "This is a normal echo commmand"
	dk_echo "This is a dk_echo line"
	dk_echo "${red}This is ${white}dk_echo ${blue}with color ${clr}"
}

