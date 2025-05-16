if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_enterManually){ $dk_enterManually = 1 } else{ return } #include guard

##################################################################################
# dk_enterManually()
#
#
function Global:dk_enterManually() {
	dk_debugFunc 0

	dk_call dk_info "Please type the name of the library, tool or app to build. Then press enter."
	
	$input = Read-Host
	$global:Target_App = "_${input}_"
	
	#Search digitalknob for the matching entry containing a DKINSTALL.cmake file  
	if(dk_call dk_pathExists "$DKIMPORTS_DIR/$input/DKINSTALL.cmake"){
		$global:TARGET_PATH = "$DKIMPORTS_DIR/$input"
	}
	if(dk_call dk_pathExists "$DKCPP_PLUGINS_DIR/$input/DKINSTALL.cmake"){
		$global:TARGET_PATH = "$DKCPP_PLUGINS_DIR/$input"
	}
	if(dk_call dk_pathExists "$DKCPP_APPS_DIR/$input/DKINSTALL.cmake"){
		$global:TARGET_PATH = "$DKCPP_APPS_DIR/$input"
		return ${true}
	}
	dk_call dk_printVar TARGET_PATH
	
	if(!(dk_call dk_pathExists "$DKCPP_APPS_DIR/$Target_App")){
		dk_call dk_mkdir "$DKCPP_APPS_DIR/$Target_App"
	}
	
	# create DKCpp/apps/<Target_App>/DKINSTALL.cmake 
	echo "dk_call dk_depend($input)" > "$DKCPP_APPS_DIR/$Target_App/DKINSTALL.cmake"
	
	# create DKCpp/apps/<Target_App>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "$DKCPP_APPS_DIR/$Target_App/main.cpp"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_enterManually
}
