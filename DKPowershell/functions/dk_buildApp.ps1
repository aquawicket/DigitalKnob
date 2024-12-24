if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##################################################################################
# dk_buildApp()
#
#
function Global:dk_buildApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Building $APP - $triple - $TYPE - $DKLEVEL ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	if($TYPE -eq "Debug" -or $TYPE -eq "All"){
		if(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$triple/Debug/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$triple/Debug" "--config Debug" "--verbose"
		}
		elseif(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$triple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$triple" "--config Debug" "--verbose"
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $APP/$triple/Debug or $APP/$triple"}
	}
	if($TYPE -eq "Release" -or $TYPE -eq "All"){
		if(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$triple/Release/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$triple/Release" --config Release --verbose
		}
		elseif(dk_call dk_pathExists "$DKAPPS_DIR/$APP/$triple/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$triple" --config Release --verbose
		}
		else{dk_call dk_error "Could not find CMakeCache.txt in $APP/$triple/Release or $APP/$triple"}
	}
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building $APP - $triple - $TYPE - $DKLEVEL ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
