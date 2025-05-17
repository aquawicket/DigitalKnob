#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


[ -z ${Target_Env_Default-} ] && Target_Env_Default="Clang"
#####################################################################
# dk_Target_Env()
#
#	  Target_Env = Arm32, Arm64, X86, X86_64
#
dk_Target_Env() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		Target_Env="${1-}"
	
	###### GET ######	
	else
		echo " " 
		### if not defined Target_Env_Cache (dk_call dk_Target_Env_Cache)
		if [ -n "${Target_Env_Cache-}" ]; then
			echo  "0) ${Target_Env_Cache-}"
			echo " "
		fi
		echo " 1) ${Target_Env_Default}"
		echo " 2) Clang"
		echo " 3) Gcc"
		echo " 4) Msvc"
		echo " "

		dk_call dk_keyboardInput input
		
		  if [ "${input}" = "0" ]; then
			export Target_Env="${Target_Env_Cache}"
		elif [ "${input}" = "1" ]; then
			export Target_Env="${Target_Env_Default}"
		elif [ "${input}" = "2" ]; then
			export Target_Env="Clang"
		elif [ "${input}" = "3" ]; then
			export Target_Env="Gcc"
		elif [ "${input}" = "4" ]; then
			export Target_Env="Msvc"
		fi
	fi
	
	export ${Target_Env}_Target=1
	export ${Target_Env}=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Target_Env
	dk_call dk_printVar Target_Env
	dk_call dk_printVar ${Target_Env}_Target
	dk_call dk_printVar ${Target_Env}
	
	###### SET ######
	dk_call dk_Target_Env "Windows"
	dk_call dk_printVar Target_Env
	dk_call dk_printVar ${Target_Env}_Target
	dk_call dk_printVar ${Target_Env}	
}