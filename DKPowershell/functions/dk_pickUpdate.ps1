if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pickUpdate){ $dk_pickUpdate = 1 } else{ return }

##################################################################################
# dk_pickUpdate()
#
#
function Global:dk_pickUpdate() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	dk_readCache
	
	dk_echo
	dk_gitCheckRemote
	dk_echo
	
	if($behind -lt 1){
		if(${_APP_} -and ${_TARGET_OS_} -and ${_TYPE_}){
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		}
		dk_echo " 1) Git Update"   
		dk_echo " 2) Git Commit"
		dk_echo " 3) Download DigitalKnob"
		dk_echo " 4) Push assets"
		dk_echo " 5) Pull assets"
		dk_echo " 6) Reset All"
		dk_echo " 7) Remove All"
		dk_echo " 8) Clear Screen"
		dk_echo " 9) Clear cmake cache and .tmp files"
		dk_echo "10) Reload"
		dk_echo "11) Exit"
		dk_echo
		dk_echo " Press Enter To Skip"
	} else {
		dk_warning "Your local repository is behind, please git update"
		dk_echo
		dk_echo "${red}" 
		if(${_APP_} -and ${_TARGET_OS_} -and ${_TYPE_}){
			dk_echo " 0) Repeat cache [${_APP_} - ${_TARGET_OS_} - ${_TYPE_}]"
		}
		dk_echo "${green}"
		dk_echo " 1) Git Update"
		dk_echo "${red}"  
		dk_echo " 2) Git Commit"
		dk_echo " 3) Download DigitalKnob"
		dk_echo " 4) Push assets"
		dk_echo " 5) Pull assets"
		dk_echo " 6) Reset All"
		dk_echo " 7) Remove All"
		dk_echo " 8) Clear Screen"
		dk_echo " 9) Clear cmake cache and .tmp files"
		dk_echo "10) Reload"
		dk_echo "11) Exit"
		dk_echo
		dk_echo "Press Enter To Skip"
		dk_echo "${clr}"
	}
	
	$input = Read-Host
	if($input -eq "0"){
		dk_echo "repeating last selection"
		$global:APP = ${_APP_}
		$global:TARGET_OS = ${_TARGET_OS_}
		$global:TYPE = ${_TYPE_}
		$global:UPDATE = 1
	}
	elseif($input -eq  "1"){ dk_gitUpdate }
	elseif($input -eq  "2"){ dk_gitCommit }
	elseif($input -eq  "3"){ dk_downloadDK }
	elseif($input -eq  "4"){ dk_pushAssets }
	elseif($input -eq  "5"){ dk_pullAssets }
	elseif($input -eq  "6"){ dk_resetAll }
	elseif($input -eq  "7"){ dk_removeAll }
	elseif($input -eq  "8"){ dk_clearScreen }
	elseif($input -eq  "9"){ dk_clearCmakeCache; dk_deleteTempFiles }
	elseif($input -eq "10"){ dk_reload }
	elseif($input -eq "11"){ dk_exit 0 }	
	elseif($input -eq ""){ $global:UPDATE = 1 }
	else{ dk_warning "invalid selection"}
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_pickUpdate
}