if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_pickUpdate_ps1){ $dk_pickUpdate_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_pickUpdate()
#
#
function Global:dk_pickUpdate() {
	dk_debugFunc 0;

	dk_call dk_echo "\n";
	dk_call dk_gitCheckRemote;
	dk_call dk_echo "\n";

	### Load DKBuilder.cache ###
	dk_call dk_validate env:DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
	if(Test-Path "${DKCACHE_DIR}/DKBuilder.cache") {
		dk_call dk_fileVariables "${DKCACHE_DIR}/DKBuilder.cache";
	}
	
	if($behind -lt 1){
		if(${Target_App_Cache} -AND ${Target_Os_Cache} -AND ${Target_Arch_Cache} -AND ${Target_Env_Cache} -AND ${Target_Type_Cache}){
			dk_call dk_echo " 0) Repeat DKBuilder.cache [${Target_App_Cache} - ${Target_Os_Cache} - ${Target_Arch_Cache} - ${Target_Env_Cache} - ${Target_Type_Cache}]";
		}
		dk_call dk_echo " 1) Git Update"   ;
		dk_call dk_echo " 2) Git Commit";
		dk_call dk_echo " 3) Download DigitalKnob";
		dk_call dk_echo " 4) Push assets";
		dk_call dk_echo " 5) Pull assets";
		dk_call dk_echo " 6) Reset All";
		dk_call dk_echo " 7) Remove All";
		dk_call dk_echo " 8) Clear Screen";
		dk_call dk_echo " 9) Clear cmake cache AND .tmp files";
		dk_call dk_echo "10) Reload";
		dk_call dk_echo "11) Exit";
		dk_call dk_echo "\n";
		dk_call dk_echo " Press Enter To Skip";
	} else {
		dk_call dk_warning "Your local repository is behind, please git update";
		dk_call dk_echo "\n";
		dk_call dk_echo "${red}";
		if(${Target_App_Cache} -AND ${Target_Os_Cache} -AND ${Target_Arch_Cache} -AND ${Target_Env_Cache} -AND ${Target_Type_Cache}){
			dk_call dk_echo " 0) Repeat DKBuilder.cache [${Target_App_Cache} - ${Target_Os_Cache} - ${Target_Arch_Cache} - ${Target_Env_Cache} - ${Target_Type_Cache}]";
		}
		dk_call dk_echo "${green}";
		dk_call dk_echo " 1) Git Update";
		dk_call dk_echo "${red}"  ;
		dk_call dk_echo " 2) Git Commit";
		dk_call dk_echo " 3) Download DigitalKnob";
		dk_call dk_echo " 4) Push assets";
		dk_call dk_echo " 5) Pull assets";
		dk_call dk_echo " 6) Reset All";
		dk_call dk_echo " 7) Remove All";
		dk_call dk_echo " 8) Clear Screen";
		dk_call dk_echo " 9) Clear cmake cache AND .tmp files";
		dk_call dk_echo "10) Reload";
		dk_call dk_echo "11) Exit";
		dk_call dk_echo "\n";
		dk_call dk_echo "Press Enter To Skip";
		dk_call dk_echo "${clr}";
	}
	
	$input = Read-Host;
	if($input -eq "0"){
		dk_call dk_echo "repeating last selection";
		
		dk_call dk_Target_App ${Target_App_Cache};
		dk_call dk_Target_Os ${Target_Os_Cache};
		dk_call dk_Target_Arch ${Target_Arch_Cache};
		dk_call dk_Target_Env ${Target_Env_Cache};
		dk_call dk_Target_Type ${Target_Type_Cache};
		
		${global:UPDATE} = 1;
	}
	elseif($input -eq  "1"){ dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development; }
	elseif($input -eq  "2"){ dk_call dk_gitCommit; }
	elseif($input -eq  "3"){ dk_call dk_downloadDK; }
	elseif($input -eq  "4"){ dk_call dk_pushAssets; }
	elseif($input -eq  "5"){ dk_call dk_pullAssets; }
	elseif($input -eq  "6"){ dk_call dk_resetAll; }
	elseif($input -eq  "7"){ dk_call dk_removeAll; }
	elseif($input -eq  "8"){ dk_call dk_clearScreen; }
	elseif($input -eq  "9"){ dk_call dk_clearCmakeCache; dk_call dk_deleteTempFiles; }
	elseif($input -eq "10"){ dk_call dk_reload; }
	elseif($input -eq "11"){ dk_call dk_exit 0; }	
	elseif($input -eq ""){ ${global:UPDATE} = 1; }
	else{ dk_call dk_warning "invalid selection"; }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_pickUpdate;
}
