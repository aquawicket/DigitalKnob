if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_build){ $dk_build = 1 } else{ return }

##################################################################################
# dk_build()
#
#
function Global:dk_build() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_echo "##################################################################"
	dk_echo
	
	if($TYPE -eq "Debug" -or $TYPE -eq "All"){
		if(dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/Debug/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$TARGET_OS/Debug" "--config Debug" "--verbose"
		}
		elseif(dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$TARGET_OS" "--config Debug" "--verbose"
		}
		else{dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"}
	}
	if($TYPE -eq "Release" -or $TYPE -eq "All"){
		if(dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/Release/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS/Release" --config Release --verbose
		}
		elseif(dk_pathExists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"){
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS" --config Release --verbose
		}
		else{dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"}
	}
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_echo "##################################################################"
	dk_echo
}






function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_build
}