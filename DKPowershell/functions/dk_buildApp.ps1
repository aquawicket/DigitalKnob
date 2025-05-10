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
	dk_call dk_echo "****** Building $target_app - $target_tuple - $target_type - $target_level ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	if($target_type -eq "Debug" -or $target_type -eq "All"){
		if(dk_call dk_pathExists "$DKCPP_APPS_DIR/$target_app/$target_tuple/Debug/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKCPP_APPS_DIR/$target_app/$target_tuple/Debug" "--config Debug" "--verbose"
		}
		elseif(dk_call dk_pathExists "$DKCPP_APPS_DIR/$target_app/$target_tuple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKCPP_APPS_DIR/$target_app/$target_tuple" "--config Debug" "--verbose"
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $target_app/$target_tuple/Debug or $target_app/$target_tuple"}
	}
	if($target_type -eq "Release" -or $target_type -eq "All"){
		if(dk_call dk_pathExists "$DKCPP_APPS_DIR/$target_app/$target_tuple/Release/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKCPP_APPS_DIR/$target_app/$target_tuple/Release" --config Release --verbose
		}
		elseif(dk_call dk_pathExists "$DKCPP_APPS_DIR/$target_app/$target_tuple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKCPP_APPS_DIR/$target_app/$target_tuple" --config Release --verbose
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $target_app/$target_tuple/Release or $target_app/$target_tuple"}
	}
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building $target_app - $target_tuple - $target_type - $target_level ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
