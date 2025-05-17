#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


#####################################################################
# dk_Target_Os()
#
#	  Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#
dk_Target_Os() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		Target_Os="${1-}"
	
	###### GET ######	
	else
		echo " " 
		
		### if not defined Target_Os_Cache (dk_call dk_Target_Os_Cache)
		[ -n "${Target_Os_Cache-}" ] && echo  "0) ${Target_Os_Cache-}"
		echo " "
		[ -z "${Host_Os-}" ] && dk_call dk_Host_Os
		echo " 1) ${Host_Os}"
		echo " 2) Android"
		echo " 3) Cosmopolitan"
		echo " 4) Emscripten"
		echo " 5) Ios"
		echo " 6) Iossim"
		echo " 7) Linux"
		echo " 8) Mac"
		echo " 9) Raspberry"
		echo "10) Windows"
		echo " "

		dk_call dk_keyboardInput input
		
		  if [ "${input}" = "0" ]; then
			export Target_Os="${Target_Os_Cache}"
		elif [ "${input}" = "1" ]; then
			export Target_Os="${Host_Os}"
		elif [ "${input}" = "2" ]; then
			export Target_Os="Android"
		elif [ "${input}" = "3" ]; then
			export Target_Os="Cosmopolitan"
		elif [ "${input}" = "4" ]; then
			export Target_Os="Emscripten"
		elif [ "${input}" = "5" ]; then
			export Target_Os="Ios"
		elif [ "${input}" = "6" ]; then
			export Target_Os="Iossim"
		elif [ "${input}" = "7" ]; then
			export Target_Os="Linux"
		elif [ "${input}" = "8" ]; then
			export Target_Os="Mac"
		elif [ "${input}" = "9" ]; then
			export Target_Os="Raspberry"
		elif [ "${input}" = "10" ]; then
			export Target_Os="Windows"
		fi
	fi
	
	export ${Target_Os}_Target=1
	export ${Target_Os}=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Target_Os
	dk_call dk_printVar Target_Os
	dk_call dk_printVar ${Target_Os}_Target
	dk_call dk_printVar ${Target_Os}
	
	###### SET ######
	dk_call dk_Target_Os "Windows"
	dk_call dk_printVar Target_Os
	dk_call dk_printVar ${Target_Os}_Target
	dk_call dk_printVar ${Target_Os}
	
}