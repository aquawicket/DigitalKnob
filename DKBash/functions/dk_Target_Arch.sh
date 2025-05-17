#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


#####################################################################
# dk_Target_Arch()
#
#	  Target_Os = Arm32, Arm64, X86, X86_64
#
dk_Target_Arch() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		Target_Arch="${1-}"
	
	###### GET ######	
	else
		echo " " 
		
		### if not defined Target_Arch_Cache (dk_call dk_Target_Arch_Cache)
		[ -n "${Target_Arch_Cache-}" ] && echo  "0) ${Target_Arch_Cache-}"
		echo " "
		[ -z "${Host_Arch-}" ] && dk_call dk_Host_Arch
		echo " 1) ${Host_Arch}"
		echo " 2) Arm32"
		echo " 3) Arm64"
		echo " 4) X86"
		echo " 5) X86_64"
		echo " "

		dk_call dk_keyboardInput input
		
		  if [ "${input}" = "0" ]; then
			export Target_Arch="${Target_Arch_Cache}"
		elif [ "${input}" = "1" ]; then
			export Target_Arch="${Host_Arch}"
		elif [ "${input}" = "2" ]; then
			export Target_Arch="Arm32"
		elif [ "${input}" = "3" ]; then
			export Target_Arch="Arm64"
		elif [ "${input}" = "4" ]; then
			export Target_Arch="X86"
		elif [ "${input}" = "5" ]; then
			export Target_Arch="X86_64"
		fi
	fi
	
	export ${Target_Os}_Target=1
	export ${Target_Os}=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Target_Arch
	dk_call dk_printVar Target_Arch
	dk_call dk_printVar ${Target_Arch}_Target
	dk_call dk_printVar ${Target_Arch}
	
	###### SET ######
	dk_call dk_Target_Arch "Windows"
	dk_call dk_printVar Target_Arch
	dk_call dk_printVar ${Target_Arch}_Target
	dk_call dk_printVar ${Target_Arch}	
}