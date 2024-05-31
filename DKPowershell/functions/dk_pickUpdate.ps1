if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_pickUpdate){ $dk_pickUpdate = 1 } else{ return }

dk_load dk_readCache
dk_load dk_checkGitRemote
dk_load dk_gitUpdate
dk_load dk_gitCommit
dk_load dk_pushAssets
dk_load dk_pullAssets
dk_load dk_resetAll
dk_load dk_removeAll
dk_load dk_clearScreen
dk_load dk_clearCmakeCache
dk_load dk_deleteTempFiles
dk_load dk_reload
dk_load dk_exit
##################################################################################
# dk_pickUpdate()
#
#
function Global:dk_pickUpdate() {
	dk_debugFunc
	if ( $(__ARGC__) -ne 0 ){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	dk_readCache
	
	dk_echo
	dk_checkGitRemote
	dk_echo
	
	#dk_printVar _APP_
	#dk_printVar _TARGET_OS_ 
	#dk_printVar _TYPE_
	
	if($behind -lt 1){
		if(${_APP_} && ${_TARGET_OS_} && ${_TYPE_}){
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		}
		dk_echo " 1) Git Update"   
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo " Press Enter To Skip"
	} else {
		dk_warning "Your local repository is behind, please git update"
		dk_echo
		dk_echo "${red}" 
		if(${_APP_} && ${_TARGET_OS_} && ${_TYPE_}){
			dk_echo " 0) Repeat cache [${_APP_} - ${_TARGET_OS_} - ${_TYPE_}]"
		}
		dk_echo "${green}"
		dk_echo " 1) Git Update"
		dk_echo "${red}"  
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
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
	elseif($input -eq  "3"){ dk_pushAssets }
	elseif($input -eq  "4"){ dk_pullAssets }
	elseif($input -eq  "5"){ dk_resetAll }
	elseif($input -eq  "6"){ dk_removeAll }
	elseif($input -eq  "7"){ dk_clearScreen }
	elseif($input -eq  "8"){ dk_clearCmakeCache; dk_deleteTempFiles }
	elseif($input -eq  "9"){ dk_reload }
	elseif($input -eq "10"){ dk_exit 0 }	
	elseif($input -eq   ""){ $global:UPDATE = 1 }
	else{ dk_warning "invalid selection"}
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_pickUpdate
}