#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_enterManually()
#
#
dk_enterManually (){
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_info "Please type the name of the library, tool or app to build. Then press enter."
	read input
	
	APP="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKMAKE.cmake file  
	if test -f "${DKIMPORTS_DIR}/${input}/DKMAKE.cmake"; then
		TARGET_PATH=${DKIMPORTS_DIR}/${input}
	fi
	if test -f "${DKPLUGINS_DIR}/${input}/DKMAKE.cmake"; then
		TARGET_PATH=${DKPLUGINS_DIR}/${input}
	fi
	if test -f "${DKAPPS_DIR}/${input}/DKMAKE.cmake"; then
		TARGET_PATH=${DKAPPS_DIR}/${input}
		return ${true}
	fi
	dk_printVar TARGET_PATH
	
	if [ ! -d "${DKAPPS_DIR}/${APP}" ]; then
		dk_makeDirectory "${DKAPPS_DIR}/${APP}";
	fi
	
	# create DKApps/<APP>/DKMAKE.cmake 
	dk_fileWrite "${DKAPPS_DIR}/${APP}/DKMAKE.cmake" "dk_depend(${input})"
	
	# create DKApps/<APP>/main.cpp
	dk_fileWrite "${DKAPPS_DIR}/${APP}/main.cpp" "int main(int argc, char** argv) { return 0; }"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
	dk_debugFunc
	
	dk_enterManually
}