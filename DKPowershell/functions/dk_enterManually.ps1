if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_enterManually){ $dk_enterManually = 1 } else{ return }

##################################################################################
# dk_enterManually()
#
#
function Global:dk_enterManually() {
	dk_debugFunc 0

	dk_call dk_info "Please type the name of the library, tool or app to build. Then press enter."
	
	$input = Read-Host
	$global:APP = "_${input}_"
	
	#Search digitalknob for the matching entry containing a DKMAKE.cmake file  
	if(dk_call dk_pathExists "$DKIMPORTS_DIR/$input/DKMAKE.cmake"){
		$global:TARGET_PATH = "$DKIMPORTS_DIR/$input"
	}
	if(dk_call dk_pathExists "$DKPLUGINS_DIR/$input/DKMAKE.cmake"){
		$global:TARGET_PATH = "$DKPLUGINS_DIR/$input"
	}
	if(dk_call dk_pathExists "$DKAPPS_DIR/$input/DKMAKE.cmake"){
		$global:TARGET_PATH = "$DKAPPS_DIR/$input"
		return ${true}
	}
	dk_call dk_printVar TARGET_PATH
	
	if(!(dk_call dk_pathExists "$DKAPPS_DIR/$APP")){
		dk_call dk_makeDirectory "$DKAPPS_DIR/$APP"
	}
	
	# create DKApps/<APP>/DKMAKE.cmake 
	echo "dk_call dk_depend($input)" > "$DKAPPS_DIR/$APP/DKMAKE.cmake"
	
	# create DKApps/<APP>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "$DKAPPS_DIR/$APP/main.cpp"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_enterManually
}
