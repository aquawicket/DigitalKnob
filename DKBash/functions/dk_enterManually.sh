#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_enterManually()
#
#
dk_enterManually() {
	dk_debugFunc 0
	
	dk_call dk_info "Please type the name of the library, tool or app to build. Then press enter."
	dk_call dk_keyboardInput input
	
	Target_App="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKINSTALL.cmake file  
	if test -f "${DKIMPORTS_DIR}/${input}/DKINSTALL.cmake"; then
		Target_App_Dir=${DKIMPORTS_DIR}/${input}
	fi
	if test -f "${DKCPP_PLUGINS_DIR}/${input}/DKINSTALL.cmake"; then
		Target_App_Dir=${DKCPP_PLUGINS_DIR}/${input}
	fi
	
	dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
	if test -f "${DKCPP_APPS_DIR}/${input}/DKINSTALL.cmake"; then
		Target_App_Dir=${DKCPP_APPS_DIR}/${input}
		return $(true)
	fi
	dk_call dk_printVar Target_App_Dir
	
	if [ ! -d "${DKCPP_APPS_DIR}/${Target_App}" ]; then
		dk_call dk_mkdir "${DKCPP_APPS_DIR}/${Target_App}";
	fi
	
	# create apps/<Target_App>/DKINSTALL.cmake 
	dk_call dk_fileWrite "${DKCPP_APPS_DIR}/${Target_App}/DKINSTALL.cmake" "dk_depend(${input})"
	
	# create apps/<Target_App>/main.cpp
	dk_call dk_fileWrite "${DKCPP_APPS_DIR}/${Target_App}/main.cpp" "int main(int argc, char** argv) { return 0; }"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_enterManually
}
