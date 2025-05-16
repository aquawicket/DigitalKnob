if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_buildApp){ $dk_buildApp = 1 } else{ return } #include guard

##################################################################################
# dk_buildApp()
#
#
function Global:dk_buildApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Building $Target_App - $Target_Tuple - $Target_Type - $Target_Level ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	if($Target_Type -eq "Debug" -or $Target_Type -eq "All"){
		if(dk_call dk_pathExists "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple/Debug/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple/Debug" "--config Debug" "--verbose"
		}
		elseif(dk_call dk_pathExists "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple" "--config Debug" "--verbose"
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $Target_App/$Target_Tuple/Debug or $Target_App/$Target_Tuple"}
	}
	if($Target_Type -eq "Release" -or $Target_Type -eq "All"){
		if(dk_call dk_pathExists "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple/Release/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple/Release" --config Release --verbose
		}
		elseif(dk_call dk_pathExists "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKCPP_APPS_DIR/$Target_App/$Target_Tuple" --config Release --verbose
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $Target_App/$Target_Tuple/Release or $Target_App/$Target_Tuple"}
	}
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building $Target_App - $Target_Tuple - $Target_Type - $Target_Level ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
