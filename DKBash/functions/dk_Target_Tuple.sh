#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


#####################################################################
# dk_Target_Tuple()
#
#	  Target_Tuple = TODO
#
dk_Target_Tuple() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_Tuple="${1}"
	
	###### GET ######	
	else
		[ -z "${Target_Os-}" ] 		&& dk_call dk_Target_Os
		[ -z "${Target_Arch-}" ]	&& dk_call dk_Target_Arch
		[ -z "${Target_Env-}" ] 	&& dk_call dk_Target_Env
		export Target_Tuple="${Target_Os}_${Target_Arch}_${Target_Env}"
	fi
	
	export ${Target_Tuple}_Target=1
	export ${Target_Tuple}=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Target_Tuple
	dk_call dk_printVar Target_Tuple
	dk_call dk_printVar ${Target_Tuple}_Target
	dk_call dk_printVar ${Target_Tuple}
	
	###### SET ######
	dk_call dk_Target_Tuple "Windows_X86_64_Clang"
	dk_call dk_printVar Target_Tuple
	dk_call dk_printVar ${Target_Tuple}_Target
	dk_call dk_printVar ${Target_Tuple}
	
}