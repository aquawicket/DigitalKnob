. ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1
if(!$dk_timeout){ $dk_timeout = 1 } else{ return } #include guard

##################################################################################
# dk_timeout(seconds)
#
#	Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
#
function Global:dk_timeout() {
	dk_debugFunc 0 1
	
	$seconds = $($args[0])
	
	if(!$seconds){
		$seconds = 10
	}
	dk_assertVar seconds
	
#	Write-Host "Waiting for ${seconds} seconds, press a key to continue .."
#	$counter = 0
#	while(!$Host.UI.RawUI.KeyAvailable -and ($counter++ -lt $seconds)){
#		[Threading.Thread]::Sleep(1000)
#	}
	Write-Host "Waiting for ${seconds} seconds, press a key to continue .."; $counter = 0; while(!$Host.UI.RawUI.KeyAvailable -and ($counter++ -lt ${seconds})){ [Threading.Thread]::Sleep(1000) }
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_timeout
	
	dk_call dk_timeout 0
	
	dk_call dk_timeout 1
	
	dk_call dk_timeout "5"
	
	# ${timeA} =
	dk_call dk_timeout ${timeA}
	
	${timeB} = 0
	dk_call dk_timeout ${timeB}
	
	${timeC} = 1
	dk_call dk_timeout "${timeC}"
	
	
	# TODO: multi-level pointer variables
	return
	
	${timeD} = 2
	dk_call dk_timeout timeD
	
	${varE} = 3
	${timeE} = ${varE}
	dk_call dk_timeout timeE
	
	${varF} = 4
	${timeF} = ${varF}
	dk_call dk_timeout timeF
}
