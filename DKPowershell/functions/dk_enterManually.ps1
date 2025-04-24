<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_enterManually){ $dk_enterManually = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_enterManually){ $dk_enterManually = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_enterManually()
#
#
function Global:dk_enterManually() {
	dk_debugFunc 0

	dk_call dk_info "Please type the name of the library, tool or app to build. Then press enter."
	
	$input = Read-Host
<<<<<<< HEAD
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
=======
	$global:target_app = "_${input}_"
	
	#Search digitalknob for the matching entry containing a DKINSTALL.cmake file  
	if(dk_call dk_pathExists "$DKIMPORTS_DIR/$input/DKINSTALL.cmake"){
		$global:TARGET_PATH = "$DKIMPORTS_DIR/$input"
	}
	if(dk_call dk_pathExists "$DKCPP_PLUGINS_DIR/$input/DKINSTALL.cmake"){
		$global:TARGET_PATH = "$DKCPP_PLUGINS_DIR/$input"
	}
	if(dk_call dk_pathExists "$DKCPP_APPS_DIR/$input/DKINSTALL.cmake"){
		$global:TARGET_PATH = "$DKCPP_APPS_DIR/$input"
>>>>>>> Development
		return ${true}
	}
	dk_call dk_printVar TARGET_PATH
	
<<<<<<< HEAD
	if(!(dk_call dk_pathExists "$DKAPPS_DIR/$APP")){
		dk_call dk_makeDirectory "$DKAPPS_DIR/$APP"
	}
	
	# create DKApps/<APP>/DKMAKE.cmake 
	echo "dk_call dk_depend($input)" > "$DKAPPS_DIR/$APP/DKMAKE.cmake"
	
	# create DKApps/<APP>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "$DKAPPS_DIR/$APP/main.cpp"
=======
	if(!(dk_call dk_pathExists "$DKCPP_APPS_DIR/$target_app")){
		dk_call dk_mkdir "$DKCPP_APPS_DIR/$target_app"
	}
	
	# create DKCpp/apps/<target_app>/DKINSTALL.cmake 
	echo "dk_call dk_depend($input)" > "$DKCPP_APPS_DIR/$target_app/DKINSTALL.cmake"
	
	# create DKCpp/apps/<target_app>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "$DKCPP_APPS_DIR/$target_app/main.cpp"
>>>>>>> Development
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_enterManually
}
