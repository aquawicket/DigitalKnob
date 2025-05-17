#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################

#####################################################################
# dk_Host_Tuple()
#
#
dk_Host_Tuple() {
	dk_debugFunc 0 1
 		
	###### SET ######
	if [ -n "${1-}" ]; then
		Host_Tuple="$1"
	
	###### GET ######	
	else
		[ -z "${Host_Os-}" ]	&& dk_call dk_Host_Os
		[ -z "${Host_Arch-}" ]	&& dk_call dk_Host_Arch
		Host_Tuple="${Host_Os-}_${Host_Arch-}"
	fi
	
	export ${Host_Tuple}_Host=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

    ###### GET ######
    dk_call dk_Host_Tuple
	dk_call dk_printVar Host_Tuple
	dk_call dk_printVar ${Host_Tuple}_Host
	
	###### SET ######
	dk_call dk_Host_Tuple "Linux_I686"
	dk_call dk_printVar Host_Tuple
	dk_call dk_printVar ${Host_Tuple}_Host
}