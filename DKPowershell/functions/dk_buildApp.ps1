if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_buildApp){ $dk_buildApp = 1 } else{ return } #include guard

##################################################################################
# dk_buildApp()
#
#
function Global:dk_buildApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Building $target_app - $target_triple - $target_type - $DKLEVEL ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	if($target_type -eq "Debug" -or $target_type -eq "All"){
		if(dk_call dk_pathExists "$DKAPPS_DIR/$target_app/$target_triple/Debug/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$target_app/$target_triple/Debug" "--config Debug" "--verbose"
		}
		elseif(dk_call dk_pathExists "$DKAPPS_DIR/$target_app/$target_triple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$target_app/$target_triple" "--config Debug" "--verbose"
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $target_app/$target_triple/Debug or $target_app/$target_triple"}
	}
	if($target_type -eq "Release" -or $target_type -eq "All"){
		if(dk_call dk_pathExists "$DKAPPS_DIR/$target_app/$target_triple/Release/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$target_app/$target_triple/Release" --config Release --verbose
		}
		elseif(dk_call dk_pathExists "$DKAPPS_DIR/$target_app/$target_triple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$target_app/$target_triple" --config Release --verbose
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $target_app/$target_triple/Release or $target_app/$target_triple"}
	}
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building $target_app - $target_triple - $target_type - $DKLEVEL ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
