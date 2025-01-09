if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pause){ $dk_pause = 1 } else{ return } #include guard

##################################################################################
# dk_pause(pause_msg)
#
#    Pause execution and wait for <enter> keypress to continue
#
function GLOBAL:dk_pause() {
	dk_debugFunc 0 1

	if(!($args)){
		$pause_msg = "Press and any to continue...";
	} else {
		$pause_msg = "$args";
	}
	dk_call dk_echo "${pause_msg}";
	Read-Host;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pause
	dk_call dk_pause "Pause with a custom message"
	dk_call dk_pause "${red}Pause ${green}with ${blue}colorful ${yellow}message${clr}"
	dk_call dk_echo  "pause with no message"
	dk_call dk_pause " "
}
