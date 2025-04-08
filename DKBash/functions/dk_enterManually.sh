#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_enterManually()
#
#
dk_enterManually() {
	dk_debugFunc 0
	
	dk_call dk_info "Please type the name of the library, tool or app to build. Then press enter."
	dk_call dk_keyboardInput input
	
	target_app="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKINSTALL.cmake file  
	if test -f "${DKIMPORTS_DIR}/${input}/DKINSTALL.cmake"; then
		TARGET_PATH=${DKIMPORTS_DIR}/${input}
	fi
	if test -f "${DKCPP_PLUGINS_DIR}/${input}/DKINSTALL.cmake"; then
		TARGET_PATH=${DKCPP_PLUGINS_DIR}/${input}
	fi
	
	dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
	if test -f "${DKCPP_APPS_DIR}/${input}/DKINSTALL.cmake"; then
		TARGET_PATH=${DKCPP_APPS_DIR}/${input}
		return $(true)
	fi
	dk_call dk_printVar TARGET_PATH
	
	if [ ! -d "${DKCPP_APPS_DIR}/${target_app}" ]; then
		dk_call dk_makeDirectory "${DKCPP_APPS_DIR}/${target_app}";
	fi
	
	# create apps/<target_app>/DKINSTALL.cmake 
	dk_call dk_fileWrite "${DKCPP_APPS_DIR}/${target_app}/DKINSTALL.cmake" "dk_depend(${input})"
	
	# create apps/<target_app>/main.cpp
	dk_call dk_fileWrite "${DKCPP_APPS_DIR}/${target_app}/main.cpp" "int main(int argc, char** argv) { return 0; }"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_enterManually
}
