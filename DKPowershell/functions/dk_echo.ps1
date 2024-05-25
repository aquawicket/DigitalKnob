if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_echo){ $dk_echo = 1 } else{ return }

################################################################################
# dk_echo(<message>)
#
#	    Print a message to the console
#
#     @msg	- The message to print
#
function Global:dk_echo($allArgs) {
	dk_debugFunc
	
	# https://stackoverflow.com/a/818118
	$allArgs = $PsBoundParameters.Values + $args
	#if ($allArgs -eq ""){ echo "\n"; return }
	#echo "allArgs = $allArgs"

	#set "_message_=%*"	
	# if msg starts and ends with quotes, remove the first and last
	#if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
	#echo %*
	echo $allArgs
}





function Global:DKTEST() { ###########################################################################################
	
	echo "This is a normal echo commmand"
	dk_echo
	dk_echo "$red This is a dk_echo line"
	
	#dk_echo "%cyan% This is dk_echo with color %clr%"
}

