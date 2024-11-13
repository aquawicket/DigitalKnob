if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pickUpdate){ $dk_pickUpdate = 1 } else{ return }

##################################################################################
# dk_pickUpdate()
#
#
function Global:dk_pickUpdate() {
	dk_debugFunc 0

	dk_call dk_readCache _APP_ _triple_ _TYPE_
	dk_printVar $_APP_
	dk_printVar $_triple_
	dk_printVar $_TYPE_
	
	dk_call dk_echo
	dk_call dk_gitCheckRemote
	dk_call dk_echo
	
	if($behind -lt 1){
		if(${_APP_} -and ${_triple_} -and ${_TYPE_}){
			dk_call dk_echo " 0) Repeat cache [$_APP_ - $_triple_ - $_TYPE_]"
		}
		dk_call dk_echo " 1) Git Update"   
		dk_call dk_echo " 2) Git Commit"
		dk_call dk_echo " 3) Download DigitalKnob"
		dk_call dk_echo " 4) Push assets"
		dk_call dk_echo " 5) Pull assets"
		dk_call dk_echo " 6) Reset All"
		dk_call dk_echo " 7) Remove All"
		dk_call dk_echo " 8) Clear Screen"
		dk_call dk_echo " 9) Clear cmake cache and .tmp files"
		dk_call dk_echo "10) Reload"
		dk_call dk_echo "11) Exit"
		dk_call dk_echo
		dk_call dk_echo " Press Enter To Skip"
	} else {
		dk_call dk_warning "Your local repository is behind, please git update"
		dk_call dk_echo
		dk_call dk_echo "${red}" 
		if(${_APP_} -and ${_triple_} -and ${_TYPE_}){
			dk_call dk_echo " 0) Repeat cache [${_APP_} - ${_triple_} - ${_TYPE_}]"
		}
		dk_call dk_echo "${green}"
		dk_call dk_echo " 1) Git Update"
		dk_call dk_echo "${red}"  
		dk_call dk_echo " 2) Git Commit"
		dk_call dk_echo " 3) Download DigitalKnob"
		dk_call dk_echo " 4) Push assets"
		dk_call dk_echo " 5) Pull assets"
		dk_call dk_echo " 6) Reset All"
		dk_call dk_echo " 7) Remove All"
		dk_call dk_echo " 8) Clear Screen"
		dk_call dk_echo " 9) Clear cmake cache and .tmp files"
		dk_call dk_echo "10) Reload"
		dk_call dk_echo "11) Exit"
		dk_call dk_echo
		dk_call dk_echo "Press Enter To Skip"
		dk_call dk_echo "${clr}"
	}
	
	$input = Read-Host
	if($input -eq "0"){
		dk_call dk_echo "repeating last selection"
		$global:APP = ${_APP_}
		$global:triple = ${_triple_}
		$global:TYPE = ${_TYPE_}
		$global:UPDATE = 1
	}
	elseif($input -eq  "1"){ dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development }
	elseif($input -eq  "2"){ dk_call dk_gitCommit }
	elseif($input -eq  "3"){ dk_call dk_downloadDK }
	elseif($input -eq  "4"){ dk_call dk_pushAssets }
	elseif($input -eq  "5"){ dk_call dk_pullAssets }
	elseif($input -eq  "6"){ dk_call dk_resetAll }
	elseif($input -eq  "7"){ dk_call dk_removeAll }
	elseif($input -eq  "8"){ dk_call dk_clearScreen }
	elseif($input -eq  "9"){ dk_call dk_clearCmakeCache; dk_call dk_deleteTempFiles }
	elseif($input -eq "10"){ dk_call dk_reload }
	elseif($input -eq "11"){ dk_call dk_exit 0 }	
	elseif($input -eq ""){ $global:UPDATE = 1 }
	else{ dk_call dk_warning "invalid selection"}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickUpdate
}
