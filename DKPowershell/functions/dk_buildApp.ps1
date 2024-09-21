if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_buildApp){ $dk_buildApp = 1 } else{ return }

##################################################################################
# dk_buildApp()
#
#
function Global:dk_buildApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	if($TYPE -eq "Debug" -or $TYPE -eq "All"){
		if(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/Debug/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$TARGET_OS/Debug" "--config Debug" "--verbose"
		}
		elseif(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$TARGET_OS" "--config Debug" "--verbose"
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"}
	}
	if($TYPE -eq "Release" -or $TYPE -eq "All"){
		if(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/Release/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS/Release" --config Release --verbose
		}
		elseif(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS" --config Release --verbose
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"}
	}
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
